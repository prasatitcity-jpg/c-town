import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { pb, formatPrice } from '../../lib/pb';
import ProductCard from '../../components/product/ProductCard';
import { Search, SlidersHorizontal, X, ChevronDown } from 'lucide-react';

const SORT_OPTIONS = [
  { value: 'base_price', label: 'ราคา: ต่ำ → สูง' },
  { value: '-base_price', label: 'ราคา: สูง → ต่ำ' },
  { value: '-id', label: 'สินค้าใหม่ล่าสุด' },
  { value: 'name', label: 'ชื่อ A → Z' },
];

export default function ProductsPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [products, setProducts] = useState([]);
  const [variantMap, setVariantMap] = useState({});
  const [brands, setBrands] = useState([]);
  const [loading, setLoading] = useState(true);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const PER_PAGE = 12;
  const [showFilters, setShowFilters] = useState(false);

  // Filters from URL
  const search = searchParams.get('search') || '';
  const categorySlug = searchParams.get('category') || '';
  const brandFilter = searchParams.get('brand') || '';
  const isNew = searchParams.get('new') === '1';
  const isBestseller = searchParams.get('bestseller') === '1';
  const sort = searchParams.get('sort') || '-id';
  const minPrice = searchParams.get('minPrice') || '';
  const maxPrice = searchParams.get('maxPrice') || '';

  useEffect(() => {
    (async () => {
      try {
        const bs = await pb.collection('brands').getList(1, 50, { filter: 'is_active = true' });
        setBrands(bs.items);
      } catch (_) {}
    })();
  }, []);

  useEffect(() => {
    setPage(1);
  }, [search, categorySlug, brandFilter, isNew, isBestseller, sort, minPrice, maxPrice]);

  useEffect(() => {
    loadProducts();
  }, [page, search, categorySlug, brandFilter, isNew, isBestseller, sort, minPrice, maxPrice]);

  async function loadProducts() {
    setLoading(true);
    try {
      let filters = ['status = "active"'];
      if (search) filters.push(`(name ~ "${search}" || description ~ "${search}")`);
      if (isNew) filters.push('is_new = true');
      if (isBestseller) filters.push('is_bestseller = true');
      if (brandFilter) {
        const brand = brands.find(b => b.slug === brandFilter || b.name === brandFilter);
        if (brand) filters.push(`brand = "${brand.id}"`);
      }
      if (categorySlug) {
        try {
          const cats = await pb.collection('categories').getList(1, 1, { filter: `slug = "${categorySlug}"` });
          if (cats.items.length > 0) filters.push(`category = "${cats.items[0].id}"`);
        } catch (_) {}
      }

      const result = await pb.collection('products').getList(page, PER_PAGE, {
        filter: filters.join(' && '),
        expand: 'brand,category',
        sort: sort || '-id',
      });

      // Load variants for these products
      const pIds = result.items.map(p => `product = "${p.id}"`).join(' || ');
      const varMap = {};
      if (pIds) {
        try {
          const vars = await pb.collection('product_variants').getFullList({
            filter: `(${pIds}) && status = "active"`,
          });
          for (const v of vars) {
            if (!varMap[v.product]) varMap[v.product] = [];
            varMap[v.product].push(v);
          }
        } catch (_) {}
      }

      setVariantMap(varMap);
      setProducts(result.items);
      setTotal(result.totalItems);
    } catch (err) {
      console.error('Products load error:', err);
    } finally {
      setLoading(false);
    }
  }

  const setFilter = (key, value) => {
    const next = new URLSearchParams(searchParams);
    if (value) next.set(key, value);
    else next.delete(key);
    setSearchParams(next);
  };

  const clearFilters = () => setSearchParams({});

  const totalPages = Math.ceil(total / PER_PAGE);
  const hasFilters = search || categorySlug || brandFilter || isNew || isBestseller || minPrice || maxPrice;

  return (
    <div className="products-page">
      <div className="products-page-header">
        <div className="products-page-title">
          <h1>
            {isNew ? '✨ สินค้าใหม่' :
             isBestseller ? '🔥 สินค้าขายดี' :
             categorySlug ? categorySlug.replace(/-/g, ' ').toUpperCase() :
             search ? `ผลลัพธ์: "${search}"` :
             'สินค้าทั้งหมด'}
          </h1>
          <span className="products-count">{total} รายการ</span>
        </div>

        {/* Top bar: search + sort + filter toggle */}
        <div className="products-topbar">
          <div className="search-inline">
            <Search size={16} />
            <input
              type="text"
              value={search}
              placeholder="ค้นหาสินค้า..."
              onChange={e => setFilter('search', e.target.value)}
              className="search-inline-input"
              id="products-search"
            />
          </div>

          <select
            className="sort-select"
            value={sort}
            onChange={e => setFilter('sort', e.target.value)}
            id="sort-select"
          >
            {SORT_OPTIONS.map(o => (
              <option key={o.value} value={o.value}>{o.label}</option>
            ))}
          </select>

          <button
            className={`btn-filter-toggle${showFilters ? ' active' : ''}`}
            onClick={() => setShowFilters(!showFilters)}
            id="btn-filter-toggle"
          >
            <SlidersHorizontal size={16} /> ตัวกรอง
          </button>

          {hasFilters && (
            <button className="btn-clear-filters" onClick={clearFilters} id="btn-clear-filters">
              <X size={14} /> ล้างตัวกรอง
            </button>
          )}
        </div>

        {/* Filters Panel */}
        {showFilters && (
          <div className="filters-panel">
            {/* Brand */}
            <div className="filter-group">
              <label className="filter-label">แบรนด์</label>
              <div className="filter-options">
                <button
                  className={`filter-chip${!brandFilter ? ' active' : ''}`}
                  onClick={() => setFilter('brand', '')}
                >ทั้งหมด</button>
                {brands.map(b => (
                  <button
                    key={b.id}
                    className={`filter-chip${brandFilter === b.slug ? ' active' : ''}`}
                    onClick={() => setFilter('brand', b.slug)}
                  >{b.name}</button>
                ))}
              </div>
            </div>

            {/* Special */}
            <div className="filter-group">
              <label className="filter-label">สถานะ</label>
              <div className="filter-options">
                <button className={`filter-chip${isNew ? ' active' : ''}`} onClick={() => setFilter('new', isNew ? '' : '1')}>
                  ✨ สินค้าใหม่
                </button>
                <button className={`filter-chip${isBestseller ? ' active' : ''}`} onClick={() => setFilter('bestseller', isBestseller ? '' : '1')}>
                  🔥 ขายดี
                </button>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Products Grid */}
      {loading ? (
        <div className="products-loading-grid">
          {Array(8).fill(0).map((_, i) => <div key={i} className="product-skeleton" />)}
        </div>
      ) : products.length === 0 ? (
        <div className="no-products">
          <Search size={48} strokeWidth={1} />
          <h3>ไม่พบสินค้า</h3>
          <p>ลองเปลี่ยนคำค้นหาหรือล้างตัวกรอง</p>
          <button className="btn-primary" onClick={clearFilters}>ดูสินค้าทั้งหมด</button>
        </div>
      ) : (
        <>
          <div className="products-grid" id="products-grid">
            {products.map(product => (
              <ProductCard
                key={product.id}
                product={product}
                variants={variantMap[product.id] || []}
              />
            ))}
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="pagination">
              <button disabled={page <= 1} onClick={() => setPage(p => p - 1)} className="page-btn">‹</button>
              {Array.from({ length: totalPages }, (_, i) => i + 1).map(p => (
                <button
                  key={p}
                  onClick={() => setPage(p)}
                  className={`page-btn${page === p ? ' active' : ''}`}
                >{p}</button>
              ))}
              <button disabled={page >= totalPages} onClick={() => setPage(p => p + 1)} className="page-btn">›</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
