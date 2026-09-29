-- =========================================================================
-- C-TOWN SNEAKER STORE: 10+ SNEAKER MODELS & VARIANTS SEED MIGRATION
-- Idempotent: can be run repeatedly without duplicates or errors
-- =========================================================================

-- 1. BRANDS
INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandpuma000001', 'Puma', 'puma', 'Iconic German sportswear and classic suede terrace culture', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandasics00001', 'Asics', 'asics', 'Japanese performance running footwear with cutting-edge Gel technology', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- 2. PRODUCTS
INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('t3e0r4d88382z6p', 'Nike Air Force 1 ''07', 'nike-air-force-1-07', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 3700, 'รองเท้าผ้าใบระดับตำนานที่ครองใจสายสตรีทมาอย่างยาวนาน โดดเด่นด้วยหนังพรีเมียมเรียบเนียน โทนสีคลีนสะดุดตา พร้อมระบบกันกระแทก Nike Air ที่สวมใส่สบายได้ตลอดวัน', '', '[]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('ndunklowretro01', 'Nike Dunk Low Retro', 'nike-dunk-low-retro', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 4300, 'สนีกเกอร์บาสเกตบอลไอคอนิกยุค 80s สู่สตรีทแวร์ยอดนิยมตลอดกาล ดีไซน์ทูโทนคลาสสิก หนังพรีเมียม สวมใส่แมตช์ได้กับทุกสไตล์', '', '[]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('80615384541l1aa', 'Adidas Samba OG', 'adidas-samba-og', '3r36h794lepj14c', '8zt2nejef08k1l7', 3800, 'ไอคอนทรงเสน่ห์แห่งยุค Terrace Culture รองเท้าหนังผิวเรียบตกแต่งด้วยหนังกลับรูปตัว T ที่หัวรองเท้า และพื้นยาง Gum Rubber อันเป็นเอกลักษณ์', '', '[]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('agazelleindoor1', 'Adidas Gazelle Indoor', 'adidas-gazelle-indoor', '3r36h794lepj14c', '8zt2nejef08k1l7', 4200, 'รองเท้าหนังกลับระดับตำนานสไตล์เรโทร เสริมเอกลักษณ์ด้วยแถบ 3-Stripes สีขาวคมชัด และพื้นยางโปร่งแสง Gum Sole ยอดฮิต', '', '[]', 1, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('vi3bo1003u2b1fx', 'Converse Chuck 70 High', 'converse-chuck-70-high', '39tzml547t349j0', '8zt2nejef08k1l7', 3300, 'โมเดลระดับตำนานที่ปรับปรุงด้วยผ้าใบ Canvas 12oz หนาทนทาน แผ่นรองเท้า OrthoLite หนานุ่ม สวมใส่สบายตลอดทั้งวัน พร้อมป้ายส้นดำวินเทจ', '', '[]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('vansoldskool001', 'Vans Old Skool Classic', 'vans-old-skool-classic', 'nam1949uo910hfl', '8zt2nejef08k1l7', 2900, 'รองเท้าสเก็ตบอร์ดรุ่นแรกที่มาพร้อมแถบ Jazz Stripe ด้านข้าง ตัวรองเท้าผสมผสานหนังกลับและผ้าใบ แข็งแรงทนทาน พร้อมพื้น Waffle Outsole', '', '[]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('2wf6542jhxbpzw0', 'New Balance 530', 'new-balance-530', '48k4vz24g294fb2', 'q836thmmx9k88ho', 4200, 'สนีกเกอร์สไตล์เรโทรยุค 90-2000 ที่ผสมผสานผ้าตาข่ายระบายอากาศเข้ากับดีเทลสีเงินเมทัลลิก พร้อมเทคโนโลยีซับแรงกระแทก ABZORB น้ำหนักเบา สบายเท้า', '', '[]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('nb574coregrey01', 'New Balance 574 Core', 'new-balance-574-core', '48k4vz24g294fb2', '8zt2nejef08k1l7', 3600, 'โมเดลที่คงความคลาสสิกเหนือกาลเวลา ตัวรองเท้าหนังกลับเกรดพรีเมียม นุ่มสบายด้วยพื้นรองเท้าชั้นกลาง ENCAP รองรับแรงกระแทกได้ยอดเยี่ยม', '', '[]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('pumasuedeclsx01', 'Puma Suede Classic XXI', 'puma-suede-classic-xxi', 'brandpuma000001', '8zt2nejef08k1l7', 3200, 'ไอคอนวัฒนธรรมสตรีทแวร์และฮิปฮอปรุ่นบุกเบิก ผลิตจากหนังกลับคุณภาพสูงแท้ทั้งคู่ โลโก้ Formstrip สีขาวตัดดำโดดเด่น พื้นยางหนึบทนทาน', '', '[]', 1, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('asicsgelkayan01', 'Asics Gel-Kayano 14', 'asics-gel-kayano-14', 'brandasics00001', 'q836thmmx9k88ho', 5900, 'สนีกเกอร์สาย Tech Runner ยุค Y2K ที่ผสานความล้ำสมัยด้วยวัสดุ Metallic Silver และตาข่ายระบายอากาศ พร้อมเทคโนโลยีซับแรงกระแทก GEL แบบเต็มแผ่น', '', '[]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('1z0000jxdn85et7', 'Air Jordan 1 Low', 'air-jordan-1-low', 's4v017q398h3309', '8zt2nejef08k1l7', 4500, 'แรงบันดาลใจจากรุ่นออริจินัลปี 1985 ดีไซน์ข้อต่ำที่โฉบเฉี่ยวสะอาดตา เหมาะสำหรับสวมใส่ในทุกโอกาส ประดับโลโก้ Wings อันเป็นเอกลักษณ์ที่ส้นรองเท้า', '', '[]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, main_image = EXCLUDED.main_image;

-- 3. PRODUCT VARIANTS
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83600001', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-36', 'White', '#ffffff', '36', 2400, 3700, 0, 12, 5, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83700002', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-37', 'White', '#ffffff', '37', 2400, 3700, 0, 12, 2, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83800003', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-38', 'White', '#ffffff', '38', 2400, 3700, 0, 12, 6, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83900004', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-39', 'White', '#ffffff', '39', 2400, 3700, 0, 12, 1, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84000005', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-40', 'White', '#ffffff', '40', 2400, 3700, 0, 12, 1, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84100006', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-41', 'White', '#ffffff', '41', 2400, 3700, 0, 12, 3, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84200007', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-42', 'White', '#ffffff', '42', 2400, 3700, 0, 12, 5, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84300008', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-43', 'White', '#ffffff', '43', 2400, 3700, 0, 12, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84400009', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-44', 'White', '#ffffff', '44', 2400, 3700, 0, 12, 4, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84500010', 't3e0r4d88382z6p', 'NIK-NIKE-WHI-45', 'White', '#ffffff', '45', 2400, 3700, 0, 12, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83800011', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-38', 'Triple Black', '#1a1a1a', '38', 2400, 3700, 0, 8, 3, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83900012', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-39', 'Triple Black', '#1a1a1a', '39', 2400, 3700, 0, 8, 3, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84000013', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-40', 'Triple Black', '#1a1a1a', '40', 2400, 3700, 0, 8, 1, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84100014', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-41', 'Triple Black', '#1a1a1a', '41', 2400, 3700, 0, 8, 3, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84200015', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-42', 'Triple Black', '#1a1a1a', '42', 2400, 3700, 0, 8, 5, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84300016', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-43', 'Triple Black', '#1a1a1a', '43', 2400, 3700, 0, 8, 6, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84400017', 't3e0r4d88382z6p', 'NIK-NIKE-TRI-44', 'Triple Black', '#1a1a1a', '44', 2400, 3700, 0, 8, 3, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83600018', 't3e0r4d88382z6p', 'NIK-NIKE-ROS-36', 'Rose Pink', '#f7b2bd', '36', 2500, 3900, 3700, 6, 4, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83700019', 't3e0r4d88382z6p', 'NIK-NIKE-ROS-37', 'Rose Pink', '#f7b2bd', '37', 2500, 3900, 3700, 6, 8, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83800020', 't3e0r4d88382z6p', 'NIK-NIKE-ROS-38', 'Rose Pink', '#f7b2bd', '38', 2500, 3900, 3700, 6, 8, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d83900021', 't3e0r4d88382z6p', 'NIK-NIKE-ROS-39', 'Rose Pink', '#f7b2bd', '39', 2500, 3900, 3700, 6, 6, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('t3e0r4d84000022', 't3e0r4d88382z6p', 'NIK-NIKE-ROS-40', 'Rose Pink', '#f7b2bd', '40', 2500, 3900, 3700, 6, 8, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3600001', 'ndunklowretro01', 'NIK-NIKE-PAN-36', 'Panda Black/White', '#000000', '36', 2700, 4300, 0, 10, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3700002', 'ndunklowretro01', 'NIK-NIKE-PAN-37', 'Panda Black/White', '#000000', '37', 2700, 4300, 0, 10, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3800003', 'ndunklowretro01', 'NIK-NIKE-PAN-38', 'Panda Black/White', '#000000', '38', 2700, 4300, 0, 10, 2, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3900004', 'ndunklowretro01', 'NIK-NIKE-PAN-39', 'Panda Black/White', '#000000', '39', 2700, 4300, 0, 10, 1, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4000005', 'ndunklowretro01', 'NIK-NIKE-PAN-40', 'Panda Black/White', '#000000', '40', 2700, 4300, 0, 10, 5, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4100006', 'ndunklowretro01', 'NIK-NIKE-PAN-41', 'Panda Black/White', '#000000', '41', 2700, 4300, 0, 10, 7, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4200007', 'ndunklowretro01', 'NIK-NIKE-PAN-42', 'Panda Black/White', '#000000', '42', 2700, 4300, 0, 10, 6, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4300008', 'ndunklowretro01', 'NIK-NIKE-PAN-43', 'Panda Black/White', '#000000', '43', 2700, 4300, 0, 10, 3, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4400009', 'ndunklowretro01', 'NIK-NIKE-PAN-44', 'Panda Black/White', '#000000', '44', 2700, 4300, 0, 10, 4, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4500010', 'ndunklowretro01', 'NIK-NIKE-PAN-45', 'Panda Black/White', '#000000', '45', 2700, 4300, 0, 10, 4, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3800011', 'ndunklowretro01', 'NIK-NIKE-GRE-38', 'Grey Fog', '#b0b7bd', '38', 2700, 4500, 0, 7, 5, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow3900012', 'ndunklowretro01', 'NIK-NIKE-GRE-39', 'Grey Fog', '#b0b7bd', '39', 2700, 4500, 0, 7, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4000013', 'ndunklowretro01', 'NIK-NIKE-GRE-40', 'Grey Fog', '#b0b7bd', '40', 2700, 4500, 0, 7, 7, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4100014', 'ndunklowretro01', 'NIK-NIKE-GRE-41', 'Grey Fog', '#b0b7bd', '41', 2700, 4500, 0, 7, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4200015', 'ndunklowretro01', 'NIK-NIKE-GRE-42', 'Grey Fog', '#b0b7bd', '42', 2700, 4500, 0, 7, 2, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4300016', 'ndunklowretro01', 'NIK-NIKE-GRE-43', 'Grey Fog', '#b0b7bd', '43', 2700, 4500, 0, 7, 4, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow4400017', 'ndunklowretro01', 'NIK-NIKE-GRE-44', 'Grey Fog', '#b0b7bd', '44', 2700, 4500, 0, 7, 4, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843600001', '80615384541l1aa', 'ADI-ADID-CLO-36', 'Cloud White / Core Black', '#f8f8f8', '36', 2300, 3800, 0, 14, 3, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843700002', '80615384541l1aa', 'ADI-ADID-CLO-37', 'Cloud White / Core Black', '#f8f8f8', '37', 2300, 3800, 0, 14, 1, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843800003', '80615384541l1aa', 'ADI-ADID-CLO-38', 'Cloud White / Core Black', '#f8f8f8', '38', 2300, 3800, 0, 14, 4, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843900004', '80615384541l1aa', 'ADI-ADID-CLO-39', 'Cloud White / Core Black', '#f8f8f8', '39', 2300, 3800, 0, 14, 4, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844000005', '80615384541l1aa', 'ADI-ADID-CLO-40', 'Cloud White / Core Black', '#f8f8f8', '40', 2300, 3800, 0, 14, 1, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844100006', '80615384541l1aa', 'ADI-ADID-CLO-41', 'Cloud White / Core Black', '#f8f8f8', '41', 2300, 3800, 0, 14, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844200007', '80615384541l1aa', 'ADI-ADID-CLO-42', 'Cloud White / Core Black', '#f8f8f8', '42', 2300, 3800, 0, 14, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844300008', '80615384541l1aa', 'ADI-ADID-CLO-43', 'Cloud White / Core Black', '#f8f8f8', '43', 2300, 3800, 0, 14, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844400009', '80615384541l1aa', 'ADI-ADID-CLO-44', 'Cloud White / Core Black', '#f8f8f8', '44', 2300, 3800, 0, 14, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844500010', '80615384541l1aa', 'ADI-ADID-CLO-45', 'Cloud White / Core Black', '#f8f8f8', '45', 2300, 3800, 0, 14, 2, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843800011', '80615384541l1aa', 'ADI-ADID-COR-38', 'Core Black / Cloud White', '#111111', '38', 2300, 3800, 0, 8, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153843900012', '80615384541l1aa', 'ADI-ADID-COR-39', 'Core Black / Cloud White', '#111111', '39', 2300, 3800, 0, 8, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844000013', '80615384541l1aa', 'ADI-ADID-COR-40', 'Core Black / Cloud White', '#111111', '40', 2300, 3800, 0, 8, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844100014', '80615384541l1aa', 'ADI-ADID-COR-41', 'Core Black / Cloud White', '#111111', '41', 2300, 3800, 0, 8, 3, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844200015', '80615384541l1aa', 'ADI-ADID-COR-42', 'Core Black / Cloud White', '#111111', '42', 2300, 3800, 0, 8, 6, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844300016', '80615384541l1aa', 'ADI-ADID-COR-43', 'Core Black / Cloud White', '#111111', '43', 2300, 3800, 0, 8, 2, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('806153844400017', '80615384541l1aa', 'ADI-ADID-COR-44', 'Core Black / Cloud White', '#111111', '44', 2300, 3800, 0, 8, 4, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3600001', 'agazelleindoor1', 'ADI-ADID-COL-36', 'Collegiate Navy / Gum', '#1b2a4a', '36', 2500, 4200, 0, 12, 5, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3700002', 'agazelleindoor1', 'ADI-ADID-COL-37', 'Collegiate Navy / Gum', '#1b2a4a', '37', 2500, 4200, 0, 12, 3, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3800003', 'agazelleindoor1', 'ADI-ADID-COL-38', 'Collegiate Navy / Gum', '#1b2a4a', '38', 2500, 4200, 0, 12, 7, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3900004', 'agazelleindoor1', 'ADI-ADID-COL-39', 'Collegiate Navy / Gum', '#1b2a4a', '39', 2500, 4200, 0, 12, 7, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4000005', 'agazelleindoor1', 'ADI-ADID-COL-40', 'Collegiate Navy / Gum', '#1b2a4a', '40', 2500, 4200, 0, 12, 7, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4100006', 'agazelleindoor1', 'ADI-ADID-COL-41', 'Collegiate Navy / Gum', '#1b2a4a', '41', 2500, 4200, 0, 12, 4, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4200007', 'agazelleindoor1', 'ADI-ADID-COL-42', 'Collegiate Navy / Gum', '#1b2a4a', '42', 2500, 4200, 0, 12, 4, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4300008', 'agazelleindoor1', 'ADI-ADID-COL-43', 'Collegiate Navy / Gum', '#1b2a4a', '43', 2500, 4200, 0, 12, 7, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4400009', 'agazelleindoor1', 'ADI-ADID-COL-44', 'Collegiate Navy / Gum', '#1b2a4a', '44', 2500, 4200, 0, 12, 6, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4500010', 'agazelleindoor1', 'ADI-ADID-COL-45', 'Collegiate Navy / Gum', '#1b2a4a', '45', 2500, 4200, 0, 12, 2, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3700011', 'agazelleindoor1', 'ADI-ADID-SCA-37', 'Scarlet Red / Gum', '#ba1b1d', '37', 2500, 4200, 3990, 6, 5, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3800012', 'agazelleindoor1', 'ADI-ADID-SCA-38', 'Scarlet Red / Gum', '#ba1b1d', '38', 2500, 4200, 3990, 6, 3, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle3900013', 'agazelleindoor1', 'ADI-ADID-SCA-39', 'Scarlet Red / Gum', '#ba1b1d', '39', 2500, 4200, 3990, 6, 1, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4000014', 'agazelleindoor1', 'ADI-ADID-SCA-40', 'Scarlet Red / Gum', '#ba1b1d', '40', 2500, 4200, 3990, 6, 4, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4100015', 'agazelleindoor1', 'ADI-ADID-SCA-41', 'Scarlet Red / Gum', '#ba1b1d', '41', 2500, 4200, 3990, 6, 8, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4200016', 'agazelleindoor1', 'ADI-ADID-SCA-42', 'Scarlet Red / Gum', '#ba1b1d', '42', 2500, 4200, 3990, 6, 5, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle4300017', 'agazelleindoor1', 'ADI-ADID-SCA-43', 'Scarlet Red / Gum', '#ba1b1d', '43', 2500, 4200, 3990, 6, 8, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003600001', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-36', 'Classic Black', '#111111', '36', 1900, 3300, 0, 15, 1, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003700002', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-37', 'Classic Black', '#111111', '37', 1900, 3300, 0, 15, 1, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003800003', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-38', 'Classic Black', '#111111', '38', 1900, 3300, 0, 15, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003900004', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-39', 'Classic Black', '#111111', '39', 1900, 3300, 0, 15, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004000005', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-40', 'Classic Black', '#111111', '40', 1900, 3300, 0, 15, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004100006', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-41', 'Classic Black', '#111111', '41', 1900, 3300, 0, 15, 2, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004200007', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-42', 'Classic Black', '#111111', '42', 1900, 3300, 0, 15, 1, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004300008', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-43', 'Classic Black', '#111111', '43', 1900, 3300, 0, 15, 2, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004400009', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-44', 'Classic Black', '#111111', '44', 1900, 3300, 0, 15, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004500010', 'vi3bo1003u2b1fx', 'CON-CONV-CLA-45', 'Classic Black', '#111111', '45', 1900, 3300, 0, 15, 2, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003600011', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-36', 'Parchment White', '#fdfbf7', '36', 1900, 3300, 0, 9, 3, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003700012', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-37', 'Parchment White', '#fdfbf7', '37', 1900, 3300, 0, 9, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003800013', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-38', 'Parchment White', '#fdfbf7', '38', 1900, 3300, 0, 9, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1003900014', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-39', 'Parchment White', '#fdfbf7', '39', 1900, 3300, 0, 9, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004000015', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-40', 'Parchment White', '#fdfbf7', '40', 1900, 3300, 0, 9, 3, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004100016', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-41', 'Parchment White', '#fdfbf7', '41', 1900, 3300, 0, 9, 4, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004200017', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-42', 'Parchment White', '#fdfbf7', '42', 1900, 3300, 0, 9, 2, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004300018', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-43', 'Parchment White', '#fdfbf7', '43', 1900, 3300, 0, 9, 2, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1004400019', 'vi3bo1003u2b1fx', 'CON-CONV-PAR-44', 'Parchment White', '#fdfbf7', '44', 1900, 3300, 0, 9, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3600001', 'vansoldskool001', 'VAN-VANS-BLA-36', 'Black / White', '#1a1a1a', '36', 1600, 2900, 0, 16, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3700002', 'vansoldskool001', 'VAN-VANS-BLA-37', 'Black / White', '#1a1a1a', '37', 1600, 2900, 0, 16, 3, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3800003', 'vansoldskool001', 'VAN-VANS-BLA-38', 'Black / White', '#1a1a1a', '38', 1600, 2900, 0, 16, 2, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3900004', 'vansoldskool001', 'VAN-VANS-BLA-39', 'Black / White', '#1a1a1a', '39', 1600, 2900, 0, 16, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4000005', 'vansoldskool001', 'VAN-VANS-BLA-40', 'Black / White', '#1a1a1a', '40', 1600, 2900, 0, 16, 2, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4100006', 'vansoldskool001', 'VAN-VANS-BLA-41', 'Black / White', '#1a1a1a', '41', 1600, 2900, 0, 16, 4, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4200007', 'vansoldskool001', 'VAN-VANS-BLA-42', 'Black / White', '#1a1a1a', '42', 1600, 2900, 0, 16, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4300008', 'vansoldskool001', 'VAN-VANS-BLA-43', 'Black / White', '#1a1a1a', '43', 1600, 2900, 0, 16, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4400009', 'vansoldskool001', 'VAN-VANS-BLA-44', 'Black / White', '#1a1a1a', '44', 1600, 2900, 0, 16, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4500010', 'vansoldskool001', 'VAN-VANS-BLA-45', 'Black / White', '#1a1a1a', '45', 1600, 2900, 0, 16, 3, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3700011', 'vansoldskool001', 'VAN-VANS-TRU-37', 'True White', '#ffffff', '37', 1600, 2900, 0, 8, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3800012', 'vansoldskool001', 'VAN-VANS-TRU-38', 'True White', '#ffffff', '38', 1600, 2900, 0, 8, 2, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds3900013', 'vansoldskool001', 'VAN-VANS-TRU-39', 'True White', '#ffffff', '39', 1600, 2900, 0, 8, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4000014', 'vansoldskool001', 'VAN-VANS-TRU-40', 'True White', '#ffffff', '40', 1600, 2900, 0, 8, 2, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4100015', 'vansoldskool001', 'VAN-VANS-TRU-41', 'True White', '#ffffff', '41', 1600, 2900, 0, 8, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4200016', 'vansoldskool001', 'VAN-VANS-TRU-42', 'True White', '#ffffff', '42', 1600, 2900, 0, 8, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4300017', 'vansoldskool001', 'VAN-VANS-TRU-43', 'True White', '#ffffff', '43', 1600, 2900, 0, 8, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds4400018', 'vansoldskool001', 'VAN-VANS-TRU-44', 'True White', '#ffffff', '44', 1600, 2900, 0, 8, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3600001', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-36', 'Steel Grey / Silver', '#c4c4c4', '36', 2600, 4200, 0, 14, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3700002', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-37', 'Steel Grey / Silver', '#c4c4c4', '37', 2600, 4200, 0, 14, 4, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3800003', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-38', 'Steel Grey / Silver', '#c4c4c4', '38', 2600, 4200, 0, 14, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3900004', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-39', 'Steel Grey / Silver', '#c4c4c4', '39', 2600, 4200, 0, 14, 3, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4000005', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-40', 'Steel Grey / Silver', '#c4c4c4', '40', 2600, 4200, 0, 14, 1, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4100006', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-41', 'Steel Grey / Silver', '#c4c4c4', '41', 2600, 4200, 0, 14, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4200007', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-42', 'Steel Grey / Silver', '#c4c4c4', '42', 2600, 4200, 0, 14, 4, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4300008', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-43', 'Steel Grey / Silver', '#c4c4c4', '43', 2600, 4200, 0, 14, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4400009', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-44', 'Steel Grey / Silver', '#c4c4c4', '44', 2600, 4200, 0, 14, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4500010', '2wf6542jhxbpzw0', 'NEW-NEWB-STE-45', 'Steel Grey / Silver', '#c4c4c4', '45', 2600, 4200, 0, 14, 3, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3700011', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-37', 'White / Navy', '#ffffff', '37', 2600, 4200, 3890, 8, 2, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3800012', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-38', 'White / Navy', '#ffffff', '38', 2600, 4200, 3890, 8, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j3900013', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-39', 'White / Navy', '#ffffff', '39', 2600, 4200, 3890, 8, 4, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4000014', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-40', 'White / Navy', '#ffffff', '40', 2600, 4200, 3890, 8, 1, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4100015', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-41', 'White / Navy', '#ffffff', '41', 2600, 4200, 3890, 8, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4200016', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-42', 'White / Navy', '#ffffff', '42', 2600, 4200, 3890, 8, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4300017', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-43', 'White / Navy', '#ffffff', '43', 2600, 4200, 3890, 8, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j4400018', '2wf6542jhxbpzw0', 'NEW-NEWB-WHI-44', 'White / Navy', '#ffffff', '44', 2600, 4200, 3890, 8, 3, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3600001', 'nb574coregrey01', 'NEW-NEWB-CLA-36', 'Classic Grey', '#7a7d81', '36', 2100, 3600, 0, 12, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3700002', 'nb574coregrey01', 'NEW-NEWB-CLA-37', 'Classic Grey', '#7a7d81', '37', 2100, 3600, 0, 12, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3800003', 'nb574coregrey01', 'NEW-NEWB-CLA-38', 'Classic Grey', '#7a7d81', '38', 2100, 3600, 0, 12, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3900004', 'nb574coregrey01', 'NEW-NEWB-CLA-39', 'Classic Grey', '#7a7d81', '39', 2100, 3600, 0, 12, 4, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4000005', 'nb574coregrey01', 'NEW-NEWB-CLA-40', 'Classic Grey', '#7a7d81', '40', 2100, 3600, 0, 12, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4100006', 'nb574coregrey01', 'NEW-NEWB-CLA-41', 'Classic Grey', '#7a7d81', '41', 2100, 3600, 0, 12, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4200007', 'nb574coregrey01', 'NEW-NEWB-CLA-42', 'Classic Grey', '#7a7d81', '42', 2100, 3600, 0, 12, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4300008', 'nb574coregrey01', 'NEW-NEWB-CLA-43', 'Classic Grey', '#7a7d81', '43', 2100, 3600, 0, 12, 2, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4400009', 'nb574coregrey01', 'NEW-NEWB-CLA-44', 'Classic Grey', '#7a7d81', '44', 2100, 3600, 0, 12, 2, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4500010', 'nb574coregrey01', 'NEW-NEWB-CLA-45', 'Classic Grey', '#7a7d81', '45', 2100, 3600, 0, 12, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3800011', 'nb574coregrey01', 'NEW-NEWB-NAV-38', 'Navy Blue', '#1a2639', '38', 2100, 3600, 0, 7, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor3900012', 'nb574coregrey01', 'NEW-NEWB-NAV-39', 'Navy Blue', '#1a2639', '39', 2100, 3600, 0, 7, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4000013', 'nb574coregrey01', 'NEW-NEWB-NAV-40', 'Navy Blue', '#1a2639', '40', 2100, 3600, 0, 7, 3, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4100014', 'nb574coregrey01', 'NEW-NEWB-NAV-41', 'Navy Blue', '#1a2639', '41', 2100, 3600, 0, 7, 3, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4200015', 'nb574coregrey01', 'NEW-NEWB-NAV-42', 'Navy Blue', '#1a2639', '42', 2100, 3600, 0, 7, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4300016', 'nb574coregrey01', 'NEW-NEWB-NAV-43', 'Navy Blue', '#1a2639', '43', 2100, 3600, 0, 7, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor4400017', 'nb574coregrey01', 'NEW-NEWB-NAV-44', 'Navy Blue', '#1a2639', '44', 2100, 3600, 0, 7, 3, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3600001', 'pumasuedeclsx01', 'PUM-PUMA-PUM-36', 'Puma Black / White', '#141414', '36', 1800, 3200, 0, 15, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3700002', 'pumasuedeclsx01', 'PUM-PUMA-PUM-37', 'Puma Black / White', '#141414', '37', 1800, 3200, 0, 15, 3, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3800003', 'pumasuedeclsx01', 'PUM-PUMA-PUM-38', 'Puma Black / White', '#141414', '38', 1800, 3200, 0, 15, 1, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3900004', 'pumasuedeclsx01', 'PUM-PUMA-PUM-39', 'Puma Black / White', '#141414', '39', 1800, 3200, 0, 15, 6, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4000005', 'pumasuedeclsx01', 'PUM-PUMA-PUM-40', 'Puma Black / White', '#141414', '40', 1800, 3200, 0, 15, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4100006', 'pumasuedeclsx01', 'PUM-PUMA-PUM-41', 'Puma Black / White', '#141414', '41', 1800, 3200, 0, 15, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4200007', 'pumasuedeclsx01', 'PUM-PUMA-PUM-42', 'Puma Black / White', '#141414', '42', 1800, 3200, 0, 15, 8, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4300008', 'pumasuedeclsx01', 'PUM-PUMA-PUM-43', 'Puma Black / White', '#141414', '43', 1800, 3200, 0, 15, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4400009', 'pumasuedeclsx01', 'PUM-PUMA-PUM-44', 'Puma Black / White', '#141414', '44', 1800, 3200, 0, 15, 1, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4500010', 'pumasuedeclsx01', 'PUM-PUMA-PUM-45', 'Puma Black / White', '#141414', '45', 1800, 3200, 0, 15, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3800011', 'pumasuedeclsx01', 'PUM-PUMA-PEA-38', 'Peacoat Navy', '#1d2951', '38', 1800, 3200, 0, 8, 6, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued3900012', 'pumasuedeclsx01', 'PUM-PUMA-PEA-39', 'Peacoat Navy', '#1d2951', '39', 1800, 3200, 0, 8, 2, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4000013', 'pumasuedeclsx01', 'PUM-PUMA-PEA-40', 'Peacoat Navy', '#1d2951', '40', 1800, 3200, 0, 8, 3, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4100014', 'pumasuedeclsx01', 'PUM-PUMA-PEA-41', 'Peacoat Navy', '#1d2951', '41', 1800, 3200, 0, 8, 7, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4200015', 'pumasuedeclsx01', 'PUM-PUMA-PEA-42', 'Peacoat Navy', '#1d2951', '42', 1800, 3200, 0, 8, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4300016', 'pumasuedeclsx01', 'PUM-PUMA-PEA-43', 'Peacoat Navy', '#1d2951', '43', 1800, 3200, 0, 8, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued4400017', 'pumasuedeclsx01', 'PUM-PUMA-PEA-44', 'Peacoat Navy', '#1d2951', '44', 1800, 3200, 0, 8, 8, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3600001', 'asicsgelkayan01', 'ASI-ASIC-PUR-36', 'Pure Silver / White', '#d4d8db', '36', 3700, 5900, 0, 10, 2, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3700002', 'asicsgelkayan01', 'ASI-ASIC-PUR-37', 'Pure Silver / White', '#d4d8db', '37', 3700, 5900, 0, 10, 4, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3800003', 'asicsgelkayan01', 'ASI-ASIC-PUR-38', 'Pure Silver / White', '#d4d8db', '38', 3700, 5900, 0, 10, 3, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3900004', 'asicsgelkayan01', 'ASI-ASIC-PUR-39', 'Pure Silver / White', '#d4d8db', '39', 3700, 5900, 0, 10, 2, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4000005', 'asicsgelkayan01', 'ASI-ASIC-PUR-40', 'Pure Silver / White', '#d4d8db', '40', 3700, 5900, 0, 10, 5, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4100006', 'asicsgelkayan01', 'ASI-ASIC-PUR-41', 'Pure Silver / White', '#d4d8db', '41', 3700, 5900, 0, 10, 8, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4200007', 'asicsgelkayan01', 'ASI-ASIC-PUR-42', 'Pure Silver / White', '#d4d8db', '42', 3700, 5900, 0, 10, 8, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4300008', 'asicsgelkayan01', 'ASI-ASIC-PUR-43', 'Pure Silver / White', '#d4d8db', '43', 3700, 5900, 0, 10, 3, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4400009', 'asicsgelkayan01', 'ASI-ASIC-PUR-44', 'Pure Silver / White', '#d4d8db', '44', 3700, 5900, 0, 10, 7, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4500010', 'asicsgelkayan01', 'ASI-ASIC-PUR-45', 'Pure Silver / White', '#d4d8db', '45', 3700, 5900, 0, 10, 7, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3800011', 'asicsgelkayan01', 'ASI-ASIC-GLA-38', 'Glacier Grey / Black', '#8b939c', '38', 3700, 5900, 5490, 6, 1, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel3900012', 'asicsgelkayan01', 'ASI-ASIC-GLA-39', 'Glacier Grey / Black', '#8b939c', '39', 3700, 5900, 5490, 6, 1, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4000013', 'asicsgelkayan01', 'ASI-ASIC-GLA-40', 'Glacier Grey / Black', '#8b939c', '40', 3700, 5900, 5490, 6, 5, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4100014', 'asicsgelkayan01', 'ASI-ASIC-GLA-41', 'Glacier Grey / Black', '#8b939c', '41', 3700, 5900, 5490, 6, 1, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4200015', 'asicsgelkayan01', 'ASI-ASIC-GLA-42', 'Glacier Grey / Black', '#8b939c', '42', 3700, 5900, 5490, 6, 5, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4300016', 'asicsgelkayan01', 'ASI-ASIC-GLA-43', 'Glacier Grey / Black', '#8b939c', '43', 3700, 5900, 5490, 6, 1, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel4400017', 'asicsgelkayan01', 'ASI-ASIC-GLA-44', 'Glacier Grey / Black', '#8b939c', '44', 3700, 5900, 5490, 6, 6, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx3800001', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-38', 'Bred Toe / Chicago', '#c8102e', '38', 2800, 4500, 0, 9, 3, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx3900002', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-39', 'Bred Toe / Chicago', '#c8102e', '39', 2800, 4500, 0, 9, 4, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx4000003', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-40', 'Bred Toe / Chicago', '#c8102e', '40', 2800, 4500, 0, 9, 4, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx4100004', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-41', 'Bred Toe / Chicago', '#c8102e', '41', 2800, 4500, 0, 9, 7, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx4200005', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-42', 'Bred Toe / Chicago', '#c8102e', '42', 2800, 4500, 0, 9, 5, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx4300006', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-43', 'Bred Toe / Chicago', '#c8102e', '43', 2800, 4500, 0, 9, 4, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, sold_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx4400007', '1z0000jxdn85et7', 'JOR-AIRJ-BRE-44', 'Bred Toe / Chicago', '#c8102e', '44', 2800, 4500, 0, 9, 5, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, cost_price = EXCLUDED.cost_price, image_url = EXCLUDED.image_url, status = EXCLUDED.status;

