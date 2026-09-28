import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { pb, formatPrice, getProductImageUrl } from '../../lib/pb';
import ProductCard from '../../components/product/ProductCard';
import { ArrowRight, Star, Shield, Truck, RotateCcw, ChevronRight } from 'lucide-react';

const HERO_IMAGES = [
  { src: '/images/products/nike_af1_pink.jpg', label: 'Nike Air Force 1 Rose Pink' },
  { src: '/images/products/adidas_samba_white.jpg', label: 'Adidas Samba OG' },
  { src: '/images/products/jordan1_rose_gold.jpg', label: 'Jordan 1 Rose Gold' },
];

export default function HomePage() {
  const [bestSellers, setBestSellers] = useState([]);
  const [newArrivals, setNewArrivals] = useState([]);
  const [variantsByProduct, setVariantsByProduct] = useState({});
  const [heroIdx, setHeroIdx] = useState(0);
  const [loading, setLoading] = useState(true);
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    (async () => {
      setLoading(true);
      try {
        // Fetch categories
        const cats = await pb.collection('categories').getList(1, 10, { filter: 'is_active = true' });
        setCategories(cats.items);

        // Fetch all active variants once
        const allVariants = await pb.collection('product_variants').getFullList({
          filter: 'status = "active"',
        });
        const varMap = {};
        for (const v of allVariants) {
          if (!varMap[v.product]) varMap[v.product] = [];
          varMap[v.product].push(v);
        }
        setVariantsByProduct(varMap);

        // Best sellers
        const bs = await pb.collection('products').getList(1, 8, {
          filter: 'status = "active" && is_bestseller = true',
          expand: 'brand,category',
        });
        setBestSellers(bs.items);

        // New arrivals
        const na = await pb.collection('products').getList(1, 8, {
          filter: 'status = "active" && is_new = true',
          expand: 'brand,category',
        });
        setNewArrivals(na.items);
      } catch (err) {
        console.error('HomePage load error:', err);
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  // Hero rotation
  useEffect(() => {
    const interval = setInterval(() => {
      setHeroIdx(i => (i + 1) % HERO_IMAGES.length);
    }, 4000);
    return () => clearInterval(interval);
  }, []);

  const CAT_ICONS = { men: '👟', women: '👠', unisex: '✨', streetwear: '🔥', 'performance-sports': '⚡', 'new-arrivals': '🆕', 'best-sellers': '⭐' };

  return (
    <div className="home-page">
      {/* HERO SECTION */}
      <section className="hero-section">
        <div className="hero-content">
          <div className="hero-text">
            <div className="hero-badge">🌸 Premium Streetwear</div>
            <h1 className="hero-title">
              <span className="hero-title-c">C</span>-TOWN
            </h1>
            <p className="hero-subtitle">SNEAKER STORE</p>
            <p className="hero-tagline">Step Into Your Style</p>
            <p className="hero-desc">
              คัดสรรรองเท้าผ้าใบพรีเมียมจากแบรนด์ระดับโลก
              <br />สินค้าแท้ 100% | จัดส่งทั่วประเทศ
            </p>
            <div className="hero-actions">
              <Link to="/products" className="btn-hero-primary" id="btn-shop-now">
                ช้อปเลย <ArrowRight size={18} />
              </Link>
              <Link to="/products?bestseller=1" className="btn-hero-secondary" id="btn-bestseller">
                สินค้าขายดี
              </Link>
            </div>
          </div>
          <div className="hero-image-wrap">
            {HERO_IMAGES.map((img, idx) => (
              <img
                key={img.src}
                src={img.src}
                alt={img.label}
                className={`hero-shoe-image${heroIdx === idx ? ' active' : ''}`}
                onError={e => { e.target.style.display = 'none'; }}
              />
            ))}
            <div className="hero-image-dots">
              {HERO_IMAGES.map((_, idx) => (
                <button
                  key={idx}
                  className={`hero-dot${heroIdx === idx ? ' active' : ''}`}
                  onClick={() => setHeroIdx(idx)}
                />
              ))}
            </div>
          </div>
        </div>
        <div className="hero-wave" />
      </section>

      {/* FEATURES */}
      <section className="features-section">
        <div className="features-grid">
          {[
            { icon: <Truck size={22} />, title: 'จัดส่งฟรี', desc: 'เมื่อซื้อครบ ฿2,500' },
            { icon: <Shield size={22} />, title: 'สินค้าแท้ 100%', desc: 'รับประกันคุณภาพจากแบรนด์' },
            { icon: <RotateCcw size={22} />, title: 'คืนสินค้าง่าย', desc: 'ภายใน 7 วัน' },
            { icon: <Star size={22} />, title: 'Premium Service', desc: 'บริการลูกค้า 10:00–21:00' },
          ].map((f, i) => (
            <div key={i} className="feature-card">
              <div className="feature-icon">{f.icon}</div>
              <div>
                <h4 className="feature-title">{f.title}</h4>
                <p className="feature-desc">{f.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* CATEGORIES */}
      <section className="section categories-section">
        <div className="section-header">
          <h2 className="section-title">หมวดหมู่สินค้า</h2>
        </div>
        <div className="categories-grid">
          {categories.map(cat => (
            <Link
              key={cat.id}
              to={`/products?category=${cat.slug}`}
              className="category-card"
              id={`cat-${cat.slug}`}
            >
              <span className="cat-icon">{CAT_ICONS[cat.slug] || '👟'}</span>
              <span className="cat-name">{cat.name}</span>
            </Link>
          ))}
        </div>
      </section>

      {/* BEST SELLERS */}
      {bestSellers.length > 0 && (
        <section className="section products-section">
          <div className="section-header">
            <h2 className="section-title">🔥 สินค้าขายดี</h2>
            <Link to="/products?bestseller=1" className="section-see-all" id="link-bestseller-all">
              ดูทั้งหมด <ChevronRight size={16} />
            </Link>
          </div>
          {loading ? (
            <div className="products-loading"><div className="spinner" /></div>
          ) : (
            <div className="products-grid">
              {bestSellers.map(product => (
                <ProductCard
                  key={product.id}
                  product={product}
                  variants={variantsByProduct[product.id] || []}
                />
              ))}
            </div>
          )}
        </section>
      )}

      {/* NEW ARRIVALS */}
      {newArrivals.length > 0 && (
        <section className="section products-section alt-bg">
          <div className="section-header">
            <h2 className="section-title">✨ สินค้ามาใหม่</h2>
            <Link to="/products?new=1" className="section-see-all" id="link-new-all">
              ดูทั้งหมด <ChevronRight size={16} />
            </Link>
          </div>
          {loading ? (
            <div className="products-loading"><div className="spinner" /></div>
          ) : (
            <div className="products-grid">
              {newArrivals.map(product => (
                <ProductCard
                  key={product.id}
                  product={product}
                  variants={variantsByProduct[product.id] || []}
                />
              ))}
            </div>
          )}
        </section>
      )}

      {/* PROMO BANNER */}
      <section className="promo-banner-section">
        <div className="promo-banner-content">
          <h2>🎉 โปรโมชั่นพิเศษ</h2>
          <p>ใช้โค้ด <strong>WELCOME100</strong> รับส่วนลด ฿100 ทันที เมื่อสั่งซื้อครั้งแรก</p>
          <div className="promo-codes">
            <span className="promo-code-chip">WELCOME100</span>
            <span className="promo-code-chip">CTOWN10</span>
            <span className="promo-code-chip">FREESHIP</span>
          </div>
          <Link to="/products" className="btn-promo" id="btn-promo-shop">ช้อปเลย</Link>
        </div>
      </section>
    </div>
  );
}
