import React from 'react';
import { BrowserRouter, Routes, Route, Outlet } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { CartProvider } from './contexts/CartContext';

// Layouts
import Header from './components/layout/Header';
import Footer from './components/layout/Footer';
import AdminLayout from './components/layout/AdminLayout';

// Customer Pages
import HomePage from './pages/customer/HomePage';
import ProductsPage from './pages/customer/ProductsPage';
import ProductDetailPage from './pages/customer/ProductDetailPage';
import CartPage from './pages/customer/CartPage';
import CheckoutPage from './pages/customer/CheckoutPage';
import OrdersPage from './pages/customer/OrdersPage';
import TrackOrderPage from './pages/customer/TrackOrderPage';
import LoginPage from './pages/customer/LoginPage';
import AccountPage from './pages/customer/AccountPage';
import ChatPage from './pages/customer/ChatPage';
import PromotionsPage from './pages/customer/PromotionsPage';
import ContactPage from './pages/customer/ContactPage';

// Admin Pages
import AdminDashboardPage from './pages/admin/AdminDashboardPage';
import AdminOrdersPage from './pages/admin/AdminOrdersPage';
import AdminProductsPage from './pages/admin/AdminProductsPage';
import AdminStockPage from './pages/admin/AdminStockPage';
import AdminCouponsPage from './pages/admin/AdminCouponsPage';
import AdminChatPage from './pages/admin/AdminChatPage';

function CustomerLayout() {
  return (
    <div className="site-wrapper">
      <Header />
      <main className="main-content">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <CartProvider>
          <Routes>
            {/* Customer Facing Routes */}
            <Route path="/" element={<CustomerLayout />}>
              <Route index element={<HomePage />} />
              <Route path="products" element={<ProductsPage />} />
              <Route path="products/:id" element={<ProductDetailPage />} />
              <Route path="cart" element={<CartPage />} />
              <Route path="checkout" element={<CheckoutPage />} />
              <Route path="orders" element={<OrdersPage />} />
              <Route path="track-order" element={<TrackOrderPage />} />
              <Route path="login" element={<LoginPage />} />
              <Route path="account" element={<AccountPage />} />
              <Route path="chat" element={<ChatPage />} />
              <Route path="promotions" element={<PromotionsPage />} />
              <Route path="contact" element={<ContactPage />} />
            </Route>

            {/* Admin Backoffice Routes */}
            <Route path="/admin" element={<AdminLayout />}>
              <Route index element={<AdminDashboardPage />} />
              <Route path="orders" element={<AdminOrdersPage />} />
              <Route path="products" element={<AdminProductsPage />} />
              <Route path="stock" element={<AdminStockPage />} />
              <Route path="coupons" element={<AdminCouponsPage />} />
              <Route path="chat" element={<AdminChatPage />} />
            </Route>
          </Routes>
        </CartProvider>
      </AuthProvider>
    </BrowserRouter>
  );
}
