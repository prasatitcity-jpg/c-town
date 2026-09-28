import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ShoppingBag, Star, Zap } from 'lucide-react';
import { useCart } from '../../contexts/CartContext';
import { useAuth } from '../../contexts/AuthContext';
import { pb, getProductImageUrl, formatPrice } from '../../lib/pb';

export default function ProductCard({ product, variants: propVariants = [] }) {
  const { addToCart } = useCart();
  const { isLoggedIn } = useAuth();
  const navigate = useNavigate();
  const [variants, setVariants] = useState(propVariants);
  const [addingToCart, setAddingToCart] = useState(false);
  const [addedMsg, setAddedMsg] = useState('');

  // If variants not passed or empty, fetch them
  useEffect(() => {
    if (propVariants && propVariants.length > 0) {
      setVariants(propVariants);
    } else if (product?.id) {
      pb.collection('product_variants').getList(1, 50, {
        filter: `product = "${product.id}" && status = "active"`,
      }).then(res => {
        setVariants(res.items);
      }).catch(() => {});
    }
  }, [propVariants, product?.id]);

  // Unique colors
  const uniqueColors = [];
  const seen = new Set();
  for (const v of variants) {
    if (!seen.has(v.color)) {
      seen.add(v.color);
      uniqueColors.push(v);
    }
  }

  const firstVariant = variants[0];
  const displayImage = getProductImageUrl(firstVariant);

  // Price calculation
  const prices = variants.map(v => v.selling_price).filter(p => p > 0);
  const minPrice = prices.length > 0 ? Math.min(...prices) : (product.base_price || 0);
  const maxPrice = prices.length > 0 ? Math.max(...prices) : (product.base_price || 0);

  const salePrices = variants.filter(v => v.sale_price && v.sale_price > 0).map(v => v.sale_price);
  const minSalePrice = salePrices.length > 0 ? Math.min(...salePrices) : 0;
  const hasSale = minSalePrice > 0 && minSalePrice < minPrice;

  // Total stock calculation
  const totalStock = variants.reduce((sum, v) => sum + (Number(v.stock_quantity) || 0), 0);
  const inStock = totalStock > 0 || variants.length === 0;

  const handleQuickAdd = async (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (!isLoggedIn) { navigate('/login'); return; }
    if (!firstVariant) return;

    setAddingToCart(true);
    const result = await addToCart(product, firstVariant, 1);
    setAddingToCart(false);

    if (result?.needsLogin) { navigate('/login'); return; }
    if (result?.error) {
      setAddedMsg('❌ ' + result.error);
    } else {
      setAddedMsg('✅ เพิ่มลงตะกร้าแล้ว!');
    }
    setTimeout(() => setAddedMsg(''), 2000);
  };

  return (
    <div className="product-card" data-id={product.id}>
      <Link to={`/products/${product.id}`} className="product-card-link">
        {/* Image */}
        <div className="product-card-image-wrap">
          <img
            src={displayImage}
            alt={product.name}
            className="product-card-image"
            onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
          />
          {/* Badges */}
          <div className="product-card-badges">
            {product.is_new && <span className="badge badge-new">NEW</span>}
            {product.is_bestseller && <span className="badge badge-hot">🔥 HOT</span>}
            {hasSale && <span className="badge badge-sale">SALE</span>}
          </div>

          {/* Quick Add overlay */}
          <div className="product-card-overlay">
            <button
              type="button"
              className="overlay-quick-add"
              onClick={handleQuickAdd}
              disabled={addingToCart || (!inStock && variants.length > 0)}
              id={`quick-add-${product.id}`}
            >
              {addingToCart ? '...' : <><ShoppingBag size={15} /> เพิ่มลงตะกร้า</>}
            </button>
          </div>
          {!inStock && variants.length > 0 && <div className="out-of-stock-overlay">สินค้าหมด</div>}
        </div>

        {/* Info */}
        <div className="product-card-info">
          {product.expand?.brand && (
            <span className="product-card-brand">{product.expand.brand.name}</span>
          )}
          <h3 className="product-card-name">{product.name}</h3>

          {/* Color swatches */}
          {uniqueColors.length > 1 && (
            <div className="product-card-colors">
              {uniqueColors.slice(0, 5).map(v => (
                <span
                  key={v.id}
                  className="color-swatch-small"
                  style={{ backgroundColor: v.color_code || '#ccc' }}
                  title={v.color}
                />
              ))}
              {uniqueColors.length > 5 && (
                <span className="color-more">+{uniqueColors.length - 5}</span>
              )}
            </div>
          )}

          {/* Price display with explicit label */}
          <div className="product-card-price-row">
            <div className="product-card-price">
              {hasSale ? (
                <>
                  <span className="price-sale">{formatPrice(minSalePrice)}</span>
                  <span className="price-original">{formatPrice(minPrice)}</span>
                </>
              ) : (
                <span className="price-regular">{formatPrice(minPrice)}</span>
              )}
            </div>
          </div>

          {/* Stock quantity display */}
          <div className="product-card-stock-row">
            {totalStock > 0 ? (
              <span className="stock-pill stock-available">
                <span className="stock-dot green" /> คงเหลือ <strong>{totalStock}</strong> คู่
              </span>
            ) : variants.length === 0 ? (
              <span className="stock-pill stock-available">
                <span className="stock-dot green" /> มีสินค้าพร้อมส่ง
              </span>
            ) : (
              <span className="stock-pill stock-empty">
                <span className="stock-dot red" /> สินค้าหมดชั่วคราว
              </span>
            )}
          </div>
        </div>
      </Link>

      {/* Add to Cart Message */}
      {addedMsg && (
        <div className="cart-toast">
          {addedMsg}
        </div>
      )}
    </div>
  );
}
