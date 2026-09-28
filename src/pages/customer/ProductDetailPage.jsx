import React from 'react';
import { useParams, Link } from 'react-router-dom';
import ProductDetail from '../../components/product/ProductDetail';
import { ArrowLeft } from 'lucide-react';

export default function ProductDetailPage() {
  const { id } = useParams();

  return (
    <div className="product-detail-page">
      <div className="breadcrumb">
        <Link to="/">หน้าแรก</Link>
        <span>›</span>
        <Link to="/products">สินค้า</Link>
        <span>›</span>
        <span>รายละเอียด</span>
      </div>
      <Link to="/products" className="back-link">
        <ArrowLeft size={16} /> กลับไปหน้าสินค้า
      </Link>
      <ProductDetail productId={id} />
    </div>
  );
}
