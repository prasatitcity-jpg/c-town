import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { pb } from '../lib/pb';
import { useAuth } from './AuthContext';

const CartContext = createContext(null);

export function CartProvider({ children }) {
  const { user, isLoggedIn } = useAuth();
  const [cartItems, setCartItems] = useState([]);
  const [cartId, setCartId] = useState(null);
  const [loading, setLoading] = useState(false);

  const loadCart = useCallback(async () => {
    try {
      setLoading(true);
      let list = [];
      if (isLoggedIn && user) {
        const res = await pb.collection('cart_items').getList(1, 200, {
          filter: `user = "${user.id}"`,
          expand: 'variant,product',
        });
        list = res.items || [];
      }
      
      // Fallback: If cart is empty, show starter sneakers
      if (list.length === 0) {
        const defaultItems = await pb.collection('cart_items').getList(1, 200, {
          expand: 'variant,product',
        });
        list = defaultItems.items || [];
      }

      setCartItems(list);
    } catch (err) {
      console.error('Load cart error:', err);
    } finally {
      setLoading(false);
    }
  }, [user, isLoggedIn]);

  useEffect(() => { loadCart(); }, [loadCart]);

  const addToCart = useCallback(async (product, variant, quantity = 1) => {
    if (!isLoggedIn) return { needsLogin: true };
    
    // Check stock
    if ((variant.stock_quantity || 0) < quantity) {
      return { error: `สินค้าคงเหลือไม่เพียงพอ (เหลือ ${variant.stock_quantity} คู่)` };
    }

    // Check if same variant already exists in cart
    const existing = cartItems.find(ci => ci.variant === variant.id);
    const currentQty = existing ? existing.quantity : 0;
    
    if (currentQty + quantity > (variant.stock_quantity || 0)) {
      return { error: `ไม่สามารถเพิ่มได้ มีสินค้าในตะกร้าแล้ว ${currentQty} คู่ คงเหลือ ${variant.stock_quantity} คู่` };
    }

    try {
      // Get or create cart
      let cid = cartId;
      if (!cid) {
        try {
          const carts = await pb.collection('carts').getList(1, 1, {
            filter: `user = "${user.id}" && status = "active"`,
          });
          if (carts.items.length > 0) {
            cid = carts.items[0].id;
          } else {
            const cart = await pb.collection('carts').create({ user: user.id, status: 'active' });
            cid = cart.id;
          }
          setCartId(cid);
        } catch (_) {
          const cart = await pb.collection('carts').create({ user: user.id, status: 'active' });
          cid = cart.id;
          setCartId(cid);
        }
      }

      const unitPrice = variant.sale_price || variant.selling_price;

      if (existing) {
        await pb.collection('cart_items').update(existing.id, { quantity: currentQty + quantity });
      } else {
        await pb.collection('cart_items').create({
          cart: cid,
          user: user.id,
          variant: variant.id,
          product: product.id,
          quantity,
          unit_price: unitPrice,
        });
      }
      await loadCart();
      return { success: true };
    } catch (err) {
      return { error: err.message || 'ไม่สามารถเพิ่มสินค้าลงตะกร้าได้' };
    }
  }, [isLoggedIn, user, cartId, cartItems, loadCart]);

  const updateQuantity = useCallback(async (cartItemId, newQty) => {
    if (newQty <= 0) {
      await pb.collection('cart_items').delete(cartItemId);
    } else {
      await pb.collection('cart_items').update(cartItemId, { quantity: newQty });
    }
    await loadCart();
  }, [loadCart]);

  const removeFromCart = useCallback(async (cartItemId) => {
    await pb.collection('cart_items').delete(cartItemId);
    await loadCart();
  }, [loadCart]);

  const clearCart = useCallback(() => {
    setCartItems([]);
  }, []);

  const totalItems = cartItems.reduce((sum, ci) => sum + (ci.quantity || 0), 0);
  const subtotal = cartItems.reduce((sum, ci) => {
    const price = ci.expand?.variant?.sale_price || ci.expand?.variant?.selling_price || ci.unit_price || 0;
    return sum + price * ci.quantity;
  }, 0);

  return (
    <CartContext.Provider value={{ cartItems, cartId, loading, loadCart, addToCart, updateQuantity, removeFromCart, clearCart, totalItems, subtotal }}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const ctx = useContext(CartContext);
  if (!ctx) throw new Error('useCart must be used inside CartProvider');
  return ctx;
}
