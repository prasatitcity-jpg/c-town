import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCart } from '../../contexts/CartContext';
import { useAuth } from '../../contexts/AuthContext';
import { formatPrice, getProductImageUrl } from '../../lib/pb';
import { Trash2, Plus, Minus, ShoppingBag, ArrowRight } from 'lucide-react';

export default function CartPage() {
  const { cartItems, loading, updateQuantity, removeFromCart, subtotal } = useCart();
  const { isLoggedIn } = useAuth();
  const navigate = useNavigate();

  if (loading) return <div className="cart-loading"><div className="spinner" /></div>;

  if (cartItems.length === 0) {
    return (
      <div className="cart-empty-page">
        <ShoppingBag size={64} strokeWidth={1} />
        <h2>ตะกร้าสินค้าว่างเปล่า</h2>
        <p>เพิ่มสินค้าที่คุณชอบลงในตะกร้าได้เลย!</p>
        <Link to="/products" className="btn-primary" id="btn-shop-from-cart">เลือกซื้อสินค้า</Link>
      </div>
    );
  }

  const shippingFee = subtotal >= 2500 ? 0 : 60;
  const grandTotal = subtotal + shippingFee;

  const handleCheckout = () => {
    if (!isLoggedIn) {
      navigate('/login?redirect=/checkout');
    } else {
      navigate('/checkout');
    }
  };

  return (
    <div className="cart-page">
      {!isLoggedIn && (
        <div style={{ background: '#EFF6FF', border: '1px solid #BFDBFE', padding: '12px 18px', borderRadius: '10px', marginBottom: '24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span style={{ color: '#1E40AF', fontSize: '14px' }}>💡 คุณกำลังดูรายการสินค้าในตะกร้า — เข้าสู่ระบบเพื่อดำเนินการสั่งซื้อและสะสมคะแนน</span>
          <Link to="/login?redirect=/cart" className="btn-secondary btn-sm" style={{ whiteSpace: 'nowrap' }}>เข้าสู่ระบบ</Link>
        </div>
      )}
      <h1 className="cart-page-title">ตะกร้าสินค้า</h1>

      <div className="cart-layout">
        {/* Cart Items */}
        <div className="cart-items-list">
          {cartItems.map(item => {
            const variant = item.expand?.variant || {};
            const product = item.expand?.product || {};
            const image = variant.image_url || '/images/products/placeholder.jpg';
            const price = variant.sale_price || variant.selling_price || item.unit_price || 0;
            const lineTotal = price * item.quantity;

            return (
              <div key={item.id} className="cart-item" id={`cart-item-${item.id}`}>
                <Link to={`/products/${product.id || ''}`}>
                  <img
                    src={image}
                    alt={product.name}
                    className="cart-item-image"
                    onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                  />
                </Link>
                <div className="cart-item-details">
                  <Link to={`/products/${product.id || ''}`} className="cart-item-name">
                    {product.name}
                  </Link>
                  <div className="cart-item-meta">
                    <span>สี: {variant.color}</span>
                    <span>ไซซ์: {variant.size}</span>
                    <span className="cart-item-sku">SKU: {variant.sku}</span>
                  </div>
                  <div className="cart-item-price">{formatPrice(price)}</div>
                </div>
                <div className="cart-item-controls">
                  <div className="qty-control">
                    <button
                      className="qty-btn-sm"
                      onClick={() => updateQuantity(item.id, item.quantity - 1)}
                      disabled={item.quantity <= 1}
                      id={`qty-dec-${item.id}`}
                    ><Minus size={12} /></button>
                    <span className="qty-display">{item.quantity}</span>
                    <button
                      className="qty-btn-sm"
                      onClick={() => updateQuantity(item.id, item.quantity + 1)}
                      disabled={item.quantity >= (variant.stock_quantity || 99)}
                      id={`qty-inc-${item.id}`}
                    ><Plus size={12} /></button>
                  </div>
                  <div className="cart-item-line-total">{formatPrice(lineTotal)}</div>
                  <button
                    className="remove-btn"
                    onClick={() => removeFromCart(item.id)}
                    id={`remove-${item.id}`}
                  ><Trash2 size={16} /></button>
                </div>
              </div>
            );
          })}
        </div>

        {/* Order Summary */}
        <div className="cart-summary">
          <h3 className="summary-title">สรุปคำสั่งซื้อ</h3>
          <div className="summary-row">
            <span>ราคาสินค้า</span>
            <span>{formatPrice(subtotal)}</span>
          </div>
          <div className="summary-row">
            <span>ค่าจัดส่ง</span>
            <span>{shippingFee === 0 ? <span className="free-ship">ฟรี</span> : formatPrice(shippingFee)}</span>
          </div>
          {shippingFee > 0 && (
            <div className="free-ship-hint">
              ซื้อเพิ่ม {formatPrice(2500 - subtotal)} เพื่อรับค่าจัดส่งฟรี!
            </div>
          )}
          <div className="summary-divider" />
          <div className="summary-row summary-total">
            <span>ยอดรวมทั้งหมด</span>
            <span className="total-amount">{formatPrice(grandTotal)}</span>
          </div>

          <button
            className="btn-checkout"
            onClick={handleCheckout}
            id="btn-goto-checkout"
          >
            {isLoggedIn ? 'ดำเนินการชำระเงิน' : 'เข้าสู่ระบบเพื่อสั่งซื้อ'} <ArrowRight size={16} />
          </button>

          <Link to="/products" className="btn-continue-shopping" id="btn-continue-shopping">
            ← เลือกซื้อสินค้าเพิ่ม
          </Link>
        </div>
      </div>
    </div>
  );
}
