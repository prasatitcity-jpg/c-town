-- =====================================================================
-- C-TOWN SNEAKER STORE - SUPABASE DATABASE SCHEMA
-- Generated for Supabase (PostgreSQL 15+)
-- Compatible with PocketBase IDs (15-character string keys)
-- =====================================================================

-- 0. Enable UUID and pgcrypto extensions (standard on Supabase)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Drop existing tables if needed (uncomment if you want a clean reset):
/*
DROP TABLE IF EXISTS public.audit_logs CASCADE;
DROP TABLE IF EXISTS public.store_settings CASCADE;
DROP TABLE IF EXISTS public.messages CASCADE;
DROP TABLE IF EXISTS public.conversations CASCADE;
DROP TABLE IF EXISTS public.purchase_order_items CASCADE;
DROP TABLE IF EXISTS public.purchase_orders CASCADE;
DROP TABLE IF EXISTS public.stock_movements CASCADE;
DROP TABLE IF EXISTS public.shipment_events CASCADE;
DROP TABLE IF EXISTS public.shipments CASCADE;
DROP TABLE IF EXISTS public.payment_proofs CASCADE;
DROP TABLE IF EXISTS public.payments CASCADE;
DROP TABLE IF EXISTS public.order_items CASCADE;
DROP TABLE IF EXISTS public.orders CASCADE;
DROP TABLE IF EXISTS public.cart_items CASCADE;
DROP TABLE IF EXISTS public.carts CASCADE;
DROP TABLE IF EXISTS public.coupon_usages CASCADE;
DROP TABLE IF EXISTS public.coupons CASCADE;
DROP TABLE IF EXISTS public.product_images CASCADE;
DROP TABLE IF EXISTS public.product_variants CASCADE;
DROP TABLE IF EXISTS public.products CASCADE;
DROP TABLE IF EXISTS public.categories CASCADE;
DROP TABLE IF EXISTS public.brands CASCADE;
DROP TABLE IF EXISTS public.suppliers CASCADE;
DROP TABLE IF EXISTS public.addresses CASCADE;
DROP TABLE IF EXISTS public.admin_profiles CASCADE;
DROP TABLE IF EXISTS public.customer_profiles CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;
*/

