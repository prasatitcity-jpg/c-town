import React, { useState, useEffect } from 'react';
import { pb, ctownFetch, formatPrice, getProductImageUrl } from '../../lib/pb';
import {
  Plus,
  Search,
  Edit,
  Trash2,
  ChevronDown,
  ChevronUp,
  Image,
  Package,
  Layers,
  X,
  Check,
} from 'lucide-react';

export default function AdminProductsPage() {
  const [products, setProducts] = useState([]);
  const [variantsMap, setVariantsMap] = useState({});
  const [brands, setBrands] = useState([]);
  const [categories, setCategories] = useState([]);
  const [expandedId, setExpandedId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');

  // Modals
  const [showAddProductModal, setShowAddProductModal] = useState(false);
  const [showAddVariantModal, setShowAddVariantModal] = useState(false);
  const [targetProduct, setTargetProduct] = useState(null);

  // Add Product Form
  const [prodForm, setProdForm] = useState({
    name: '',
    brand: '',
    category: '',
    base_price: 3500,
    description: '',
    is_new: true,
    is_bestseller: false,
    status: 'active',
  });

  // Add Variant Form
  const [variantForm, setVariantForm] = useState({
    sku: '',
    color: 'White',
    color_code: '#ffffff',
    size: '42',
    selling_price: 3500,
    sale_price: 0,
    cost_price: 2000,
    stock_quantity: 10,
    image_url: '/images/products/placeholder.jpg',
  });

  useEffect(() => {
    loadData();
  }, []);

  async function loadData() {
    setLoading(true);
    try {
      const [pRes, bRes, cRes] = await Promise.all([
        pb.collection('products').getList(1, 100, {
          expand: 'brand,category',
          sort: '-created',
        }),
        pb.collection('brands').getList(1, 50),
        pb.collection('categories').getList(1, 50),
      ]);

      setProducts(pRes.items);
      setBrands(bRes.items);
      setCategories(cRes.items);

      // Fetch all variants
      const vRes = await pb.collection('product_variants').getList(1, 500);
      const vMap = {};
      for (const v of vRes.items) {
        if (!vMap[v.product]) vMap[v.product] = [];
        vMap[v.product].push(v);
      }
      setVariantsMap(vMap);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  const toggleExpand = (id) => {
    setExpandedId(expandedId === id ? null : id);
  };

  const handleCreateProduct = async (e) => {
    e.preventDefault();
    try {
      const slug = prodForm.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
      const created = await pb.collection('products').create({
        ...prodForm,
        slug,
      });

      setShowAddProductModal(false);
      setProdForm({
        name: '',
        brand: '',
        category: '',
        base_price: 3500,
        description: '',
        is_new: true,
        is_bestseller: false,
        status: 'active',
      });
      await loadData();
    } catch (err) {
      alert('สร้างสินค้าไม่สำเร็จ: ' + err.message);
    }
  };

  const handleOpenAddVariant = (product) => {
    setTargetProduct(product);
    setVariantForm({
      sku: `${product.slug?.toUpperCase().slice(0, 4) || 'SKU'}-${Math.floor(1000 + Math.random() * 9000)}`,
      color: 'White',
      color_code: '#ffffff',
      size: '42',
      selling_price: product.base_price || 3500,
      sale_price: 0,
      cost_price: 2000,
      stock_quantity: 10,
      image_url: '/images/products/placeholder.jpg',
    });
    setShowAddVariantModal(true);
  };

  const handleCreateVariant = async (e) => {
    e.preventDefault();
    if (!targetProduct) return;
    try {
      const vData = {
        ...variantForm,
        product: targetProduct.id,
        selling_price: parseFloat(variantForm.selling_price),
        sale_price: variantForm.sale_price ? parseFloat(variantForm.sale_price) : 0,
        cost_price: parseFloat(variantForm.cost_price),
        stock_quantity: parseInt(variantForm.stock_quantity),
        status: 'active',
      };
      await pb.collection('product_variants').create(vData);

      // Record in ledger
      try {
        await pb.collection('stock_movements').create({
          variant: vData.sku,
          movement_type: 'in',
          quantity: vData.stock_quantity,
          balance_after: vData.stock_quantity,
          reference_type: 'initial_seed',
          notes: 'เพิ่ม Variant และสต็อกสินค้าเริ่มต้น',
        });
      } catch (_) {}

      setShowAddVariantModal(false);
      await loadData();
    } catch (err) {
      alert('เพิ่มตัวเลือกสินค้าไม่สำเร็จ: ' + err.message);
    }
  };

  const handleQuickStockUpdate = async (variant, delta) => {
    const newQty = (variant.stock_quantity || 0) + delta;
    if (newQty < 0) return;
    try {
      await pb.collection('product_variants').update(variant.id, {
        stock_quantity: newQty,
      });

      // Stock adjustment call
      await ctownFetch('/admin/stock/adjust', {
        method: 'POST',
        body: {
          variant_id: variant.id,
          quantity: delta,
          notes: 'ปรับปรุงสต็อกด่วนจากตารางสินค้า',
        },
      });

      await loadData();
    } catch (err) {
      alert('ปรับปรุงสต็อกไม่สำเร็จ: ' + err.message);
    }
  };

  const filteredProducts = products.filter(p => {
    return p.name?.toLowerCase().includes(search.toLowerCase()) ||
      p.expand?.brand?.name?.toLowerCase().includes(search.toLowerCase());
  });

  return (
    <div className="admin-products-page">
      <div className="dashboard-header-row">
        <div>
          <h2>สินค้าและคลังสต็อก (Products & Stock)</h2>
          <p className="subtitle">จัดการรายการรองเท้า ตัวเลือก สี ไซซ์ และจำนวนสต็อก</p>
        </div>
        <button
          type="button"
          className="btn-primary"
          onClick={() => setShowAddProductModal(true)}
          id="btn-add-product"
        >
          <Plus size={18} /> เพิ่มสินค้าใหม่
        </button>
      </div>

      {/* Search and stats bar */}
      <div className="admin-filter-bar">
        <div className="search-box-wrap">
          <Search size={16} className="search-icon" />
          <input
            type="text"
            placeholder="ค้นหาชื่อสินค้า หรือแบรนด์..."
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="admin-search-input"
          />
        </div>
        <div className="text-muted">
          รวมสินค้าทั้งหมด {products.length} รายการ
        </div>
      </div>

      {/* Products Table */}
      <div className="dashboard-panel">
        <div className="table-responsive">
          <table className="admin-table">
            <thead>
              <tr>
                <th style={{ width: '40px' }}></th>
                <th>สินค้า</th>
                <th>แบรนด์</th>
                <th>หมวดหมู่</th>
                <th>ราคาเริ่มต้น</th>
                <th>จำนวน Variants</th>
                <th>สต็อกรวม</th>
                <th>สถานะ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr>
                  <td colSpan="9" className="text-center py-6">กำลังโหลดข้อมูล...</td>
                </tr>
              ) : filteredProducts.length === 0 ? (
                <tr>
                  <td colSpan="9" className="text-center py-6 text-muted">ไม่พบข้อมูลสินค้า</td>
                </tr>
              ) : (
                filteredProducts.map(p => {
                  const variants = variantsMap[p.id] || [];
                  const isExp = expandedId === p.id;
                  const totalStock = variants.reduce((sum, v) => sum + (v.stock_quantity || 0), 0);
                  const firstImg = variants[0]?.image_url || '/images/products/placeholder.jpg';

                  return (
                    <React.Fragment key={p.id}>
                      <tr className={`product-main-row ${isExp ? 'expanded' : ''}`}>
                        <td>
                          <button
                            type="button"
                            className="btn-icon-subtle"
                            onClick={() => toggleExpand(p.id)}
                          >
                            {isExp ? <ChevronUp size={16} /> : <ChevronDown size={16} />}
                          </button>
                        </td>
                        <td>
                          <div className="product-cell-meta">
                            <img
                              src={firstImg}
                              alt={p.name}
                              className="product-mini-thumb"
                              onError={e => { e.target.src = '/images/products/placeholder.jpg'; }}
                            />
                            <div>
                              <strong>{p.name}</strong>
                              <div className="badges-inline">
                                {p.is_new && <span className="pill-badge pill-new">NEW</span>}
                                {p.is_bestseller && <span className="pill-badge pill-hot">HOT</span>}
                              </div>
                            </div>
                          </div>
                        </td>
                        <td>{p.expand?.brand?.name || '-'}</td>
                        <td>{p.expand?.category?.name || '-'}</td>
                        <td><strong>{formatPrice(p.base_price)}</strong></td>
                        <td>{variants.length} ตัวเลือก</td>
                        <td>
                          <span className={`stock-count-badge ${totalStock < 10 ? 'low' : ''}`}>
                            {totalStock} คู่
                          </span>
                        </td>
                        <td>
                          <span className={`status-pill-simple ${p.status}`}>
                            {p.status === 'active' ? 'เปิดขาย' : 'ปิด'}
                          </span>
                        </td>
                        <td>
                          <button
                            type="button"
                            className="btn-secondary btn-sm"
                            onClick={() => handleOpenAddVariant(p)}
                            title="เพิ่มสี/ไซซ์ (Variant)"
                          >
                            <Plus size={14} /> เพิ่มไซซ์
                          </button>
                        </td>
                      </tr>

                      {/* Expandable Variants Row */}
                      {isExp && (
                        <tr className="variants-subtable-row">
                          <td colSpan="9">
                            <div className="variants-subtable-wrap">
                              <h5>ตัวเลือกสินค้า (Variants: สี / ไซซ์ / สต็อก)</h5>
                              {variants.length === 0 ? (
                                <p className="text-muted p-3">ยังไม่มีตัวเลือก ให้กดปุ่ม "เพิ่มไซซ์" ด้านบน</p>
                              ) : (
                                <table className="admin-subtable">
                                  <thead>
                                    <tr>
                                      <th>SKU</th>
                                      <th>สี</th>
                                      <th>ไซซ์ (EU)</th>
                                      <th>ราคาขาย</th>
                                      <th>สต็อกคงเหลือ</th>
                                      <th>ปรับสต็อกด่วน</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {variants.map(v => (
                                      <tr key={v.id}>
                                        <td><code>{v.sku}</code></td>
                                        <td>
                                          <div className="color-cell">
                                            <span
                                              className="color-dot-inline"
                                              style={{ backgroundColor: v.color_code || '#ccc' }}
                                            />
                                            {v.color}
                                          </div>
                                        </td>
                                        <td><strong>{v.size}</strong></td>
                                        <td>
                                          {v.sale_price > 0 ? (
                                            <>
                                              <span className="text-sale">{formatPrice(v.sale_price)}</span>{' '}
                                              <del className="text-muted">{formatPrice(v.selling_price)}</del>
                                            </>
                                          ) : (
                                            formatPrice(v.selling_price)
                                          )}
                                        </td>
                                        <td>
                                          <strong className={v.stock_quantity < 5 ? 'text-danger' : ''}>
                                            {v.stock_quantity} คู่
                                          </strong>
                                        </td>
                                        <td>
                                          <div className="quick-stock-controls">
                                            <button
                                              type="button"
                                              className="btn-stock-adjust minus"
                                              onClick={() => handleQuickStockUpdate(v, -1)}
                                              disabled={v.stock_quantity <= 0}
                                            >
                                              -1
                                            </button>
                                            <button
                                              type="button"
                                              className="btn-stock-adjust plus"
                                              onClick={() => handleQuickStockUpdate(v, 1)}
                                            >
                                              +1
                                            </button>
                                            <button
                                              type="button"
                                              className="btn-stock-adjust plus"
                                              onClick={() => handleQuickStockUpdate(v, 5)}
                                            >
                                              +5
                                            </button>
                                          </div>
                                        </td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              )}
                            </div>
                          </td>
                        </tr>
                      )}
                    </React.Fragment>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal: Add Product */}
      {showAddProductModal && (
        <div className="modal-backdrop">
          <div className="modal-container">
            <div className="modal-header">
              <h3>เพิ่มสินค้าใหม่</h3>
              <button type="button" className="btn-close" onClick={() => setShowAddProductModal(false)}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleCreateProduct} className="modal-form">
              <div className="form-group">
                <label>ชื่อสินค้า / รุ่นรองเท้า *</label>
                <input
                  type="text"
                  required
                  placeholder="เช่น Nike Dunk Low Retro"
                  value={prodForm.name}
                  onChange={e => setProdForm({ ...prodForm, name: e.target.value })}
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>แบรนด์ *</label>
                  <select
                    required
                    value={prodForm.brand}
                    onChange={e => setProdForm({ ...prodForm, brand: e.target.value })}
                  >
                    <option value="">-- เลือกแบรนด์ --</option>
                    {brands.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
                  </select>
                </div>
                <div className="form-group">
                  <label>หมวดหมู่ *</label>
                  <select
                    required
                    value={prodForm.category}
                    onChange={e => setProdForm({ ...prodForm, category: e.target.value })}
                  >
                    <option value="">-- เลือกหมวดหมู่ --</option>
                    {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
                  </select>
                </div>
              </div>

              <div className="form-group">
                <label>ราคาเริ่มต้น (บาท) *</label>
                <input
                  type="number"
                  required
                  value={prodForm.base_price}
                  onChange={e => setProdForm({ ...prodForm, base_price: parseFloat(e.target.value) || 0 })}
                />
              </div>

              <div className="form-group">
                <label>รายละเอียดสินค้า</label>
                <textarea
                  rows={3}
                  placeholder="ความโดดเด่น วัสดุ ประวัติความเป็นมา..."
                  value={prodForm.description}
                  onChange={e => setProdForm({ ...prodForm, description: e.target.value })}
                />
              </div>

              <div className="form-row">
                <label className="checkbox-label">
                  <input
                    type="checkbox"
                    checked={prodForm.is_new}
                    onChange={e => setProdForm({ ...prodForm, is_new: e.target.checked })}
                  />
                  เป็นสินค้าใหม่ (New)
                </label>
                <label className="checkbox-label">
                  <input
                    type="checkbox"
                    checked={prodForm.is_bestseller}
                    onChange={e => setProdForm({ ...prodForm, is_bestseller: e.target.checked })}
                  />
                  เป็นสินค้าขายดี (Bestseller)
                </label>
              </div>

              <div className="modal-footer">
                <button type="submit" className="btn-primary">บันทึกสินค้า</button>
                <button type="button" className="btn-secondary" onClick={() => setShowAddProductModal(false)}>ยกเลิก</button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal: Add Variant */}
      {showAddVariantModal && targetProduct && (
        <div className="modal-backdrop">
          <div className="modal-container">
            <div className="modal-header">
              <h3>เพิ่มตัวเลือก (Variant) สำหรับ {targetProduct.name}</h3>
              <button type="button" className="btn-close" onClick={() => setShowAddVariantModal(false)}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleCreateVariant} className="modal-form">
              <div className="form-row">
                <div className="form-group">
                  <label>SKU (รหัสเฉพาะ) *</label>
                  <input
                    type="text"
                    required
                    value={variantForm.sku}
                    onChange={e => setVariantForm({ ...variantForm, sku: e.target.value })}
                  />
                </div>
                <div className="form-group">
                  <label>ไซซ์ (EU) *</label>
                  <input
                    type="text"
                    required
                    placeholder="เช่น 38, 39, 40, 41, 42, 43"
                    value={variantForm.size}
                    onChange={e => setVariantForm({ ...variantForm, size: e.target.value })}
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>ชื่อสี *</label>
                  <input
                    type="text"
                    required
                    placeholder="เช่น White, Rose Pink, Triple Black"
                    value={variantForm.color}
                    onChange={e => setVariantForm({ ...variantForm, color: e.target.value })}
                  />
                </div>
                <div className="form-group">
                  <label>โค้ดสี HEX</label>
                  <div className="input-color-wrap">
                    <input
                      type="color"
                      value={variantForm.color_code}
                      onChange={e => setVariantForm({ ...variantForm, color_code: e.target.value })}
                    />
                    <input
                      type="text"
                      value={variantForm.color_code}
                      onChange={e => setVariantForm({ ...variantForm, color_code: e.target.value })}
                    />
                  </div>
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>ราคาขายปกติ (บาท) *</label>
                  <input
                    type="number"
                    required
                    value={variantForm.selling_price}
                    onChange={e => setVariantForm({ ...variantForm, selling_price: e.target.value })}
                  />
                </div>
                <div className="form-group">
                  <label>ราคาโปรโมชั่น (0 ถ้าไม่มี)</label>
                  <input
                    type="number"
                    value={variantForm.sale_price}
                    onChange={e => setVariantForm({ ...variantForm, sale_price: e.target.value })}
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>จำนวนสต็อกเริ่มต้น *</label>
                  <input
                    type="number"
                    required
                    min={0}
                    value={variantForm.stock_quantity}
                    onChange={e => setVariantForm({ ...variantForm, stock_quantity: e.target.value })}
                  />
                </div>
                <div className="form-group">
                  <label>URL รูปภาพตัวเลือก</label>
                  <input
                    type="text"
                    placeholder="/images/products/..."
                    value={variantForm.image_url}
                    onChange={e => setVariantForm({ ...variantForm, image_url: e.target.value })}
                  />
                </div>
              </div>

              <div className="modal-footer">
                <button type="submit" className="btn-primary">เพิ่มตัวเลือกสินค้า</button>
                <button type="button" className="btn-secondary" onClick={() => setShowAddVariantModal(false)}>ยกเลิก</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
