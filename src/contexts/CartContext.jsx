import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { pb } from '../lib/pb';
import { useAuth } from './AuthContext';

const CartContext = createContext(null);
const LOCAL_CART_KEY = 'ctown_cart_storage';

function getLocalCart() {
  try {
    const raw = localStorage.getItem(LOCAL_CART_KEY);
    if (raw) return JSON.parse(raw);
  } catch (_) {}
  return [];
}

function saveLocalCart(items) {
  try {
    localStorage.setItem(LOCAL_CART_KEY, JSON.stringify(items));
  } catch (_) {}
}

export function CartProvider({ children }) {
  const { user, isLoggedIn } = useAuth();
  const [cartItems, setCartItems] = useState([]);
  const [cartId, setCartId] = useState(null);
  const [loading, setLoading] = useState(false);

  const loadCart = useCallback(async () => {
    try {
      setLoading(true);
      let list = [];

      if (isLoggedIn && user?.id) {
        try {
          const res = await pb.collection('cart_items').getList(1, 200, {
            filter: `user = "${user.id}"`,
            expand: 'variant,product',
          });
          list = res.items || [];
        } catch (_) {}
      }

      // If empty or guest, use local cart
      if (list.length === 0) {
        const local = getLocalCart();
        if (local && local.length > 0) {
          list = local;
        }
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
    // Check stock
    const availableStock = Number(variant.stock_quantity ?? variant.stock) || 0;
    if (availableStock < quantity) {
      return { error: `สินค้าคงเหลือไม่เพียงพอ (เหลือ ${availableStock} คู่)` };
    }

    // Check existing item in cart
    const existingIdx = cartItems.findIndex(ci => ci.variant === variant.id);
    const existing = existingIdx !== -1 ? cartItems[existingIdx] : null;
    const currentQty = existing ? existing.quantity : 0;

    if (currentQty + quantity > availableStock) {
      return { error: `ไม่สามารถเพิ่มได้ มีในตะกร้าแล้ว ${currentQty} คู่ คงเหลือ ${availableStock} คู่` };
    }

    const unitPrice = variant.sale_price || variant.selling_price || product.base_price;

    // Handle Logged-In User with DB persistence
    if (isLoggedIn && user?.id) {
      try {
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
          } catch (_) {
            const cart = await pb.collection('carts').create({ user: user.id, status: 'active' });
            cid = cart.id;
          }
          setCartId(cid);
        }

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
        console.warn('DB cart failed, falling back to local cart:', err);
      }
    }

    // Local Storage / Guest Cart Handling
    const updated = [...cartItems];
    if (existingIdx !== -1) {
      updated[existingIdx] = {
        ...updated[existingIdx],
        quantity: currentQty + quantity,
        unit_price: unitPrice
      };
    } else {
      const newItem = {
        id: 'cart_' + Math.random().toString(36).slice(2, 10),
        variant: variant.id,
        product: product.id,
        quantity,
        unit_price: unitPrice,
        expand: {
          product,
          variant
        }
      };
      updated.push(newItem);
    }

    setCartItems(updated);
    saveLocalCart(updated);
    return { success: true };
  }, [isLoggedIn, user, cartId, cartItems, loadCart]);

  const updateQuantity = useCallback(async (cartItemId, newQty) => {
    if (isLoggedIn && user?.id) {
      try {
        if (newQty <= 0) {
          await pb.collection('cart_items').delete(cartItemId);
        } else {
          await pb.collection('cart_items').update(cartItemId, { quantity: newQty });
        }
        await loadCart();
        return;
      } catch (_) {}
    }

    // Local cart update
    let updated;
    if (newQty <= 0) {
      updated = cartItems.filter(ci => ci.id !== cartItemId);
    } else {
      updated = cartItems.map(ci => ci.id === cartItemId ? { ...ci, quantity: newQty } : ci);
    }
    setCartItems(updated);
    saveLocalCart(updated);
  }, [isLoggedIn, user, cartItems, loadCart]);

  const removeFromCart = useCallback(async (cartItemId) => {
    if (isLoggedIn && user?.id) {
      try {
        await pb.collection('cart_items').delete(cartItemId);
        await loadCart();
        return;
      } catch (_) {}
    }

    const updated = cartItems.filter(ci => ci.id !== cartItemId);
    setCartItems(updated);
    saveLocalCart(updated);
  }, [isLoggedIn, user, cartItems, loadCart]);

  const clearCart = useCallback(() => {
    setCartItems([]);
    saveLocalCart([]);
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