-- Table: public.users
CREATE TABLE IF NOT EXISTS public.users (
  "avatar" TEXT,
  "created" TEXT,
  "email" TEXT,
  "emailVisibility" BOOLEAN DEFAULT FALSE,
  "id" TEXT PRIMARY KEY,
  "name" TEXT,
  "password" TEXT,
  "tokenKey" TEXT,
  "updated" TEXT,
  "verified" BOOLEAN DEFAULT FALSE,
  "role" TEXT,
  "phone" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on users" ON public.users;
CREATE POLICY "Allow all read on users" ON public.users FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on users" ON public.users;
CREATE POLICY "Allow authenticated full access on users" ON public.users FOR ALL TO authenticated USING (true);

-- Table: public.customer_profiles
CREATE TABLE IF NOT EXISTS public.customer_profiles (
  "birthdate" TEXT,
  "full_name" TEXT,
  "gender" TEXT,
  "id" TEXT PRIMARY KEY,
  "notes" TEXT,
  "phone" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_customer_profiles_user ON public.customer_profiles ("user");
ALTER TABLE public.customer_profiles ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on customer_profiles" ON public.customer_profiles;
CREATE POLICY "Allow all read on customer_profiles" ON public.customer_profiles FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on customer_profiles" ON public.customer_profiles;
CREATE POLICY "Allow authenticated full access on customer_profiles" ON public.customer_profiles FOR ALL TO authenticated USING (true);

-- Table: public.admin_profiles
CREATE TABLE IF NOT EXISTS public.admin_profiles (
  "department" TEXT,
  "id" TEXT PRIMARY KEY,
  "permissions" JSONB,
  "role_title" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_admin_profiles_user ON public.admin_profiles ("user");
ALTER TABLE public.admin_profiles ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on admin_profiles" ON public.admin_profiles;
CREATE POLICY "Allow all read on admin_profiles" ON public.admin_profiles FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on admin_profiles" ON public.admin_profiles;
CREATE POLICY "Allow authenticated full access on admin_profiles" ON public.admin_profiles FOR ALL TO authenticated USING (true);

-- Table: public.addresses
CREATE TABLE IF NOT EXISTS public.addresses (
  "address_line" TEXT,
  "district" TEXT,
  "id" TEXT PRIMARY KEY,
  "is_default" BOOLEAN DEFAULT FALSE,
  "phone" TEXT,
  "postal_code" TEXT,
  "province" TEXT,
  "recipient_name" TEXT,
  "subdistrict" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_addresses_user ON public.addresses ("user");
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on addresses" ON public.addresses;
CREATE POLICY "Allow all read on addresses" ON public.addresses FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on addresses" ON public.addresses;
CREATE POLICY "Allow authenticated full access on addresses" ON public.addresses FOR ALL TO authenticated USING (true);

-- Table: public.suppliers
CREATE TABLE IF NOT EXISTS public.suppliers (
  "address" TEXT,
  "contact_name" TEXT,
  "email" TEXT,
  "id" TEXT PRIMARY KEY,
  "is_active" BOOLEAN DEFAULT FALSE,
  "name" TEXT,
  "notes" TEXT,
  "phone" TEXT,
  "tax_id" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on suppliers" ON public.suppliers;
CREATE POLICY "Allow all read on suppliers" ON public.suppliers FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on suppliers" ON public.suppliers;
CREATE POLICY "Allow authenticated full access on suppliers" ON public.suppliers FOR ALL TO authenticated USING (true);

-- Table: public.brands
CREATE TABLE IF NOT EXISTS public.brands (
  "description" TEXT,
  "id" TEXT PRIMARY KEY,
  "is_active" BOOLEAN DEFAULT FALSE,
  "logo" TEXT,
  "name" TEXT,
  "slug" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_brands_slug ON public.brands ("slug");
ALTER TABLE public.brands ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on brands" ON public.brands;
CREATE POLICY "Allow all read on brands" ON public.brands FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on brands" ON public.brands;
CREATE POLICY "Allow authenticated full access on brands" ON public.brands FOR ALL TO authenticated USING (true);

-- Table: public.categories
CREATE TABLE IF NOT EXISTS public.categories (
  "description" TEXT,
  "id" TEXT PRIMARY KEY,
  "image" TEXT,
  "is_active" BOOLEAN DEFAULT FALSE,
  "name" TEXT,
  "slug" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_categories_slug ON public.categories ("slug");
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on categories" ON public.categories;
CREATE POLICY "Allow all read on categories" ON public.categories FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on categories" ON public.categories;
CREATE POLICY "Allow authenticated full access on categories" ON public.categories FOR ALL TO authenticated USING (true);

-- Table: public.products
CREATE TABLE IF NOT EXISTS public.products (
  "additional_images" JSONB,
  "base_price" NUMERIC,
  "brand" TEXT,
  "category" TEXT,
  "description" TEXT,
  "id" TEXT PRIMARY KEY,
  "is_bestseller" BOOLEAN DEFAULT FALSE,
  "is_new" BOOLEAN DEFAULT FALSE,
  "main_image" TEXT,
  "name" TEXT,
  "slug" TEXT,
  "status" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_products_slug ON public.products ("slug");
CREATE INDEX IF NOT EXISTS idx_products_status ON public.products ("status");
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on products" ON public.products;
CREATE POLICY "Allow all read on products" ON public.products FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on products" ON public.products;
CREATE POLICY "Allow authenticated full access on products" ON public.products FOR ALL TO authenticated USING (true);

-- Table: public.product_variants
CREATE TABLE IF NOT EXISTS public.product_variants (
  "barcode" TEXT,
  "color" TEXT,
  "color_code" TEXT,
  "cost_price" NUMERIC,
  "id" TEXT PRIMARY KEY,
  "image_url" TEXT,
  "product" TEXT,
  "sale_price" NUMERIC,
  "selling_price" NUMERIC,
  "size" TEXT,
  "sku" TEXT,
  "sold_quantity" NUMERIC,
  "status" TEXT,
  "stock_quantity" NUMERIC,
  "variant_image" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_product_variants_product ON public.product_variants ("product");
CREATE INDEX IF NOT EXISTS idx_product_variants_sku ON public.product_variants ("sku");
CREATE INDEX IF NOT EXISTS idx_product_variants_status ON public.product_variants ("status");
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on product_variants" ON public.product_variants;
CREATE POLICY "Allow all read on product_variants" ON public.product_variants FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on product_variants" ON public.product_variants;
CREATE POLICY "Allow authenticated full access on product_variants" ON public.product_variants FOR ALL TO authenticated USING (true);

-- Table: public.product_images
CREATE TABLE IF NOT EXISTS public.product_images (
  "alt_text" TEXT,
  "id" TEXT PRIMARY KEY,
  "image_file" TEXT,
  "product" TEXT,
  "sort_order" NUMERIC,
  "variant" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_product_images_product ON public.product_images ("product");
CREATE INDEX IF NOT EXISTS idx_product_images_variant ON public.product_images ("variant");
ALTER TABLE public.product_images ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on product_images" ON public.product_images;
CREATE POLICY "Allow all read on product_images" ON public.product_images FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on product_images" ON public.product_images;
CREATE POLICY "Allow authenticated full access on product_images" ON public.product_images FOR ALL TO authenticated USING (true);

-- Table: public.coupons
CREATE TABLE IF NOT EXISTS public.coupons (
  "code" TEXT,
  "discount_type" TEXT,
  "discount_value" NUMERIC,
  "expiry_date" TEXT,
  "id" TEXT PRIMARY KEY,
  "max_discount" NUMERIC,
  "min_purchase" NUMERIC,
  "start_date" TEXT,
  "status" TEXT,
  "times_used" NUMERIC,
  "usage_limit" NUMERIC,
  "usage_per_customer" NUMERIC,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_coupons_status ON public.coupons ("status");
ALTER TABLE public.coupons ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on coupons" ON public.coupons;
CREATE POLICY "Allow all read on coupons" ON public.coupons FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on coupons" ON public.coupons;
CREATE POLICY "Allow authenticated full access on coupons" ON public.coupons FOR ALL TO authenticated USING (true);

-- Table: public.coupon_usages
CREATE TABLE IF NOT EXISTS public.coupon_usages (
  "coupon" TEXT,
  "discount_amount" NUMERIC,
  "id" TEXT PRIMARY KEY,
  "order_id" TEXT,
  "used_at" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_coupon_usages_user ON public.coupon_usages ("user");
ALTER TABLE public.coupon_usages ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on coupon_usages" ON public.coupon_usages;
CREATE POLICY "Allow all read on coupon_usages" ON public.coupon_usages FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on coupon_usages" ON public.coupon_usages;
CREATE POLICY "Allow authenticated full access on coupon_usages" ON public.coupon_usages FOR ALL TO authenticated USING (true);

-- Table: public.carts
CREATE TABLE IF NOT EXISTS public.carts (
  "id" TEXT PRIMARY KEY,
  "status" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_carts_user ON public.carts ("user");
CREATE INDEX IF NOT EXISTS idx_carts_status ON public.carts ("status");
ALTER TABLE public.carts ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on carts" ON public.carts;
CREATE POLICY "Allow all read on carts" ON public.carts FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on carts" ON public.carts;
CREATE POLICY "Allow authenticated full access on carts" ON public.carts FOR ALL TO authenticated USING (true);

-- Table: public.cart_items
CREATE TABLE IF NOT EXISTS public.cart_items (
  "cart" TEXT,
  "id" TEXT PRIMARY KEY,
  "product" TEXT,
  "quantity" NUMERIC,
  "unit_price" NUMERIC,
  "user" TEXT,
  "variant" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_cart_items_user ON public.cart_items ("user");
CREATE INDEX IF NOT EXISTS idx_cart_items_product ON public.cart_items ("product");
CREATE INDEX IF NOT EXISTS idx_cart_items_variant ON public.cart_items ("variant");
ALTER TABLE public.cart_items ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on cart_items" ON public.cart_items;
CREATE POLICY "Allow all read on cart_items" ON public.cart_items FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on cart_items" ON public.cart_items;
CREATE POLICY "Allow authenticated full access on cart_items" ON public.cart_items FOR ALL TO authenticated USING (true);

-- Table: public.orders
CREATE TABLE IF NOT EXISTS public.orders (
  "coupon" TEXT,
  "courier_name" TEXT,
  "discount_amount" NUMERIC,
  "grand_total" NUMERIC,
  "id" TEXT PRIMARY KEY,
  "notes" TEXT,
  "order_number" TEXT,
  "order_status" TEXT,
  "payment_method" TEXT,
  "payment_status" TEXT,
  "shipping_address_snapshot" JSONB,
  "shipping_date" TEXT,
  "shipping_fee" NUMERIC,
  "subtotal" NUMERIC,
  "tracking_number" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_orders_user ON public.orders ("user");
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on orders" ON public.orders;
CREATE POLICY "Allow all read on orders" ON public.orders FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on orders" ON public.orders;
CREATE POLICY "Allow authenticated full access on orders" ON public.orders FOR ALL TO authenticated USING (true);

-- Table: public.order_items
CREATE TABLE IF NOT EXISTS public.order_items (
  "color" TEXT,
  "id" TEXT PRIMARY KEY,
  "image_snapshot" TEXT,
  "line_total" NUMERIC,
  "order" TEXT,
  "product_id" TEXT,
  "product_name_snapshot" TEXT,
  "quantity" NUMERIC,
  "size" TEXT,
  "sku" TEXT,
  "unit_price" NUMERIC,
  "variant" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_order_items_variant ON public.order_items ("variant");
CREATE INDEX IF NOT EXISTS idx_order_items_order ON public.order_items ("order");
CREATE INDEX IF NOT EXISTS idx_order_items_sku ON public.order_items ("sku");
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on order_items" ON public.order_items;
CREATE POLICY "Allow all read on order_items" ON public.order_items FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on order_items" ON public.order_items;
CREATE POLICY "Allow authenticated full access on order_items" ON public.order_items FOR ALL TO authenticated USING (true);

-- Table: public.payments
CREATE TABLE IF NOT EXISTS public.payments (
  "amount" NUMERIC,
  "id" TEXT PRIMARY KEY,
  "order" TEXT,
  "payment_method" TEXT,
  "status" TEXT,
  "transaction_reference" TEXT,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payments_user ON public.payments ("user");
CREATE INDEX IF NOT EXISTS idx_payments_order ON public.payments ("order");
CREATE INDEX IF NOT EXISTS idx_payments_status ON public.payments ("status");
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on payments" ON public.payments;
CREATE POLICY "Allow all read on payments" ON public.payments FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on payments" ON public.payments;
CREATE POLICY "Allow authenticated full access on payments" ON public.payments FOR ALL TO authenticated USING (true);

-- Table: public.payment_proofs
CREATE TABLE IF NOT EXISTS public.payment_proofs (
  "admin_note" TEXT,
  "id" TEXT PRIMARY KEY,
  "order" TEXT,
  "slip_image" TEXT,
  "status" TEXT,
  "transfer_amount" NUMERIC,
  "transfer_bank" TEXT,
  "transfer_date" TEXT,
  "transfer_time" TEXT,
  "user" TEXT,
  "verified_by" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payment_proofs_user ON public.payment_proofs ("user");
CREATE INDEX IF NOT EXISTS idx_payment_proofs_order ON public.payment_proofs ("order");
CREATE INDEX IF NOT EXISTS idx_payment_proofs_status ON public.payment_proofs ("status");
ALTER TABLE public.payment_proofs ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on payment_proofs" ON public.payment_proofs;
CREATE POLICY "Allow all read on payment_proofs" ON public.payment_proofs FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on payment_proofs" ON public.payment_proofs;
CREATE POLICY "Allow authenticated full access on payment_proofs" ON public.payment_proofs FOR ALL TO authenticated USING (true);

-- Table: public.shipments
CREATE TABLE IF NOT EXISTS public.shipments (
  "courier_name" TEXT,
  "estimated_delivery_date" TEXT,
  "id" TEXT PRIMARY KEY,
  "order" TEXT,
  "shipping_date" TEXT,
  "status" TEXT,
  "tracking_number" TEXT,
  "tracking_url" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_shipments_order ON public.shipments ("order");
CREATE INDEX IF NOT EXISTS idx_shipments_status ON public.shipments ("status");
ALTER TABLE public.shipments ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on shipments" ON public.shipments;
CREATE POLICY "Allow all read on shipments" ON public.shipments FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on shipments" ON public.shipments;
CREATE POLICY "Allow authenticated full access on shipments" ON public.shipments FOR ALL TO authenticated USING (true);

-- Table: public.shipment_events
CREATE TABLE IF NOT EXISTS public.shipment_events (
  "description" TEXT,
  "event_time" TEXT,
  "id" TEXT PRIMARY KEY,
  "location" TEXT,
  "order" TEXT,
  "shipment" TEXT,
  "status" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_shipment_events_order ON public.shipment_events ("order");
CREATE INDEX IF NOT EXISTS idx_shipment_events_status ON public.shipment_events ("status");
ALTER TABLE public.shipment_events ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on shipment_events" ON public.shipment_events;
CREATE POLICY "Allow all read on shipment_events" ON public.shipment_events FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on shipment_events" ON public.shipment_events;
CREATE POLICY "Allow authenticated full access on shipment_events" ON public.shipment_events FOR ALL TO authenticated USING (true);

-- Table: public.stock_movements
CREATE TABLE IF NOT EXISTS public.stock_movements (
  "created_by" TEXT,
  "id" TEXT PRIMARY KEY,
  "movement_type" TEXT,
  "note" TEXT,
  "product" TEXT,
  "quantity" NUMERIC,
  "reference_number" TEXT,
  "sku" TEXT,
  "supplier" TEXT,
  "unit_cost" NUMERIC,
  "variant" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_stock_movements_product ON public.stock_movements ("product");
CREATE INDEX IF NOT EXISTS idx_stock_movements_variant ON public.stock_movements ("variant");
CREATE INDEX IF NOT EXISTS idx_stock_movements_sku ON public.stock_movements ("sku");
ALTER TABLE public.stock_movements ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on stock_movements" ON public.stock_movements;
CREATE POLICY "Allow all read on stock_movements" ON public.stock_movements FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on stock_movements" ON public.stock_movements;
CREATE POLICY "Allow authenticated full access on stock_movements" ON public.stock_movements FOR ALL TO authenticated USING (true);

-- Table: public.purchase_orders
CREATE TABLE IF NOT EXISTS public.purchase_orders (
  "id" TEXT PRIMARY KEY,
  "notes" TEXT,
  "ordered_at" TEXT,
  "po_number" TEXT,
  "received_at" TEXT,
  "status" TEXT,
  "supplier" TEXT,
  "total_cost" NUMERIC,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_purchase_orders_status ON public.purchase_orders ("status");
ALTER TABLE public.purchase_orders ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on purchase_orders" ON public.purchase_orders;
CREATE POLICY "Allow all read on purchase_orders" ON public.purchase_orders FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on purchase_orders" ON public.purchase_orders;
CREATE POLICY "Allow authenticated full access on purchase_orders" ON public.purchase_orders FOR ALL TO authenticated USING (true);

-- Table: public.purchase_order_items
CREATE TABLE IF NOT EXISTS public.purchase_order_items (
  "id" TEXT PRIMARY KEY,
  "line_total" NUMERIC,
  "purchase_order" TEXT,
  "quantity" NUMERIC,
  "received_quantity" NUMERIC,
  "unit_cost" NUMERIC,
  "variant" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_purchase_order_items_variant ON public.purchase_order_items ("variant");
ALTER TABLE public.purchase_order_items ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on purchase_order_items" ON public.purchase_order_items;
CREATE POLICY "Allow all read on purchase_order_items" ON public.purchase_order_items FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on purchase_order_items" ON public.purchase_order_items;
CREATE POLICY "Allow authenticated full access on purchase_order_items" ON public.purchase_order_items FOR ALL TO authenticated USING (true);

-- Table: public.conversations
CREATE TABLE IF NOT EXISTS public.conversations (
  "id" TEXT PRIMARY KEY,
  "last_message" TEXT,
  "last_message_at" TEXT,
  "status" TEXT,
  "subject" TEXT,
  "unread_admin_count" NUMERIC,
  "unread_customer_count" NUMERIC,
  "user" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_conversations_user ON public.conversations ("user");
CREATE INDEX IF NOT EXISTS idx_conversations_status ON public.conversations ("status");
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on conversations" ON public.conversations;
CREATE POLICY "Allow all read on conversations" ON public.conversations FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on conversations" ON public.conversations;
CREATE POLICY "Allow authenticated full access on conversations" ON public.conversations FOR ALL TO authenticated USING (true);

-- Table: public.messages
CREATE TABLE IF NOT EXISTS public.messages (
  "attachment_image" TEXT,
  "conversation" TEXT,
  "id" TEXT PRIMARY KEY,
  "is_read" BOOLEAN DEFAULT FALSE,
  "message_text" TEXT,
  "read_at" TEXT,
  "sender_id" TEXT,
  "sender_type" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on messages" ON public.messages;
CREATE POLICY "Allow all read on messages" ON public.messages FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on messages" ON public.messages;
CREATE POLICY "Allow authenticated full access on messages" ON public.messages FOR ALL TO authenticated USING (true);

-- Table: public.store_settings
CREATE TABLE IF NOT EXISTS public.store_settings (
  "address" TEXT,
  "bank_accounts_json" JSONB,
  "banner_image" TEXT,
  "business_hours" TEXT,
  "currency" TEXT,
  "default_shipping_fee" NUMERIC,
  "email" TEXT,
  "facebook_page" TEXT,
  "free_shipping_min_order" NUMERIC,
  "id" TEXT PRIMARY KEY,
  "instagram_handle" TEXT,
  "line_id" TEXT,
  "logo" TEXT,
  "notification_settings_json" JSONB,
  "phone" TEXT,
  "privacy_policy" TEXT,
  "pronunciation" TEXT,
  "return_policy" TEXT,
  "store_full_name" TEXT,
  "store_name" TEXT,
  "tax_settings_json" JSONB,
  "terms_of_service" TEXT,
  "welcome_message" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.store_settings ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on store_settings" ON public.store_settings;
CREATE POLICY "Allow all read on store_settings" ON public.store_settings FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on store_settings" ON public.store_settings;
CREATE POLICY "Allow authenticated full access on store_settings" ON public.store_settings FOR ALL TO authenticated USING (true);

-- Table: public.audit_logs
CREATE TABLE IF NOT EXISTS public.audit_logs (
  "action" TEXT,
  "entity_id" TEXT,
  "entity_type" TEXT,
  "id" TEXT PRIMARY KEY,
  "ip_address" TEXT,
  "new_values_json" JSONB,
  "old_values_json" JSONB,
  "user_agent" TEXT,
  "user_id" TEXT,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
-- Allow public read or authenticated access (adjust policies as needed):
DROP POLICY IF EXISTS "Allow all read on audit_logs" ON public.audit_logs;
CREATE POLICY "Allow all read on audit_logs" ON public.audit_logs FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow authenticated full access on audit_logs" ON public.audit_logs;
CREATE POLICY "Allow authenticated full access on audit_logs" ON public.audit_logs FOR ALL TO authenticated USING (true);

