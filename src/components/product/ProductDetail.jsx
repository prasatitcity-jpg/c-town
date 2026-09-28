import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { pb, formatPrice, getProductImageUrl } from '../../lib/pb';
import { useCart } from '../../contexts/CartContext';
import { useAuth } from '../../contexts/AuthContext';
import { ShoppingBag, Zap, Check, AlertTriangle, ShieldCheck } from 'lucide-react';

export default function ProductDetail({ productId }) {
  const [product, setProduct] = useState(null);
  const [variants, setVariants] = useState([]);
  const [selectedColor, setSelectedColor] = useState(null);
  const [selectedSize, setSelectedSize] = useState(null);
  const [selectedVariant, setSelectedVariant] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(true);
  const [addMsg, setAddMsg] = useState('');
  const { addToCart } = useCart();
  const { isLoggedIn } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (!productId) return;
    (async () => {
      setLoading(true);
      try {
        const prod = await pb.collection('products').getOne(productId, {
          expand: 'brand,category',
        });
        const vars = await pb.collection('product_variants').getList(1, 200, {
          filter: `product = "${productId}" && status = "active"`,
        });
        setProduct(prod);
        setVariants(vars.items);

        // Pre-select first color and first in-stock variant
        if (vars.items.length > 0) {
          const firstInStock = vars.items.find(v => (v.stock_quantity || 0) > 0) || vars.items[0];
          setSelectedColor(firstInStock.color);
          setSelectedSize(firstInStock.size);
          setSelectedVariant(firstInStock);
        }
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    })();
  }, [productId]);

  // Unique colors
  const uniqueColors = [];
  const seenColors = new Set();
  for (const v of variants) {
    if (!seenColors.has(v.color)) {
      seenColors.add(v.color);
      uniqueColors.push({
        color: v.color,
        color_code: v.color_code,
        image_url: v.image_url,
        variant_id: v.id,
      });
    }
  }

  // Sizes for selected color
  const sizesForColor = selectedColor
    ? variants.filter(v => v.color === selectedColor).sort((a, b) => parseFloat(a.size) - parseFloat(b.size))
    : variants.slice().sort((a, b) => parseFloat(a.size) - parseFloat(b.size));

  // Update selectedVariant when color or size changes
  const handleSelectColor = (color) => {
    setSelectedColor(color);
    const availableSizes = variants.filter(v => v.color === color);
    const sameSize = availableSizes.find(v => v.size === selectedSize);
    const nextVariant = sameSize || availableSizes[0];
    if (nextVariant) {
      setSelectedSize(nextVariant.size);
      setSelectedVariant(nextVariant);
    }
  };

  const handleSelectSize = (size) => {
    setSelectedSize(size);
    const found = variants.find(v => v.color === selectedColor && v.size === size);
    if (found) {
      setSelectedVariant(found);
    }
  };

  // Current display image
  const displayImage = selectedVariant?.image_url ||
    uniqueColors.find(uc => uc.color === selectedColor)?.image_url ||
    getProductImageUrl(variants[0]);

  // Prices
  const currentSellingPrice = selectedVariant?.selling_price || product?.base_price || 0;
  const currentSalePrice = selectedVariant?.sale_price || 0;
  const hasSale = currentSalePrice > 0 && currentSalePrice < currentSellingPrice;
  const effectivePrice = hasSale ? currentSalePrice : currentSellingPrice;

  // Stock
  const currentStock = selectedVariant ? (Number(selectedVariant.stock_quantity) || 0) : 0;
  const totalStockAll = variants.reduce((sum, v) => sum + (Number(v.stock_quantity) || 0), 0);
  const isOutOfStock = selectedVariant ? currentStock <= 0 : totalStockAll <= 0;

  const handleAddToCart = async (buyNow = false) => {
    if (!isLoggedIn) {
      navigate('/login');
      return;
    }
    const targetVar = selectedVariant || variants[0];
    if (!targetVar) {
      setAddMsg('❌ กรุณาเลือกสีและไซซ์สินค้า');
      return;
    }

    const result = await addToCart(product, targetVar, quantity);
    if (result?.needsLogin) {
      navigate('/login');
      return;
    }
    if (result?.error) {
      setAddMsg('❌ ' + result.error);
      setTimeout(() => setAddMsg(''), 3000);
      return;
    }

    setAddMsg('✅ เพิ่มลงในตะกร้าสินค้าสำเร็จ!');
    setTimeout(() => setAddMsg(''), 2500);
    if (buyNow) navigate('/cart');
  };

  if (loading) return <div className="detail-loading"><div className="spinner" /></div>;
  if (!product) return <div className="detail-error">ไม่พบสินค้าที่ต้องการ</div>;

  return (
    <div className="product-detail">
      {/* Left: Images */}
      <div className="detail-images">
        <div className="detail-main-image-wrap">
          <img
            src={displayImage}
            alt={product.name}
            className="detail-main-image"
            onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
          />
        </div>
        {uniqueColors.length > 1 && (
          <div className="detail-thumbnails">
            {uniqueColors.map(uc => (
              <button
                key={uc.color}
                type="button"
                className={`detail-thumb ${selectedColor === uc.color ? 'active' : ''}`}
                onClick={() => handleSelectColor(uc.color)}
              >
                <img
                  src={uc.image_url || '/images/products/placeholder.jpg'}
                  alt={uc.color}
                  onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                />
              </button>
            ))}
          </div>
        )}
      </div>

      {/* Right: Info, Price, Stock & Options */}
      <div className="detail-info">
        {product.expand?.brand && (
          <span className="detail-brand">{product.expand.brand.name}</span>
        )}
        <h1 className="detail-product-name">{product.name}</h1>
        {product.expand?.category && (
          <span className="detail-category">{product.expand.category.name}</span>
        )}

        {/* Badges */}
        <div className="detail-badges">
          {product.is_new && <span className="badge badge-new">NEW ARRIVAL</span>}
          {product.is_bestseller && <span className="badge badge-hot">🔥 BESTSELLER</span>}
          <span className="badge badge-auth"><ShieldCheck size={12} /> ของแท้ 100%</span>
        </div>

        {/* Price Box */}
        <div className="detail-price-box">
          <span className="detail-price-label">ราคาจำหน่าย:</span>
          <div className="detail-price-wrap">
            {hasSale ? (
              <>
                <span className="detail-price-sale">{formatPrice(currentSalePrice)}</span>
                <span className="detail-price-original">{formatPrice(currentSellingPrice)}</span>
                <span className="save-badge">ประหยัด {formatPrice(currentSellingPrice - currentSalePrice)}</span>
              </>
            ) : (
              <span className="detail-price-main">{formatPrice(effectivePrice)}</span>
            )}
          </div>
        </div>

        {/* Color Selection */}
        <div className="detail-option-group">
          <label className="detail-option-label">
            เลือกสี: <strong>{selectedColor || '—'}</strong>
          </label>
          <div className="color-options">
            {uniqueColors.map(uc => (
              <button
                key={uc.color}
                type="button"
                className={`color-option ${selectedColor === uc.color ? 'selected' : ''}`}
                onClick={() => handleSelectColor(uc.color)}
                title={uc.color}
              >
                <span
                  className="color-dot"
                  style={{ backgroundColor: uc.color_code || '#ccc' }}
                />
                <span className="color-name">{uc.color}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Size Selection */}
        <div className="detail-option-group">
          <label className="detail-option-label">
            เลือกไซซ์รองเท้า (EU): <strong>{selectedSize ? `ไซซ์ ${selectedSize}` : '—'}</strong>
          </label>
          <div className="size-options">
            {sizesForColor.map(v => {
              const outOfStock = (Number(v.stock_quantity) || 0) <= 0;
              const isSelected = selectedSize === v.size;
              return (
                <button
                  key={v.size}
                  type="button"
                  className={`size-option ${isSelected ? 'selected' : ''} ${outOfStock ? 'out-of-stock' : ''}`}
                  onClick={() => !outOfStock && handleSelectSize(v.size)}
                  disabled={outOfStock}
                  title={outOfStock ? `ไซซ์ ${v.size} (สินค้าหมด)` : `ไซซ์ ${v.size} (เหลือ ${v.stock_quantity} คู่)`}
                >
                  <span className="size-number">{v.size}</span>
                  <span className="size-stock-hint">
                    {outOfStock ? 'หมด' : `(${v.stock_quantity})`}
                  </span>
                </button>
              );
            })}
          </div>
        </div>

        {/* Realtime Stock Display */}
        <div className="detail-stock-box">
          <div className="stock-status-row">
            <span className="stock-label">จำนวนสินค้าคงเหลือ:</span>
            {selectedVariant ? (
              currentStock > 0 ? (
                <span className="stock-count-indicator green">
                  <Check size={16} /> มีสินค้าพร้อมส่ง <strong>{currentStock}</strong> คู่
                </span>
              ) : (
                <span className="stock-count-indicator red">
                  <AlertTriangle size={16} /> ไซซ์นี้สินค้าหมดชั่วคราว
                </span>
              )
            ) : (
              <span className="stock-count-indicator green">
                มีสินค้ารวมทั้งหมด {totalStockAll} คู่
              </span>
            )}
          </div>
        </div>

        {/* Quantity Selector - ALWAYS VISIBLE */}
        <div className="detail-option-group">
          <label className="detail-option-label">จำนวนที่ต้องการสั่งซื้อ:</label>
          <div className="qty-row">
            <div className="qty-selector">
              <button
                type="button"
                className="qty-btn"
                onClick={() => setQuantity(q => Math.max(1, q - 1))}
                disabled={quantity <= 1 || isOutOfStock}
              >−</button>
              <span className="qty-value">{quantity}</span>
              <button
                type="button"
                className="qty-btn"
                onClick={() => setQuantity(q => Math.min(Math.max(1, currentStock), q + 1))}
                disabled={quantity >= currentStock || isOutOfStock}
              >+</button>
            </div>
            <span className="qty-unit-label">คู่</span>
            {selectedVariant && currentStock > 0 && (
              <span className="stock-limit-note">(สั่งซื้อได้สูงสุด {currentStock} คู่)</span>
            )}
          </div>
        </div>

        {/* Action Buttons */}
        <div className="detail-actions">
          <button
            type="button"
            className="btn-add-cart"
            onClick={() => handleAddToCart(false)}
            disabled={isOutOfStock}
            id="btn-add-to-cart"
          >
            <ShoppingBag size={18} /> {isOutOfStock ? 'สินค้าหมด' : 'เพิ่มลงตะกร้า'}
          </button>
          <button
            type="button"
            className="btn-buy-now"
            onClick={() => handleAddToCart(true)}
            disabled={isOutOfStock}
            id="btn-buy-now"
          >
            <Zap size={18} /> {isOutOfStock ? 'สินค้าหมด' : 'ซื้อทันที'}
          </button>
        </div>

        {addMsg && (
          <div className={`action-message ${addMsg.startsWith('❌') ? 'error' : 'success'}`}>
            {addMsg}
          </div>
        )}

        {/* Description */}
        {product.description && (
          <div className="detail-description">
            <h3>รายละเอียดสินค้า</h3>
            <p>{product.description}</p>
          </div>
        )}

        {/* SKU */}
        {selectedVariant && (
          <div className="detail-sku">
            รหัสสินค้า (SKU): <code>{selectedVariant.sku}</code>
          </div>
        )}
      </div>
    </div>
  );
}
