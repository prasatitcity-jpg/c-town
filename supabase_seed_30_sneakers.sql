-- =========================================================================
-- C-TOWN SNEAKER STORE: 32 SNEAKER MODELS & VARIANTS SEED MIGRATION
-- Idempotent: can be run repeatedly without duplicates or errors
-- =========================================================================

-- 1. BRANDS
INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('6gh3j5j96rt57cz', 'Nike', 'nike', 'Just Do It. ผู้นำนวัตกรรมรองเท้ากีฬาระดับโลก', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('3r36h794lepj14c', 'Adidas', 'adidas', 'Impossible Is Nothing. สตรีทแวร์และคลาสสิกออริจินัล', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('nam1949uo910hfl', 'New Balance', 'new-balance', 'Fearlessly Independent. สนีกเกอร์ไลฟ์สไตล์ระดับพรีเมียม', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('39tzml547t349j0', 'Converse', 'converse', 'Original Chucks. สนีกเกอร์ผ้าใบไอคอนิกตลอดกาล', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('nam1949uo910hvx', 'Vans', 'vans', 'Off The Wall. สเก็ตบอร์ดและสตรีทแฟชั่นระดับตำนาน', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandpuma000001', 'Puma', 'puma', 'Forever Faster. สปอร์ตไลฟ์สไตล์และวัฒนธรรมเทอเรซ', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandasics00001', 'Asics', 'asics', 'Sound Mind, Sound Body. นวัตกรรมเทคโนโลยีเจล', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandjordan0001', 'Air Jordan', 'air-jordan', 'His Airness. แบรนด์บาสเก็ตบอลและไฮป์สตรีทระดับโลก', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandtiger00001', 'Onitsuka Tiger', 'onitsuka-tiger', 'Vintage Japanese Heritage sneakers', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.brands (id, name, slug, description, logo, is_active)
VALUES ('brandsalomon001', 'Salomon', 'salomon', 'Trail running and outdoor fashion gorpcore icon', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- 2. CATEGORIES
INSERT INTO public.categories (id, name, slug, description, is_active)
VALUES ('8zt2nejef08k1l7', 'สนีกเกอร์ไลฟ์สไตล์', 'lifestyle', 'รองเท้าใส่เที่ยว เดินเล่น แมตช์ได้กับทุกชุด', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.categories (id, name, slug, description, is_active)
VALUES ('p0m0n0s0t0u0v0w', 'รองเท้าวิ่ง / สปอร์ต', 'running', 'รองเท้าวิ่งเพื่อสุขภาพ ซัพพอร์ตเท้าดีเยี่ยม', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.categories (id, name, slug, description, is_active)
VALUES ('b0a0s0k0e0t0b0l', 'รองเท้าบาสเกตบอล', 'basketball', 'รองเท้าบาสสไตล์สตรีท หุ้มข้อและข้อสั้น', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.categories (id, name, slug, description, is_active)
VALUES ('s0k0a0t0e0b0o0a', 'รองเท้าสเก็ตบอร์ด', 'skate', 'รองเท้าพื้นแบน ทนทาน เกาะบอร์ดได้ดี', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

INSERT INTO public.categories (id, name, slug, description, is_active)
VALUES ('t0e0r0r0a0c0e0s', 'คลาสสิกเรโทร', 'retro', 'โมเดลย้อนยุค สไตล์วินเทจยอดนิยม', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- 3. PRODUCTS
INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nike_af1', 'Nike Air Force 1 ''07', 'nike-air-force-1-07', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 3700, 'สนีกเกอร์ระดับตำนานที่ครองใจสายสตรีทมาอย่างยาวนาน โดดเด่นด้วยหนังพรีเมียมเรียบเนียน โทนสีคลีนสะดุดตา พร้อมระบบกันกระแทก Nike Air ที่สวมใส่สบายได้ตลอดวัน', '', '["/images/products/nike_af1_white.jpg","/images/products/nike_af1_black.jpg","/images/products/nike_af1_pink.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('ndunklowretro01', 'Nike Dunk Low Retro', 'nike-dunk-low-retro', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 4300, 'สนีกเกอร์บาสเกตบอลไอคอนิกยุค 80s สู่สตรีทแวร์ยอดนิยมตลอดกาล ดีไซน์ทูโทนคลาสสิก หนังพรีเมียม สวมใส่แมตช์ได้กับทุกสไตล์', '', '["/images/products/dunk_low_panda.jpg","/images/products/dunk_low_panda.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nike_am1', 'Nike Air Max 1 ''86 OG', 'nike-air-max-1-86-og', '6gh3j5j96rt57cz', 't0e0r0r0a0c0e0s', 5400, 'การกลับมาของจุดเริ่มต้นระบบ Visible Air ในตำนาน ดีไซน์ Big Bubble ยุคออริจินัล สีขาวตัดแดง Sport Red โดดเด่นไม่ซ้ำใคร', '', '["/images/products/nike_af1_white.jpg","/images/products/nike_af1_black.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nike_am90', 'Nike Air Max 90', 'nike-air-max-90', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 4700, 'ดีไซน์สปอร์ตยุค 90s ขนานแท้ พื้นรองเท้า Waffle ดั้งเดิมพร้อม Air Unit บริเวณส้นเท้า รองรับแรงกระแทกได้ยอดเยี่ยม', '', '["/images/products/nike_af1_white.jpg","/images/products/nike_af1_white.jpg"]', 0, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nike_am97', 'Nike Air Max 97', 'nike-air-max-97', '6gh3j5j96rt57cz', '8zt2nejef08k1l7', 6200, 'แรงบันดาลใจจากรถไฟชินคันเซ็น ดีไซน์ลอนคลื่นสะท้อนแสง 3M พร้อม Full-length Air Max ตั้งแต่ส้นจรดปลายเท้า', '', '["/images/products/nb530_silver.jpg","/images/products/nb530_silver.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('1z0000jxdn85et7', 'Air Jordan 1 Low', 'air-jordan-1-low', 'brandjordan0001', 'b0a0s0k0e0t0b0l', 4500, 'โมเดลสนีกเกอร์ระดับตำนานจาก Jordan Brand ดีไซน์ข้อสั้นสวมใส่ง่าย แต่งดีเทล Wings Logo ที่ส้นเท้า หนังพรีเมียมเกรดสะสม', '', '["/images/products/jordan1_rose_gold.jpg","/images/products/jordan1_rose_gold.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_aj1_mid', 'Air Jordan 1 Mid', 'air-jordan-1-mid', 'brandjordan0001', 'b0a0s0k0e0t0b0l', 4900, 'ความลงตัวระหว่างลุคเรโทรบาสเกตบอลและสตรีทแวร์ยุคใหม่ ล็อคข้อเท้ากระชับ หนังแท้ผสมหนังซินเทติกเพื่อความทนทาน', '', '["/images/products/jordan1_rose_gold.jpg","/images/products/nb574_grey.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_aj4_retro', 'Air Jordan 4 Retro', 'air-jordan-4-retro', 'brandjordan0001', 'b0a0s0k0e0t0b0l', 7900, 'โมเดลยอดนิยมสูงสุดของสายสนีกเกอร์เฮด ตะแกรงข้าง Mesh อันเป็นเอกลักษณ์ และแถบปีก Support Wing สวยงามทรงคุณค่า', '', '["/images/products/dunk_low_panda.jpg","/images/products/nike_af1_white.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('80615384541l1aa', 'Adidas Samba OG', 'adidas-samba-og', '3r36h794lepj14c', 't0e0r0r0a0c0e0s', 3800, 'ไอคอนทรงเสน่ห์แห่งยุค Terrace Culture รองเท้าหนังผิวเรียบตกแต่งด้วยหนังกลับรูปตัว T ที่หัวรองเท้า และพื้นยาง Gum Rubber', '', '["/images/products/adidas_samba_white.jpg","/images/products/puma_suede_black.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('agazelleindoor1', 'Adidas Gazelle Indoor', 'adidas-gazelle-indoor', '3r36h794lepj14c', 't0e0r0r0a0c0e0s', 4200, 'รองเท้าหนังกลับระดับตำนานสไตล์เรโทร เสริมเอกลักษณ์ด้วยแถบ 3-Stripes สีขาวคมชัด และพื้นยางโปร่งแสง Gum Sole', '', '["/images/products/adidas_gazelle_blue.jpg","/images/products/nike_af1_pink.jpg"]', 1, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_adi_campus', 'Adidas Campus 00s', 'adidas-campus-00s', '3r36h794lepj14c', 's0k0a0t0e0b0o0a', 3600, 'สนีกเกอร์สเก็ตบอร์ดยุค 2000s ลิ้นรองเท้าหนานุ่ม เชือกเส้นใหญ่ไซซ์จัมโบ้ ตัวรองเท้าหนังกลับพรีเมียม สไตล์ Y2K ตัวจริง', '', '["/images/products/puma_suede_black.jpg","/images/products/nb574_grey.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_adi_stansmith', 'Adidas Stan Smith', 'adidas-stan-smith', '3r36h794lepj14c', '8zt2nejef08k1l7', 3200, 'ดีไซน์มินิมอลเหนือกาลเวลา หนังสีขาวเรียบคลีน เจาะรูระบายอากาศรูปแถบ 3 แถบ พร้อมส้นสีเขียวคลาสสิก', '', '["/images/products/adidas_samba_white.jpg","/images/products/adidas_samba_white.jpg"]', 0, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_adi_superstar', 'Adidas Superstar', 'adidas-superstar', '3r36h794lepj14c', 't0e0r0r0a0c0e0s', 3600, 'หัวรองเท้ารูปเปลือกหอย Shell Toe ระดับประวัติศาสตร์ สตรีทไอคอนที่ครองใจดนตรีฮิปฮอปและแฟชั่นมากว่า 50 ปี', '', '["/images/products/adidas_samba_white.jpg","/images/products/nike_af1_black.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_adi_spezial', 'Adidas Handball Spezial', 'adidas-handball-spezial', '3r36h794lepj14c', 't0e0r0r0a0c0e0s', 4000, 'รองเท้าแฮนด์บอลยุค 1979 ปรับโฉมเป็นแฟชั่นไอคอน หนังกลับเกรดนุ่มพิเศษ พื้นยาง Gum Sole ยึดเกาะหนึบแน่น', '', '["/images/products/adidas_gazelle_blue.jpg","/images/products/adidas_samba_white.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('2wf6542jhxbpzw0', 'New Balance 530', 'new-balance-530', 'nam1949uo910hfl', 'p0m0n0s0t0u0v0w', 4200, 'รองเท้าวิ่งสไตล์ Dad Shoes ยุค 90s ตาข่ายโปร่งระบายอากาศดีเยี่ยม พื้นเทคโนโลยี ABZORB ซับแรงกระแทกนุ่มสบาย', '', '["/images/products/nb530_silver.jpg","/images/products/nb530_silver.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('nb574coregrey01', 'New Balance 574 Core', 'new-balance-574-core', 'nam1949uo910hfl', '8zt2nejef08k1l7', 3500, 'โมเดลซิกเนเจอร์ที่ขายดีที่สุดของ New Balance หนังกลับแท้ผสมตาข่าย พื้น ENCAP ทนทาน ซัพพอร์ตส้นเท้าได้ดีเยี่ยม', '', '["/images/products/nb574_grey.jpg","/images/products/nb574_grey.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nb_550', 'New Balance 550', 'new-balance-550', 'nam1949uo910hfl', 'b0a0s0k0e0t0b0l', 4600, 'การคืนชีพของรองเท้าบาสเก็ตบอลยุค 1989 หนังพรีเมียมมีรูระบายอากาศ ดีไซน์เรโทรเรียบหรู แมตช์กับกางเกงได้ทุกทรง', '', '["/images/products/nike_af1_white.jpg","/images/products/nike_af1_white.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nb_2002r', 'New Balance 2002R', 'new-balance-2002r', 'nam1949uo910hfl', 'p0m0n0s0t0u0v0w', 5800, 'โมเดลสุดไฮป์แห่งยุค ดีไซน์ตัดเย็บหลายเลเยอร์ พื้นเทคโนโลยี N-ergy และ Stability Web เพื่อความนุ่มและมั่นคงสูงสุด', '', '["/images/products/nb574_grey.jpg","/images/products/nike_af1_black.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nb_1906r', 'New Balance 1906R', 'new-balance-1906r', 'nam1949uo910hfl', 'p0m0n0s0t0u0v0w', 6000, 'สนีกเกอร์สไตล์เทคแวร์ล้ำสมัย โครงสร้าง N-lock เสริมความกระชับ พื้น N-ergy เต็มผืน สวมใส่เดินได้ทั้งวันไม่เมื่อยเท้า', '', '["/images/products/nb530_silver.jpg","/images/products/nb574_grey.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_nb_9060', 'New Balance 9060', 'new-balance-9060', 'nam1949uo910hfl', '8zt2nejef08k1l7', 6500, 'ดีไซน์แห่งอนาคตที่ผสานความคลาสสิกของซีรีส์ 99X พื้นรองเท้าทรง Chunky ล้ำยุค นุ่มเบาสบายทุกก้าว', '', '["/images/products/nb530_silver.jpg","/images/products/nb574_grey.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('vi3bo1003u2b1fx', 'Converse Chuck 70 High', 'converse-chuck-70-high', '39tzml547t349j0', '8zt2nejef08k1l7', 3300, 'โมเดลระดับตำนานที่ปรับปรุงด้วยผ้าใบ Canvas 12oz หนาทนทาน แผ่นรองเท้า OrthoLite หนานุ่ม พร้อมป้ายส้นดำวินเทจ', '', '["/images/products/converse_chuck_black.jpg","/images/products/converse_chuck_black.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_conv_low', 'Converse Chuck Taylor All Star Low', 'converse-chuck-taylor-low', '39tzml547t349j0', '8zt2nejef08k1l7', 2300, 'รองเท้าผ้าใบข้อสั้นสุดคลาสสิก น้ำหนักเบา สวมใส่ง่าย เข้ากับทุกไลฟ์สไตล์ได้ทุกวัน', '', '["/images/products/converse_chuck_black.jpg","/images/products/converse_chuck_black.jpg"]', 0, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_conv_runstar', 'Converse Run Star Hike', 'converse-run-star-hike', '39tzml547t349j0', '8zt2nejef08k1l7', 4000, 'การปรับโฉม Chuck Taylor ด้วยพื้นยางฟันปลาทูโทนทรง Chunky Platform เพิ่มความสูง เสริมบุคลิกให้โดดเด่น', '', '["/images/products/converse_chuck_black.jpg","/images/products/converse_chuck_black.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('vansoldskool001', 'Vans Old Skool Classic', 'vans-old-skool-classic', 'nam1949uo910hvx', 's0k0a0t0e0b0o0a', 2900, 'รองเท้าสเก็ตบอร์ดรุ่นแรกที่มาพร้อมแถบ Jazz Stripe ด้านข้าง ผสมผสานหนังกลับและผ้าใบ แข็งแรงทนทาน พร้อมพื้น Waffle Outsole', '', '["/images/products/vans_old_skool.jpg","/images/products/vans_old_skool.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_vans_sk8hi', 'Vans Sk8-Hi', 'vans-sk8-hi', 'nam1949uo910hvx', 's0k0a0t0e0b0o0a', 3300, 'รองเท้าสเก็ตบอร์ดหุ้มข้อระดับตำนาน ออกแบบบุข้อเท้าหนานุ่มเพื่อป้องกันแรงกระแทก สไตล์สตรีทพังก์คลาสสิก', '', '["/images/products/vans_old_skool.jpg","/images/products/vans_old_skool.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_vans_authentic', 'Vans Authentic', 'vans-authentic', 'nam1949uo910hvx', 's0k0a0t0e0b0o0a', 2400, 'โมเดลดั้งเดิมปี 1966 ของ Vans ดีไซน์มินิมอลผูกเชือกเรียบง่าย ผ้าใบ Cotton แข็งแรง พร้อมพื้นยางวาฟเฟิลในตำนาน', '', '["/images/products/vans_old_skool.jpg","/images/products/vans_old_skool.jpg"]', 0, 0, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('pumasuedeclsx01', 'Puma Suede Classic XXI', 'puma-suede-classic-xxi', 'brandpuma000001', 't0e0r0r0a0c0e0s', 3200, 'หนึ่งในสนีกเกอร์ทรงอิทธิพลที่สุดในประวัติศาสตร์สตรีทและบีบอย หนังกลับ Full Suede แท้ทั้งชิ้น แถบ Formstrip สีขาวตัดคมชัด', '', '["/images/products/puma_suede_black.jpg","/images/products/puma_suede_black.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_puma_palermo', 'Puma Palermo Special', 'puma-palermo-special', 'brandpuma000001', 't0e0r0r0a0c0e0s', 3600, 'โมเดลเรโทรฟุตบอลอิตาลียุค 80s ป้ายทอสีทอง Palermo บริเวณด้านข้าง หนังกลับผสมไนลอน พื้น Gum Sole ย้อนยุคสวยสะดุดตา', '', '["/images/products/puma_suede_black.jpg","/images/products/puma_suede_black.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('asicsgelkayan01', 'Asics Gel-Kayano 14', 'asics-gel-kayano-14', 'brandasics00001', 'p0m0n0s0t0u0v0w', 5500, 'รองเท้าวิ่งเรโทรยุคปลาย 2000s ที่กลายเป็นไอคอนของวงการแฟชั่นระดับโลก เทคโนโลยี GEL ซับแรงกระแทกทั้งปลายและส้นเท้า', '', '["/images/products/asics_gel_kayano.jpg","/images/products/asics_gel_kayano.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_asics_1130', 'Asics Gel-1130', 'asics-gel-1130', 'brandasics00001', 'p0m0n0s0t0u0v0w', 3900, 'โมเดลวิ่งยุค 2008 ดีไซน์ Mesh แบบเปิดโปร่ง โครงสร้างรองรับเท้า TRUSSTIC System สวมใส่เบาสบาย ระบายอากาศยอดเยี่ยม', '', '["/images/products/asics_gel_kayano.jpg","/images/products/asics_gel_kayano.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_tiger_mex66', 'Onitsuka Tiger Mexico 66', 'onitsuka-tiger-mexico-66', 'brandtiger00001', 't0e0r0r0a0c0e0s', 4900, 'โมเดลประวัติศาสตร์เปิดตัวครั้งแรกในกีฬาโอลิมปิก 1968 หนังแท้นุ่มบางกระชับรูปเท้า ลายพาดแถบเสือสีน้ำเงินและแดงสุดคลาสสิก', '', '["/images/products/adidas_samba_white.jpg","/images/products/puma_suede_black.jpg"]', 0, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

INSERT INTO public.products (id, name, slug, brand, category, base_price, description, main_image, additional_images, is_new, is_bestseller, status, created_at, updated_at)
VALUES ('prod_salomon_xt6', 'Salomon XT-6', 'salomon-xt-6', 'brandsalomon001', 'p0m0n0s0t0u0v0w', 7200, 'ไอคอนแห่งแฟชั่นสไตล์ Gorpcore รองเท้าเทรลที่ผสานเทคโนโลยี Sensifit, Quicklace และพื้น Contagrip เกาะพื้นทุกลักษณะ', '', '["/images/products/nike_af1_black.jpg","/images/products/nike_af1_white.jpg"]', 1, 1, 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, base_price = EXCLUDED.base_price, status = EXCLUDED.status, description = EXCLUDED.description;

-- 4. PRODUCT VARIANTS
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenkq', 'prod_nike_af1', 'NIKE-TRI-36', 'Triple White', '#FFFFFF', '36', 2200, 3700, 3330, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenkp', 'prod_nike_af1', 'NIKE-TRI-37', 'Triple White', '#FFFFFF', '37', 2200, 3700, 3330, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenko', 'prod_nike_af1', 'NIKE-TRI-38', 'Triple White', '#FFFFFF', '38', 2200, 3700, 3330, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenkn', 'prod_nike_af1', 'NIKE-TRI-39', 'Triple White', '#FFFFFF', '39', 2200, 3700, 3330, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenk1', 'prod_nike_af1', 'NIKE-TRI-40', 'Triple White', '#FFFFFF', '40', 2200, 3700, 3330, 15, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenk0', 'prod_nike_af1', 'NIKE-TRI-41', 'Triple White', '#FFFFFF', '41', 2200, 3700, 3330, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenjz', 'prod_nike_af1', 'NIKE-TRI-42', 'Triple White', '#FFFFFF', '42', 2200, 3700, 3330, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenjy', 'prod_nike_af1', 'NIKE-TRI-43', 'Triple White', '#FFFFFF', '43', 2200, 3700, 3330, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenjx', 'prod_nike_af1', 'NIKE-TRI-44', 'Triple White', '#FFFFFF', '44', 2200, 3700, 3330, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0kmenjw', 'prod_nike_af1', 'NIKE-TRI-45', 'Triple White', '#FFFFFF', '45', 2200, 3700, 3330, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmohc', 'prod_nike_af1', 'NIKE-TRI-36', 'Triple Black', '#111111', '36', 2200, 3700, 3330, 17, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmohb', 'prod_nike_af1', 'NIKE-TRI-37', 'Triple Black', '#111111', '37', 2200, 3700, 3330, 16, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmoha', 'prod_nike_af1', 'NIKE-TRI-38', 'Triple Black', '#111111', '38', 2200, 3700, 3330, 15, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmoh9', 'prod_nike_af1', 'NIKE-TRI-39', 'Triple Black', '#111111', '39', 2200, 3700, 3330, 14, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogn', 'prod_nike_af1', 'NIKE-TRI-40', 'Triple Black', '#111111', '40', 2200, 3700, 3330, 7, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogm', 'prod_nike_af1', 'NIKE-TRI-41', 'Triple Black', '#111111', '41', 2200, 3700, 3330, 6, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogl', 'prod_nike_af1', 'NIKE-TRI-42', 'Triple Black', '#111111', '42', 2200, 3700, 3330, 5, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogk', 'prod_nike_af1', 'NIKE-TRI-43', 'Triple Black', '#111111', '43', 2200, 3700, 3330, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogj', 'prod_nike_af1', 'NIKE-TRI-44', 'Triple Black', '#111111', '44', 2200, 3700, 3330, 18, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike02zmogi', 'prod_nike_af1', 'NIKE-TRI-45', 'Triple Black', '#111111', '45', 2200, 3700, 3330, 0, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa0o', 'prod_nike_af1', 'NIKE-PIN-36', 'Pink Foam', '#F8BBD0', '36', 2200, 3700, 3330, 17, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa0p', 'prod_nike_af1', 'NIKE-PIN-37', 'Pink Foam', '#F8BBD0', '37', 2200, 3700, 3330, 18, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa0q', 'prod_nike_af1', 'NIKE-PIN-38', 'Pink Foam', '#F8BBD0', '38', 2200, 3700, 3330, 19, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa0r', 'prod_nike_af1', 'NIKE-PIN-39', 'Pink Foam', '#F8BBD0', '39', 2200, 3700, 3330, 5, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1d', 'prod_nike_af1', 'NIKE-PIN-40', 'Pink Foam', '#F8BBD0', '40', 2200, 3700, 3330, 12, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1e', 'prod_nike_af1', 'NIKE-PIN-41', 'Pink Foam', '#F8BBD0', '41', 2200, 3700, 3330, 13, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1f', 'prod_nike_af1', 'NIKE-PIN-42', 'Pink Foam', '#F8BBD0', '42', 2200, 3700, 3330, 14, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1g', 'prod_nike_af1', 'NIKE-PIN-43', 'Pink Foam', '#F8BBD0', '43', 2200, 3700, 3330, 15, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1h', 'prod_nike_af1', 'NIKE-PIN-44', 'Pink Foam', '#F8BBD0', '44', 2200, 3700, 3330, 16, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0otpa1i', 'prod_nike_af1', 'NIKE-PIN-45', 'Pink Foam', '#F8BBD0', '45', 2200, 3700, 3330, 17, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8aw', 'ndunklowretro01', 'NIKE-PAN-36', 'Panda (Black/White)', '#111111', '36', 2600, 4300, 3870, 10, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8ax', 'ndunklowretro01', 'NIKE-PAN-37', 'Panda (Black/White)', '#111111', '37', 2600, 4300, 3870, 11, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8ay', 'ndunklowretro01', 'NIKE-PAN-38', 'Panda (Black/White)', '#111111', '38', 2600, 4300, 3870, 12, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8az', 'ndunklowretro01', 'NIKE-PAN-39', 'Panda (Black/White)', '#111111', '39', 2600, 4300, 3870, 13, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bl', 'ndunklowretro01', 'NIKE-PAN-40', 'Panda (Black/White)', '#111111', '40', 2600, 4300, 3870, 5, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bm', 'ndunklowretro01', 'NIKE-PAN-41', 'Panda (Black/White)', '#111111', '41', 2600, 4300, 3870, 6, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bn', 'ndunklowretro01', 'NIKE-PAN-42', 'Panda (Black/White)', '#111111', '42', 2600, 4300, 3870, 7, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bo', 'ndunklowretro01', 'NIKE-PAN-43', 'Panda (Black/White)', '#111111', '43', 2600, 4300, 3870, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bp', 'ndunklowretro01', 'NIKE-PAN-44', 'Panda (Black/White)', '#111111', '44', 2600, 4300, 3870, 9, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0jqu8bq', 'ndunklowretro01', 'NIKE-PAN-45', 'Panda (Black/White)', '#111111', '45', 2600, 4300, 3870, 0, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosr7', 'ndunklowretro01', 'NIKE-GRE-36', 'Grey Fog', '#9E9E9E', '36', 2600, 4300, 3870, 6, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosr6', 'ndunklowretro01', 'NIKE-GRE-37', 'Grey Fog', '#9E9E9E', '37', 2600, 4300, 3870, 5, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosr5', 'ndunklowretro01', 'NIKE-GRE-38', 'Grey Fog', '#9E9E9E', '38', 2600, 4300, 3870, 19, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosr4', 'ndunklowretro01', 'NIKE-GRE-39', 'Grey Fog', '#9E9E9E', '39', 2600, 4300, 3870, 18, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqi', 'ndunklowretro01', 'NIKE-GRE-40', 'Grey Fog', '#9E9E9E', '40', 2600, 4300, 3870, 11, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqh', 'ndunklowretro01', 'NIKE-GRE-41', 'Grey Fog', '#9E9E9E', '41', 2600, 4300, 3870, 10, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqg', 'ndunklowretro01', 'NIKE-GRE-42', 'Grey Fog', '#9E9E9E', '42', 2600, 4300, 3870, 9, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqf', 'ndunklowretro01', 'NIKE-GRE-43', 'Grey Fog', '#9E9E9E', '43', 2600, 4300, 3870, 8, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqe', 'ndunklowretro01', 'NIKE-GRE-44', 'Grey Fog', '#9E9E9E', '44', 2600, 4300, 3870, 7, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('ndunklow0mnosqd', 'ndunklowretro01', 'NIKE-GRE-45', 'Grey Fog', '#9E9E9E', '45', 2600, 4300, 3870, 6, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017vipl', 'prod_nike_am1', 'NIKE-SPO-36', 'Sport Red', '#D32F2F', '36', 3200, 5400, 4860, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017vipm', 'prod_nike_am1', 'NIKE-SPO-37', 'Sport Red', '#D32F2F', '37', 3200, 5400, 4860, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017vipn', 'prod_nike_am1', 'NIKE-SPO-38', 'Sport Red', '#D32F2F', '38', 3200, 5400, 4860, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017vipo', 'prod_nike_am1', 'NIKE-SPO-39', 'Sport Red', '#D32F2F', '39', 3200, 5400, 4860, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqa', 'prod_nike_am1', 'NIKE-SPO-40', 'Sport Red', '#D32F2F', '40', 3200, 5400, 4860, 18, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqb', 'prod_nike_am1', 'NIKE-SPO-41', 'Sport Red', '#D32F2F', '41', 3200, 5400, 4860, 19, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqc', 'prod_nike_am1', 'NIKE-SPO-42', 'Sport Red', '#D32F2F', '42', 3200, 5400, 4860, 5, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqd', 'prod_nike_am1', 'NIKE-SPO-43', 'Sport Red', '#D32F2F', '43', 3200, 5400, 4860, 6, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqe', 'prod_nike_am1', 'NIKE-SPO-44', 'Sport Red', '#D32F2F', '44', 3200, 5400, 4860, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike017viqf', 'prod_nike_am1', 'NIKE-SPO-45', 'Sport Red', '#D32F2F', '45', 3200, 5400, 4860, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmsjn', 'prod_nike_am1', 'NIKE-OBS-36', 'Obsidian Navy', '#1A237E', '36', 3200, 5400, 4860, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmsjo', 'prod_nike_am1', 'NIKE-OBS-37', 'Obsidian Navy', '#1A237E', '37', 3200, 5400, 4860, 5, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmsjp', 'prod_nike_am1', 'NIKE-OBS-38', 'Obsidian Navy', '#1A237E', '38', 3200, 5400, 4860, 6, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmsjq', 'prod_nike_am1', 'NIKE-OBS-39', 'Obsidian Navy', '#1A237E', '39', 3200, 5400, 4860, 7, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmskc', 'prod_nike_am1', 'NIKE-OBS-40', 'Obsidian Navy', '#1A237E', '40', 3200, 5400, 4860, 14, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmskd', 'prod_nike_am1', 'NIKE-OBS-41', 'Obsidian Navy', '#1A237E', '41', 3200, 5400, 4860, 15, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmske', 'prod_nike_am1', 'NIKE-OBS-42', 'Obsidian Navy', '#1A237E', '42', 3200, 5400, 4860, 16, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmskf', 'prod_nike_am1', 'NIKE-OBS-43', 'Obsidian Navy', '#1A237E', '43', 3200, 5400, 4860, 17, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmskg', 'prod_nike_am1', 'NIKE-OBS-44', 'Obsidian Navy', '#1A237E', '44', 3200, 5400, 4860, 18, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0tnmskh', 'prod_nike_am1', 'NIKE-OBS-45', 'Obsidian Navy', '#1A237E', '45', 3200, 5400, 4860, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m2115', 'prod_nike_am90', 'NIKE-INF-36', 'Infrared', '#FF1744', '36', 2800, 4700, 0, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m2114', 'prod_nike_am90', 'NIKE-INF-37', 'Infrared', '#FF1744', '37', 2800, 4700, 0, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m2113', 'prod_nike_am90', 'NIKE-INF-38', 'Infrared', '#FF1744', '38', 2800, 4700, 0, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m2112', 'prod_nike_am90', 'NIKE-INF-39', 'Infrared', '#FF1744', '39', 2800, 4700, 0, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210g', 'prod_nike_am90', 'NIKE-INF-40', 'Infrared', '#FF1744', '40', 2800, 4700, 0, 18, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210f', 'prod_nike_am90', 'NIKE-INF-41', 'Infrared', '#FF1744', '41', 2800, 4700, 0, 17, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210e', 'prod_nike_am90', 'NIKE-INF-42', 'Infrared', '#FF1744', '42', 2800, 4700, 0, 16, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210d', 'prod_nike_am90', 'NIKE-INF-43', 'Infrared', '#FF1744', '43', 2800, 4700, 0, 15, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210c', 'prod_nike_am90', 'NIKE-INF-44', 'Infrared', '#FF1744', '44', 2800, 4700, 0, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike07m210b', 'prod_nike_am90', 'NIKE-INF-45', 'Infrared', '#FF1744', '45', 2800, 4700, 0, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwozj', 'prod_nike_am90', 'NIKE-TRI-36', 'Triple White', '#FFFFFF', '36', 2800, 4700, 0, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwozi', 'prod_nike_am90', 'NIKE-TRI-37', 'Triple White', '#FFFFFF', '37', 2800, 4700, 0, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwozh', 'prod_nike_am90', 'NIKE-TRI-38', 'Triple White', '#FFFFFF', '38', 2800, 4700, 0, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwozg', 'prod_nike_am90', 'NIKE-TRI-39', 'Triple White', '#FFFFFF', '39', 2800, 4700, 0, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoyu', 'prod_nike_am90', 'NIKE-TRI-40', 'Triple White', '#FFFFFF', '40', 2800, 4700, 0, 17, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoyt', 'prod_nike_am90', 'NIKE-TRI-41', 'Triple White', '#FFFFFF', '41', 2800, 4700, 0, 16, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoys', 'prod_nike_am90', 'NIKE-TRI-42', 'Triple White', '#FFFFFF', '42', 2800, 4700, 0, 15, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoyr', 'prod_nike_am90', 'NIKE-TRI-43', 'Triple White', '#FFFFFF', '43', 2800, 4700, 0, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoyq', 'prod_nike_am90', 'NIKE-TRI-44', 'Triple White', '#FFFFFF', '44', 2800, 4700, 0, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0wfwoyp', 'prod_nike_am90', 'NIKE-TRI-45', 'Triple White', '#FFFFFF', '45', 2800, 4700, 0, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2on4', 'prod_nike_am97', 'NIKE-SIL-36', 'Silver Bullet', '#C0C0C0', '36', 3800, 6200, 5580, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2on5', 'prod_nike_am97', 'NIKE-SIL-37', 'Silver Bullet', '#C0C0C0', '37', 3800, 6200, 5580, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2on6', 'prod_nike_am97', 'NIKE-SIL-38', 'Silver Bullet', '#C0C0C0', '38', 3800, 6200, 5580, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2on7', 'prod_nike_am97', 'NIKE-SIL-39', 'Silver Bullet', '#C0C0C0', '39', 3800, 6200, 5580, 9, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2ont', 'prod_nike_am97', 'NIKE-SIL-40', 'Silver Bullet', '#C0C0C0', '40', 3800, 6200, 5580, 16, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2onu', 'prod_nike_am97', 'NIKE-SIL-41', 'Silver Bullet', '#C0C0C0', '41', 3800, 6200, 5580, 17, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2onv', 'prod_nike_am97', 'NIKE-SIL-42', 'Silver Bullet', '#C0C0C0', '42', 3800, 6200, 5580, 18, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2onw', 'prod_nike_am97', 'NIKE-SIL-43', 'Silver Bullet', '#C0C0C0', '43', 3800, 6200, 5580, 19, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2onx', 'prod_nike_am97', 'NIKE-SIL-44', 'Silver Bullet', '#C0C0C0', '44', 3800, 6200, 5580, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0vh2ony', 'prod_nike_am97', 'NIKE-SIL-45', 'Silver Bullet', '#C0C0C0', '45', 3800, 6200, 5580, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8gi4', 'prod_nike_am97', 'NIKE-MET-36', 'Metallic Gold', '#FFD700', '36', 3800, 6200, 5580, 15, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8gi3', 'prod_nike_am97', 'NIKE-MET-37', 'Metallic Gold', '#FFD700', '37', 3800, 6200, 5580, 14, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8gi2', 'prod_nike_am97', 'NIKE-MET-38', 'Metallic Gold', '#FFD700', '38', 3800, 6200, 5580, 13, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8gi1', 'prod_nike_am97', 'NIKE-MET-39', 'Metallic Gold', '#FFD700', '39', 3800, 6200, 5580, 12, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8ghf', 'prod_nike_am97', 'NIKE-MET-40', 'Metallic Gold', '#FFD700', '40', 3800, 6200, 5580, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8ghe', 'prod_nike_am97', 'NIKE-MET-41', 'Metallic Gold', '#FFD700', '41', 3800, 6200, 5580, 19, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8ghd', 'prod_nike_am97', 'NIKE-MET-42', 'Metallic Gold', '#FFD700', '42', 3800, 6200, 5580, 18, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8ghc', 'prod_nike_am97', 'NIKE-MET-43', 'Metallic Gold', '#FFD700', '43', 3800, 6200, 5580, 17, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8ghb', 'prod_nike_am97', 'NIKE-MET-44', 'Metallic Gold', '#FFD700', '44', 3800, 6200, 5580, 16, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnike0qs8gha', 'prod_nike_am97', 'NIKE-MET-45', 'Metallic Gold', '#FFD700', '45', 3800, 6200, 5580, 15, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21oni', '1z0000jxdn85et7', 'AIRJ-ROS-36', 'Rose Gold / White', '#E0A899', '36', 2700, 4500, 4050, 17, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21onj', '1z0000jxdn85et7', 'AIRJ-ROS-37', 'Rose Gold / White', '#E0A899', '37', 2700, 4500, 4050, 18, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21onk', '1z0000jxdn85et7', 'AIRJ-ROS-38', 'Rose Gold / White', '#E0A899', '38', 2700, 4500, 4050, 19, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21onl', '1z0000jxdn85et7', 'AIRJ-ROS-39', 'Rose Gold / White', '#E0A899', '39', 2700, 4500, 4050, 5, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21oo7', '1z0000jxdn85et7', 'AIRJ-ROS-40', 'Rose Gold / White', '#E0A899', '40', 2700, 4500, 4050, 12, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21oo8', '1z0000jxdn85et7', 'AIRJ-ROS-41', 'Rose Gold / White', '#E0A899', '41', 2700, 4500, 4050, 13, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21oo9', '1z0000jxdn85et7', 'AIRJ-ROS-42', 'Rose Gold / White', '#E0A899', '42', 2700, 4500, 4050, 14, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21ooa', '1z0000jxdn85et7', 'AIRJ-ROS-43', 'Rose Gold / White', '#E0A899', '43', 2700, 4500, 4050, 15, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21oob', '1z0000jxdn85et7', 'AIRJ-ROS-44', 'Rose Gold / White', '#E0A899', '44', 2700, 4500, 4050, 16, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx0e21ooc', '1z0000jxdn85et7', 'AIRJ-ROS-45', 'Rose Gold / White', '#E0A899', '45', 2700, 4500, 4050, 17, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uvm', '1z0000jxdn85et7', 'AIRJ-BLA-36', 'Black Toe', '#D32F2F', '36', 2700, 4500, 4050, 6, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uvl', '1z0000jxdn85et7', 'AIRJ-BLA-37', 'Black Toe', '#D32F2F', '37', 2700, 4500, 4050, 5, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uvk', '1z0000jxdn85et7', 'AIRJ-BLA-38', 'Black Toe', '#D32F2F', '38', 2700, 4500, 4050, 19, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uvj', '1z0000jxdn85et7', 'AIRJ-BLA-39', 'Black Toe', '#D32F2F', '39', 2700, 4500, 4050, 18, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uux', '1z0000jxdn85et7', 'AIRJ-BLA-40', 'Black Toe', '#D32F2F', '40', 2700, 4500, 4050, 11, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uuw', '1z0000jxdn85et7', 'AIRJ-BLA-41', 'Black Toe', '#D32F2F', '41', 2700, 4500, 4050, 10, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uuv', '1z0000jxdn85et7', 'AIRJ-BLA-42', 'Black Toe', '#D32F2F', '42', 2700, 4500, 4050, 9, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uuu', '1z0000jxdn85et7', 'AIRJ-BLA-43', 'Black Toe', '#D32F2F', '43', 2700, 4500, 4050, 8, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uut', '1z0000jxdn85et7', 'AIRJ-BLA-44', 'Black Toe', '#D32F2F', '44', 2700, 4500, 4050, 7, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('1z0000jx05k3uus', '1z0000jxdn85et7', 'AIRJ-BLA-45', 'Black Toe', '#D32F2F', '45', 2700, 4500, 4050, 0, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oib', 'prod_aj1_mid', 'AIRJ-BRE-36', 'Bred Toe', '#C62828', '36', 3000, 4900, 4410, 10, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oic', 'prod_aj1_mid', 'AIRJ-BRE-37', 'Bred Toe', '#C62828', '37', 3000, 4900, 4410, 11, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oid', 'prod_aj1_mid', 'AIRJ-BRE-38', 'Bred Toe', '#C62828', '38', 3000, 4900, 4410, 12, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oie', 'prod_aj1_mid', 'AIRJ-BRE-39', 'Bred Toe', '#C62828', '39', 3000, 4900, 4410, 13, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj0', 'prod_aj1_mid', 'AIRJ-BRE-40', 'Bred Toe', '#C62828', '40', 3000, 4900, 4410, 5, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj1', 'prod_aj1_mid', 'AIRJ-BRE-41', 'Bred Toe', '#C62828', '41', 3000, 4900, 4410, 6, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj2', 'prod_aj1_mid', 'AIRJ-BRE-42', 'Bred Toe', '#C62828', '42', 3000, 4900, 4410, 7, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj3', 'prod_aj1_mid', 'AIRJ-BRE-43', 'Bred Toe', '#C62828', '43', 3000, 4900, 4410, 8, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj4', 'prod_aj1_mid', 'AIRJ-BRE-44', 'Bred Toe', '#C62828', '44', 3000, 4900, 4410, 9, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0ni1oj5', 'prod_aj1_mid', 'AIRJ-BRE-45', 'Bred Toe', '#C62828', '45', 3000, 4900, 4410, 10, '/images/products/jordan1_rose_gold.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd4010', 'prod_aj1_mid', 'AIRJ-SMO-36', 'Smoke Grey', '#757575', '36', 3000, 4900, 4410, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd400z', 'prod_aj1_mid', 'AIRJ-SMO-37', 'Smoke Grey', '#757575', '37', 3000, 4900, 4410, 19, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd400y', 'prod_aj1_mid', 'AIRJ-SMO-38', 'Smoke Grey', '#757575', '38', 3000, 4900, 4410, 18, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd400x', 'prod_aj1_mid', 'AIRJ-SMO-39', 'Smoke Grey', '#757575', '39', 3000, 4900, 4410, 17, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd400b', 'prod_aj1_mid', 'AIRJ-SMO-40', 'Smoke Grey', '#757575', '40', 3000, 4900, 4410, 10, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd400a', 'prod_aj1_mid', 'AIRJ-SMO-41', 'Smoke Grey', '#757575', '41', 3000, 4900, 4410, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd4009', 'prod_aj1_mid', 'AIRJ-SMO-42', 'Smoke Grey', '#757575', '42', 3000, 4900, 4410, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd4008', 'prod_aj1_mid', 'AIRJ-SMO-43', 'Smoke Grey', '#757575', '43', 3000, 4900, 4410, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd4007', 'prod_aj1_mid', 'AIRJ-SMO-44', 'Smoke Grey', '#757575', '44', 3000, 4900, 4410, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj1m0cd4006', 'prod_aj1_mid', 'AIRJ-SMO-45', 'Smoke Grey', '#757575', '45', 3000, 4900, 4410, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu7t', 'prod_aj4_retro', 'AIRJ-MIL-36', 'Military Black', '#212121', '36', 4800, 7900, 7110, 16, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu7u', 'prod_aj4_retro', 'AIRJ-MIL-37', 'Military Black', '#212121', '37', 4800, 7900, 7110, 17, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu7v', 'prod_aj4_retro', 'AIRJ-MIL-38', 'Military Black', '#212121', '38', 4800, 7900, 7110, 18, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu7w', 'prod_aj4_retro', 'AIRJ-MIL-39', 'Military Black', '#212121', '39', 4800, 7900, 7110, 19, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8i', 'prod_aj4_retro', 'AIRJ-MIL-40', 'Military Black', '#212121', '40', 4800, 7900, 7110, 11, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8j', 'prod_aj4_retro', 'AIRJ-MIL-41', 'Military Black', '#212121', '41', 4800, 7900, 7110, 12, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8k', 'prod_aj4_retro', 'AIRJ-MIL-42', 'Military Black', '#212121', '42', 4800, 7900, 7110, 13, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8l', 'prod_aj4_retro', 'AIRJ-MIL-43', 'Military Black', '#212121', '43', 4800, 7900, 7110, 14, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8m', 'prod_aj4_retro', 'AIRJ-MIL-44', 'Military Black', '#212121', '44', 4800, 7900, 7110, 15, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r01hcu8n', 'prod_aj4_retro', 'AIRJ-MIL-45', 'Military Black', '#212121', '45', 4800, 7900, 7110, 0, '/images/products/dunk_low_panda.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad042', 'prod_aj4_retro', 'AIRJ-WHI-36', 'White Cement', '#E0E0E0', '36', 4800, 7900, 7110, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad041', 'prod_aj4_retro', 'AIRJ-WHI-37', 'White Cement', '#E0E0E0', '37', 4800, 7900, 7110, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad040', 'prod_aj4_retro', 'AIRJ-WHI-38', 'White Cement', '#E0E0E0', '38', 4800, 7900, 7110, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad03z', 'prod_aj4_retro', 'AIRJ-WHI-39', 'White Cement', '#E0E0E0', '39', 4800, 7900, 7110, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad03d', 'prod_aj4_retro', 'AIRJ-WHI-40', 'White Cement', '#E0E0E0', '40', 4800, 7900, 7110, 15, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad03c', 'prod_aj4_retro', 'AIRJ-WHI-41', 'White Cement', '#E0E0E0', '41', 4800, 7900, 7110, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad03b', 'prod_aj4_retro', 'AIRJ-WHI-42', 'White Cement', '#E0E0E0', '42', 4800, 7900, 7110, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad03a', 'prod_aj4_retro', 'AIRJ-WHI-43', 'White Cement', '#E0E0E0', '43', 4800, 7900, 7110, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad039', 'prod_aj4_retro', 'AIRJ-WHI-44', 'White Cement', '#E0E0E0', '44', 4800, 7900, 7110, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodaj4r06ad038', 'prod_aj4_retro', 'AIRJ-WHI-45', 'White Cement', '#E0E0E0', '45', 4800, 7900, 7110, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847gn', '80615384541l1aa', 'ADID-CLO-36', 'Cloud White', '#F5F5F5', '36', 2300, 3800, 3420, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847gm', '80615384541l1aa', 'ADID-CLO-37', 'Cloud White', '#F5F5F5', '37', 2300, 3800, 3420, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847gl', '80615384541l1aa', 'ADID-CLO-38', 'Cloud White', '#F5F5F5', '38', 2300, 3800, 3420, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847gk', '80615384541l1aa', 'ADID-CLO-39', 'Cloud White', '#F5F5F5', '39', 2300, 3800, 3420, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847fy', '80615384541l1aa', 'ADID-CLO-40', 'Cloud White', '#F5F5F5', '40', 2300, 3800, 3420, 15, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847fx', '80615384541l1aa', 'ADID-CLO-41', 'Cloud White', '#F5F5F5', '41', 2300, 3800, 3420, 14, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847fw', '80615384541l1aa', 'ADID-CLO-42', 'Cloud White', '#F5F5F5', '42', 2300, 3800, 3420, 13, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847fv', '80615384541l1aa', 'ADID-CLO-43', 'Cloud White', '#F5F5F5', '43', 2300, 3800, 3420, 12, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847fu', '80615384541l1aa', 'ADID-CLO-44', 'Cloud White', '#F5F5F5', '44', 2300, 3800, 3420, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840m847ft', '80615384541l1aa', 'ADID-CLO-45', 'Cloud White', '#F5F5F5', '45', 2300, 3800, 3420, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4mn', '80615384541l1aa', 'ADID-COR-36', 'Core Black', '#111111', '36', 2300, 3800, 3420, 10, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4mo', '80615384541l1aa', 'ADID-COR-37', 'Core Black', '#111111', '37', 2300, 3800, 3420, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4mp', '80615384541l1aa', 'ADID-COR-38', 'Core Black', '#111111', '38', 2300, 3800, 3420, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4mq', '80615384541l1aa', 'ADID-COR-39', 'Core Black', '#111111', '39', 2300, 3800, 3420, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4nc', '80615384541l1aa', 'ADID-COR-40', 'Core Black', '#111111', '40', 2300, 3800, 3420, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4nd', '80615384541l1aa', 'ADID-COR-41', 'Core Black', '#111111', '41', 2300, 3800, 3420, 6, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4ne', '80615384541l1aa', 'ADID-COR-42', 'Core Black', '#111111', '42', 2300, 3800, 3420, 7, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4nf', '80615384541l1aa', 'ADID-COR-43', 'Core Black', '#111111', '43', 2300, 3800, 3420, 8, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4ng', '80615384541l1aa', 'ADID-COR-44', 'Core Black', '#111111', '44', 2300, 3800, 3420, 9, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('806153840g9v4nh', '80615384541l1aa', 'ADID-COR-45', 'Core Black', '#111111', '45', 2300, 3800, 3420, 0, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hb7', 'agazelleindoor1', 'ADID-COL-36', 'Collegiate Navy', '#1A237E', '36', 2500, 4200, 0, 15, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hb8', 'agazelleindoor1', 'ADID-COL-37', 'Collegiate Navy', '#1A237E', '37', 2500, 4200, 0, 16, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hb9', 'agazelleindoor1', 'ADID-COL-38', 'Collegiate Navy', '#1A237E', '38', 2500, 4200, 0, 17, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hba', 'agazelleindoor1', 'ADID-COL-39', 'Collegiate Navy', '#1A237E', '39', 2500, 4200, 0, 18, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hbw', 'agazelleindoor1', 'ADID-COL-40', 'Collegiate Navy', '#1A237E', '40', 2500, 4200, 0, 10, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hbx', 'agazelleindoor1', 'ADID-COL-41', 'Collegiate Navy', '#1A237E', '41', 2500, 4200, 0, 11, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hby', 'agazelleindoor1', 'ADID-COL-42', 'Collegiate Navy', '#1A237E', '42', 2500, 4200, 0, 12, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hbz', 'agazelleindoor1', 'ADID-COL-43', 'Collegiate Navy', '#1A237E', '43', 2500, 4200, 0, 13, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hc0', 'agazelleindoor1', 'ADID-COL-44', 'Collegiate Navy', '#1A237E', '44', 2500, 4200, 0, 14, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle0942hc1', 'agazelleindoor1', 'ADID-COL-45', 'Collegiate Navy', '#1A237E', '45', 2500, 4200, 0, 15, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gej', 'agazelleindoor1', 'ADID-BLI-36', 'Bliss Pink', '#F48FB1', '36', 2500, 4200, 0, 15, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gek', 'agazelleindoor1', 'ADID-BLI-37', 'Bliss Pink', '#F48FB1', '37', 2500, 4200, 0, 16, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gel', 'agazelleindoor1', 'ADID-BLI-38', 'Bliss Pink', '#F48FB1', '38', 2500, 4200, 0, 17, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gem', 'agazelleindoor1', 'ADID-BLI-39', 'Bliss Pink', '#F48FB1', '39', 2500, 4200, 0, 18, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gf8', 'agazelleindoor1', 'ADID-BLI-40', 'Bliss Pink', '#F48FB1', '40', 2500, 4200, 0, 10, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gf9', 'agazelleindoor1', 'ADID-BLI-41', 'Bliss Pink', '#F48FB1', '41', 2500, 4200, 0, 11, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gfa', 'agazelleindoor1', 'ADID-BLI-42', 'Bliss Pink', '#F48FB1', '42', 2500, 4200, 0, 12, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gfb', 'agazelleindoor1', 'ADID-BLI-43', 'Bliss Pink', '#F48FB1', '43', 2500, 4200, 0, 13, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gfc', 'agazelleindoor1', 'ADID-BLI-44', 'Bliss Pink', '#F48FB1', '44', 2500, 4200, 0, 14, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('agazelle05s3gfd', 'agazelleindoor1', 'ADID-BLI-45', 'Bliss Pink', '#F48FB1', '45', 2500, 4200, 0, 15, '/images/products/nike_af1_pink.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg1857', 'prod_adi_campus', 'ADID-COR-36', 'Core Black', '#212121', '36', 2100, 3600, 3240, 18, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg1856', 'prod_adi_campus', 'ADID-COR-37', 'Core Black', '#212121', '37', 2100, 3600, 3240, 17, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg1855', 'prod_adi_campus', 'ADID-COR-38', 'Core Black', '#212121', '38', 2100, 3600, 3240, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg1854', 'prod_adi_campus', 'ADID-COR-39', 'Core Black', '#212121', '39', 2100, 3600, 3240, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184i', 'prod_adi_campus', 'ADID-COR-40', 'Core Black', '#212121', '40', 2100, 3600, 3240, 8, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184h', 'prod_adi_campus', 'ADID-COR-41', 'Core Black', '#212121', '41', 2100, 3600, 3240, 7, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184g', 'prod_adi_campus', 'ADID-COR-42', 'Core Black', '#212121', '42', 2100, 3600, 3240, 6, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184f', 'prod_adi_campus', 'ADID-COR-43', 'Core Black', '#212121', '43', 2100, 3600, 3240, 5, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184e', 'prod_adi_campus', 'ADID-COR-44', 'Core Black', '#212121', '44', 2100, 3600, 3240, 19, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0gg184d', 'prod_adi_campus', 'ADID-COR-45', 'Core Black', '#212121', '45', 2100, 3600, 3240, 0, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6pm', 'prod_adi_campus', 'ADID-GRE-36', 'Grey Three', '#9E9E9E', '36', 2100, 3600, 3240, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6pl', 'prod_adi_campus', 'ADID-GRE-37', 'Grey Three', '#9E9E9E', '37', 2100, 3600, 3240, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6pk', 'prod_adi_campus', 'ADID-GRE-38', 'Grey Three', '#9E9E9E', '38', 2100, 3600, 3240, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6pj', 'prod_adi_campus', 'ADID-GRE-39', 'Grey Three', '#9E9E9E', '39', 2100, 3600, 3240, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6ox', 'prod_adi_campus', 'ADID-GRE-40', 'Grey Three', '#9E9E9E', '40', 2100, 3600, 3240, 14, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6ow', 'prod_adi_campus', 'ADID-GRE-41', 'Grey Three', '#9E9E9E', '41', 2100, 3600, 3240, 13, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6ov', 'prod_adi_campus', 'ADID-GRE-42', 'Grey Three', '#9E9E9E', '42', 2100, 3600, 3240, 12, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6ou', 'prod_adi_campus', 'ADID-GRE-43', 'Grey Three', '#9E9E9E', '43', 2100, 3600, 3240, 11, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6ot', 'prod_adi_campus', 'ADID-GRE-44', 'Grey Three', '#9E9E9E', '44', 2100, 3600, 3240, 10, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadic0l9v6os', 'prod_adi_campus', 'ADID-GRE-45', 'Grey Three', '#9E9E9E', '45', 2100, 3600, 3240, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb29', 'prod_adi_stansmith', 'ADID-FAI-36', 'Fairway Green', '#2E7D32', '36', 1900, 3200, 0, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb28', 'prod_adi_stansmith', 'ADID-FAI-37', 'Fairway Green', '#2E7D32', '37', 1900, 3200, 0, 19, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb27', 'prod_adi_stansmith', 'ADID-FAI-38', 'Fairway Green', '#2E7D32', '38', 1900, 3200, 0, 18, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb26', 'prod_adi_stansmith', 'ADID-FAI-39', 'Fairway Green', '#2E7D32', '39', 1900, 3200, 0, 17, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1k', 'prod_adi_stansmith', 'ADID-FAI-40', 'Fairway Green', '#2E7D32', '40', 1900, 3200, 0, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1j', 'prod_adi_stansmith', 'ADID-FAI-41', 'Fairway Green', '#2E7D32', '41', 1900, 3200, 0, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1i', 'prod_adi_stansmith', 'ADID-FAI-42', 'Fairway Green', '#2E7D32', '42', 1900, 3200, 0, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1h', 'prod_adi_stansmith', 'ADID-FAI-43', 'Fairway Green', '#2E7D32', '43', 1900, 3200, 0, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1g', 'prod_adi_stansmith', 'ADID-FAI-44', 'Fairway Green', '#2E7D32', '44', 1900, 3200, 0, 6, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0mkvb1f', 'prod_adi_stansmith', 'ADID-FAI-45', 'Fairway Green', '#2E7D32', '45', 1900, 3200, 0, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpi7', 'prod_adi_stansmith', 'ADID-NAV-36', 'Navy Heel', '#0D47A1', '36', 1900, 3200, 0, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpi8', 'prod_adi_stansmith', 'ADID-NAV-37', 'Navy Heel', '#0D47A1', '37', 1900, 3200, 0, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpi9', 'prod_adi_stansmith', 'ADID-NAV-38', 'Navy Heel', '#0D47A1', '38', 1900, 3200, 0, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpia', 'prod_adi_stansmith', 'ADID-NAV-39', 'Navy Heel', '#0D47A1', '39', 1900, 3200, 0, 12, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpiw', 'prod_adi_stansmith', 'ADID-NAV-40', 'Navy Heel', '#0D47A1', '40', 1900, 3200, 0, 19, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpix', 'prod_adi_stansmith', 'ADID-NAV-41', 'Navy Heel', '#0D47A1', '41', 1900, 3200, 0, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpiy', 'prod_adi_stansmith', 'ADID-NAV-42', 'Navy Heel', '#0D47A1', '42', 1900, 3200, 0, 6, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpiz', 'prod_adi_stansmith', 'ADID-NAV-43', 'Navy Heel', '#0D47A1', '43', 1900, 3200, 0, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpj0', 'prod_adi_stansmith', 'ADID-NAV-44', 'Navy Heel', '#0D47A1', '44', 1900, 3200, 0, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0pjzpj1', 'prod_adi_stansmith', 'ADID-NAV-45', 'Navy Heel', '#0D47A1', '45', 1900, 3200, 0, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwiq', 'prod_adi_superstar', 'ADID-WHI-36', 'White / Black', '#EEEEEE', '36', 2200, 3600, 3240, 13, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwip', 'prod_adi_superstar', 'ADID-WHI-37', 'White / Black', '#EEEEEE', '37', 2200, 3600, 3240, 12, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwio', 'prod_adi_superstar', 'ADID-WHI-38', 'White / Black', '#EEEEEE', '38', 2200, 3600, 3240, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwin', 'prod_adi_superstar', 'ADID-WHI-39', 'White / Black', '#EEEEEE', '39', 2200, 3600, 3240, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwi1', 'prod_adi_superstar', 'ADID-WHI-40', 'White / Black', '#EEEEEE', '40', 2200, 3600, 3240, 18, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwi0', 'prod_adi_superstar', 'ADID-WHI-41', 'White / Black', '#EEEEEE', '41', 2200, 3600, 3240, 17, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwhz', 'prod_adi_superstar', 'ADID-WHI-42', 'White / Black', '#EEEEEE', '42', 2200, 3600, 3240, 16, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwhy', 'prod_adi_superstar', 'ADID-WHI-43', 'White / Black', '#EEEEEE', '43', 2200, 3600, 3240, 15, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwhx', 'prod_adi_superstar', 'ADID-WHI-44', 'White / Black', '#EEEEEE', '44', 2200, 3600, 3240, 14, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0wwiwhw', 'prod_adi_superstar', 'ADID-WHI-45', 'White / Black', '#EEEEEE', '45', 2200, 3600, 3240, 0, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjevi', 'prod_adi_superstar', 'ADID-TRI-36', 'Triple Black', '#111111', '36', 2200, 3600, 3240, 14, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjevh', 'prod_adi_superstar', 'ADID-TRI-37', 'Triple Black', '#111111', '37', 2200, 3600, 3240, 13, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjevg', 'prod_adi_superstar', 'ADID-TRI-38', 'Triple Black', '#111111', '38', 2200, 3600, 3240, 12, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjevf', 'prod_adi_superstar', 'ADID-TRI-39', 'Triple Black', '#111111', '39', 2200, 3600, 3240, 11, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeut', 'prod_adi_superstar', 'ADID-TRI-40', 'Triple Black', '#111111', '40', 2200, 3600, 3240, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeus', 'prod_adi_superstar', 'ADID-TRI-41', 'Triple Black', '#111111', '41', 2200, 3600, 3240, 18, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeur', 'prod_adi_superstar', 'ADID-TRI-42', 'Triple Black', '#111111', '42', 2200, 3600, 3240, 17, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeuq', 'prod_adi_superstar', 'ADID-TRI-43', 'Triple Black', '#111111', '43', 2200, 3600, 3240, 16, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeup', 'prod_adi_superstar', 'ADID-TRI-44', 'Triple Black', '#111111', '44', 2200, 3600, 3240, 15, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis01vjeuo', 'prod_adi_superstar', 'ADID-TRI-45', 'Triple Black', '#111111', '45', 2200, 3600, 3240, 0, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixlk', 'prod_adi_spezial', 'ADID-LIG-36', 'Light Blue / White', '#81D4FA', '36', 2400, 4000, 3600, 10, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixlj', 'prod_adi_spezial', 'ADID-LIG-37', 'Light Blue / White', '#81D4FA', '37', 2400, 4000, 3600, 9, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixli', 'prod_adi_spezial', 'ADID-LIG-38', 'Light Blue / White', '#81D4FA', '38', 2400, 4000, 3600, 8, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixlh', 'prod_adi_spezial', 'ADID-LIG-39', 'Light Blue / White', '#81D4FA', '39', 2400, 4000, 3600, 7, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixkv', 'prod_adi_spezial', 'ADID-LIG-40', 'Light Blue / White', '#81D4FA', '40', 2400, 4000, 3600, 15, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixku', 'prod_adi_spezial', 'ADID-LIG-41', 'Light Blue / White', '#81D4FA', '41', 2400, 4000, 3600, 14, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixkt', 'prod_adi_spezial', 'ADID-LIG-42', 'Light Blue / White', '#81D4FA', '42', 2400, 4000, 3600, 13, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixks', 'prod_adi_spezial', 'ADID-LIG-43', 'Light Blue / White', '#81D4FA', '43', 2400, 4000, 3600, 12, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixkr', 'prod_adi_spezial', 'ADID-LIG-44', 'Light Blue / White', '#81D4FA', '44', 2400, 4000, 3600, 11, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0iaixkq', 'prod_adi_spezial', 'ADID-LIG-45', 'Light Blue / White', '#81D4FA', '45', 2400, 4000, 3600, 10, '/images/products/adidas_gazelle_blue.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1ec', 'prod_adi_spezial', 'ADID-EAR-36', 'Earth Strata / Brown', '#795548', '36', 2400, 4000, 3600, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1eb', 'prod_adi_spezial', 'ADID-EAR-37', 'Earth Strata / Brown', '#795548', '37', 2400, 4000, 3600, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1ea', 'prod_adi_spezial', 'ADID-EAR-38', 'Earth Strata / Brown', '#795548', '38', 2400, 4000, 3600, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1e9', 'prod_adi_spezial', 'ADID-EAR-39', 'Earth Strata / Brown', '#795548', '39', 2400, 4000, 3600, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1dn', 'prod_adi_spezial', 'ADID-EAR-40', 'Earth Strata / Brown', '#795548', '40', 2400, 4000, 3600, 16, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1dm', 'prod_adi_spezial', 'ADID-EAR-41', 'Earth Strata / Brown', '#795548', '41', 2400, 4000, 3600, 15, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1dl', 'prod_adi_spezial', 'ADID-EAR-42', 'Earth Strata / Brown', '#795548', '42', 2400, 4000, 3600, 14, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1dk', 'prod_adi_spezial', 'ADID-EAR-43', 'Earth Strata / Brown', '#795548', '43', 2400, 4000, 3600, 13, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1dj', 'prod_adi_spezial', 'ADID-EAR-44', 'Earth Strata / Brown', '#795548', '44', 2400, 4000, 3600, 12, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodadis0suv1di', 'prod_adi_spezial', 'ADID-EAR-45', 'Earth Strata / Brown', '#795548', '45', 2400, 4000, 3600, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc32', '2wf6542jhxbpzw0', 'NEWB-WHI-36', 'White / Silver Metallic', '#E0E0E0', '36', 2500, 4200, 3780, 16, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc33', '2wf6542jhxbpzw0', 'NEWB-WHI-37', 'White / Silver Metallic', '#E0E0E0', '37', 2500, 4200, 3780, 17, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc34', '2wf6542jhxbpzw0', 'NEWB-WHI-38', 'White / Silver Metallic', '#E0E0E0', '38', 2500, 4200, 3780, 18, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc35', '2wf6542jhxbpzw0', 'NEWB-WHI-39', 'White / Silver Metallic', '#E0E0E0', '39', 2500, 4200, 3780, 19, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3r', '2wf6542jhxbpzw0', 'NEWB-WHI-40', 'White / Silver Metallic', '#E0E0E0', '40', 2500, 4200, 3780, 11, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3s', '2wf6542jhxbpzw0', 'NEWB-WHI-41', 'White / Silver Metallic', '#E0E0E0', '41', 2500, 4200, 3780, 12, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3t', '2wf6542jhxbpzw0', 'NEWB-WHI-42', 'White / Silver Metallic', '#E0E0E0', '42', 2500, 4200, 3780, 13, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3u', '2wf6542jhxbpzw0', 'NEWB-WHI-43', 'White / Silver Metallic', '#E0E0E0', '43', 2500, 4200, 3780, 14, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3v', '2wf6542jhxbpzw0', 'NEWB-WHI-44', 'White / Silver Metallic', '#E0E0E0', '44', 2500, 4200, 3780, 15, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j03fbc3w', '2wf6542jhxbpzw0', 'NEWB-WHI-45', 'White / Silver Metallic', '#E0E0E0', '45', 2500, 4200, 3780, 16, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5ho8', '2wf6542jhxbpzw0', 'NEWB-STE-36', 'Steel Grey', '#78909C', '36', 2500, 4200, 3780, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5ho9', '2wf6542jhxbpzw0', 'NEWB-STE-37', 'Steel Grey', '#78909C', '37', 2500, 4200, 3780, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hoa', '2wf6542jhxbpzw0', 'NEWB-STE-38', 'Steel Grey', '#78909C', '38', 2500, 4200, 3780, 9, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hob', '2wf6542jhxbpzw0', 'NEWB-STE-39', 'Steel Grey', '#78909C', '39', 2500, 4200, 3780, 10, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hox', '2wf6542jhxbpzw0', 'NEWB-STE-40', 'Steel Grey', '#78909C', '40', 2500, 4200, 3780, 17, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hoy', '2wf6542jhxbpzw0', 'NEWB-STE-41', 'Steel Grey', '#78909C', '41', 2500, 4200, 3780, 18, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hoz', '2wf6542jhxbpzw0', 'NEWB-STE-42', 'Steel Grey', '#78909C', '42', 2500, 4200, 3780, 19, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hp0', '2wf6542jhxbpzw0', 'NEWB-STE-43', 'Steel Grey', '#78909C', '43', 2500, 4200, 3780, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hp1', '2wf6542jhxbpzw0', 'NEWB-STE-44', 'Steel Grey', '#78909C', '44', 2500, 4200, 3780, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('2wf6542j0lc5hp2', '2wf6542jhxbpzw0', 'NEWB-STE-45', 'Steel Grey', '#78909C', '45', 2500, 4200, 3780, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0cdp', 'nb574coregrey01', 'NEWB-CLA-36', 'Classic Grey', '#757575', '36', 2100, 3500, 3150, 12, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0cdo', 'nb574coregrey01', 'NEWB-CLA-37', 'Classic Grey', '#757575', '37', 2100, 3500, 3150, 11, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0cdn', 'nb574coregrey01', 'NEWB-CLA-38', 'Classic Grey', '#757575', '38', 2100, 3500, 3150, 10, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0cdm', 'nb574coregrey01', 'NEWB-CLA-39', 'Classic Grey', '#757575', '39', 2100, 3500, 3150, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0cd0', 'nb574coregrey01', 'NEWB-CLA-40', 'Classic Grey', '#757575', '40', 2100, 3500, 3150, 17, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0ccz', 'nb574coregrey01', 'NEWB-CLA-41', 'Classic Grey', '#757575', '41', 2100, 3500, 3150, 16, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0ccy', 'nb574coregrey01', 'NEWB-CLA-42', 'Classic Grey', '#757575', '42', 2100, 3500, 3150, 15, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0ccx', 'nb574coregrey01', 'NEWB-CLA-43', 'Classic Grey', '#757575', '43', 2100, 3500, 3150, 14, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0ccw', 'nb574coregrey01', 'NEWB-CLA-44', 'Classic Grey', '#757575', '44', 2100, 3500, 3150, 13, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xo0ccv', 'nb574coregrey01', 'NEWB-CLA-45', 'Classic Grey', '#757575', '45', 2100, 3500, 3150, 12, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12n4', 'nb574coregrey01', 'NEWB-NAV-36', 'Navy Blue', '#1A237E', '36', 2100, 3500, 3150, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12n3', 'nb574coregrey01', 'NEWB-NAV-37', 'Navy Blue', '#1A237E', '37', 2100, 3500, 3150, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12n2', 'nb574coregrey01', 'NEWB-NAV-38', 'Navy Blue', '#1A237E', '38', 2100, 3500, 3150, 19, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12n1', 'nb574coregrey01', 'NEWB-NAV-39', 'Navy Blue', '#1A237E', '39', 2100, 3500, 3150, 18, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12mf', 'nb574coregrey01', 'NEWB-NAV-40', 'Navy Blue', '#1A237E', '40', 2100, 3500, 3150, 11, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12me', 'nb574coregrey01', 'NEWB-NAV-41', 'Navy Blue', '#1A237E', '41', 2100, 3500, 3150, 10, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12md', 'nb574coregrey01', 'NEWB-NAV-42', 'Navy Blue', '#1A237E', '42', 2100, 3500, 3150, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12mc', 'nb574coregrey01', 'NEWB-NAV-43', 'Navy Blue', '#1A237E', '43', 2100, 3500, 3150, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12mb', 'nb574coregrey01', 'NEWB-NAV-44', 'Navy Blue', '#1A237E', '44', 2100, 3500, 3150, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('nb574cor0xd12ma', 'nb574coregrey01', 'NEWB-NAV-45', 'Navy Blue', '#1A237E', '45', 2100, 3500, 3150, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlll', 'prod_nb_550', 'NEWB-WHI-36', 'White / Green', '#2E7D32', '36', 2800, 4600, 4140, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jllm', 'prod_nb_550', 'NEWB-WHI-37', 'White / Green', '#2E7D32', '37', 2800, 4600, 4140, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlln', 'prod_nb_550', 'NEWB-WHI-38', 'White / Green', '#2E7D32', '38', 2800, 4600, 4140, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jllo', 'prod_nb_550', 'NEWB-WHI-39', 'White / Green', '#2E7D32', '39', 2800, 4600, 4140, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlma', 'prod_nb_550', 'NEWB-WHI-40', 'White / Green', '#2E7D32', '40', 2800, 4600, 4140, 6, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlmb', 'prod_nb_550', 'NEWB-WHI-41', 'White / Green', '#2E7D32', '41', 2800, 4600, 4140, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlmc', 'prod_nb_550', 'NEWB-WHI-42', 'White / Green', '#2E7D32', '42', 2800, 4600, 4140, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlmd', 'prod_nb_550', 'NEWB-WHI-43', 'White / Green', '#2E7D32', '43', 2800, 4600, 4140, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlme', 'prod_nb_550', 'NEWB-WHI-44', 'White / Green', '#2E7D32', '44', 2800, 4600, 4140, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550d6jlmf', 'prod_nb_550', 'NEWB-WHI-45', 'White / Green', '#2E7D32', '45', 2800, 4600, 4140, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo21', 'prod_nb_550', 'NEWB-WHI-36', 'White / Grey', '#BDBDBD', '36', 2800, 4600, 4140, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo22', 'prod_nb_550', 'NEWB-WHI-37', 'White / Grey', '#BDBDBD', '37', 2800, 4600, 4140, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo23', 'prod_nb_550', 'NEWB-WHI-38', 'White / Grey', '#BDBDBD', '38', 2800, 4600, 4140, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo24', 'prod_nb_550', 'NEWB-WHI-39', 'White / Grey', '#BDBDBD', '39', 2800, 4600, 4140, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2q', 'prod_nb_550', 'NEWB-WHI-40', 'White / Grey', '#BDBDBD', '40', 2800, 4600, 4140, 19, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2r', 'prod_nb_550', 'NEWB-WHI-41', 'White / Grey', '#BDBDBD', '41', 2800, 4600, 4140, 5, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2s', 'prod_nb_550', 'NEWB-WHI-42', 'White / Grey', '#BDBDBD', '42', 2800, 4600, 4140, 6, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2t', 'prod_nb_550', 'NEWB-WHI-43', 'White / Grey', '#BDBDBD', '43', 2800, 4600, 4140, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2u', 'prod_nb_550', 'NEWB-WHI-44', 'White / Grey', '#BDBDBD', '44', 2800, 4600, 4140, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb550u7zo2v', 'prod_nb_550', 'NEWB-WHI-45', 'White / Grey', '#BDBDBD', '45', 2800, 4600, 4140, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtew9', 'prod_nb_2002r', 'NEWB-PRO-36', 'Protection Pack Rain Cloud', '#9E9E9E', '36', 3600, 5800, 5220, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtewa', 'prod_nb_2002r', 'NEWB-PRO-37', 'Protection Pack Rain Cloud', '#9E9E9E', '37', 3600, 5800, 5220, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtewb', 'prod_nb_2002r', 'NEWB-PRO-38', 'Protection Pack Rain Cloud', '#9E9E9E', '38', 3600, 5800, 5220, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtewc', 'prod_nb_2002r', 'NEWB-PRO-39', 'Protection Pack Rain Cloud', '#9E9E9E', '39', 3600, 5800, 5220, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtewy', 'prod_nb_2002r', 'NEWB-PRO-40', 'Protection Pack Rain Cloud', '#9E9E9E', '40', 3600, 5800, 5220, 15, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtewz', 'prod_nb_2002r', 'NEWB-PRO-41', 'Protection Pack Rain Cloud', '#9E9E9E', '41', 3600, 5800, 5220, 16, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtex0', 'prod_nb_2002r', 'NEWB-PRO-42', 'Protection Pack Rain Cloud', '#9E9E9E', '42', 3600, 5800, 5220, 17, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtex1', 'prod_nb_2002r', 'NEWB-PRO-43', 'Protection Pack Rain Cloud', '#9E9E9E', '43', 3600, 5800, 5220, 18, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtex2', 'prod_nb_2002r', 'NEWB-PRO-44', 'Protection Pack Rain Cloud', '#9E9E9E', '44', 3600, 5800, 5220, 19, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2005vtex3', 'prod_nb_2002r', 'NEWB-PRO-45', 'Protection Pack Rain Cloud', '#9E9E9E', '45', 3600, 5800, 5220, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318cm', 'prod_nb_2002r', 'NEWB-PHA-36', 'Phantom Black', '#263238', '36', 3600, 5800, 5220, 9, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318cn', 'prod_nb_2002r', 'NEWB-PHA-37', 'Phantom Black', '#263238', '37', 3600, 5800, 5220, 10, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318co', 'prod_nb_2002r', 'NEWB-PHA-38', 'Phantom Black', '#263238', '38', 3600, 5800, 5220, 11, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318cp', 'prod_nb_2002r', 'NEWB-PHA-39', 'Phantom Black', '#263238', '39', 3600, 5800, 5220, 12, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318db', 'prod_nb_2002r', 'NEWB-PHA-40', 'Phantom Black', '#263238', '40', 3600, 5800, 5220, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318dc', 'prod_nb_2002r', 'NEWB-PHA-41', 'Phantom Black', '#263238', '41', 3600, 5800, 5220, 5, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318dd', 'prod_nb_2002r', 'NEWB-PHA-42', 'Phantom Black', '#263238', '42', 3600, 5800, 5220, 6, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318de', 'prod_nb_2002r', 'NEWB-PHA-43', 'Phantom Black', '#263238', '43', 3600, 5800, 5220, 7, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318df', 'prod_nb_2002r', 'NEWB-PHA-44', 'Phantom Black', '#263238', '44', 3600, 5800, 5220, 8, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb2008318dg', 'prod_nb_2002r', 'NEWB-PHA-45', 'Phantom Black', '#263238', '45', 3600, 5800, 5220, 0, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhom', 'prod_nb_1906r', 'NEWB-MET-36', 'Metallic Silver / White', '#CFD8DC', '36', 3700, 6000, 5400, 12, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhol', 'prod_nb_1906r', 'NEWB-MET-37', 'Metallic Silver / White', '#CFD8DC', '37', 3700, 6000, 5400, 11, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhok', 'prod_nb_1906r', 'NEWB-MET-38', 'Metallic Silver / White', '#CFD8DC', '38', 3700, 6000, 5400, 10, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhoj', 'prod_nb_1906r', 'NEWB-MET-39', 'Metallic Silver / White', '#CFD8DC', '39', 3700, 6000, 5400, 9, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhnx', 'prod_nb_1906r', 'NEWB-MET-40', 'Metallic Silver / White', '#CFD8DC', '40', 3700, 6000, 5400, 17, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhnw', 'prod_nb_1906r', 'NEWB-MET-41', 'Metallic Silver / White', '#CFD8DC', '41', 3700, 6000, 5400, 16, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhnv', 'prod_nb_1906r', 'NEWB-MET-42', 'Metallic Silver / White', '#CFD8DC', '42', 3700, 6000, 5400, 15, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhnu', 'prod_nb_1906r', 'NEWB-MET-43', 'Metallic Silver / White', '#CFD8DC', '43', 3700, 6000, 5400, 14, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhnt', 'prod_nb_1906r', 'NEWB-MET-44', 'Metallic Silver / White', '#CFD8DC', '44', 3700, 6000, 5400, 13, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb1905ozhns', 'prod_nb_1906r', 'NEWB-MET-45', 'Metallic Silver / White', '#CFD8DC', '45', 3700, 6000, 5400, 12, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tyu', 'prod_nb_1906r', 'NEWB-TIT-36', 'Titanium Grey', '#607D8B', '36', 3700, 6000, 5400, 11, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tyv', 'prod_nb_1906r', 'NEWB-TIT-37', 'Titanium Grey', '#607D8B', '37', 3700, 6000, 5400, 12, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tyw', 'prod_nb_1906r', 'NEWB-TIT-38', 'Titanium Grey', '#607D8B', '38', 3700, 6000, 5400, 13, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tyx', 'prod_nb_1906r', 'NEWB-TIT-39', 'Titanium Grey', '#607D8B', '39', 3700, 6000, 5400, 14, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzj', 'prod_nb_1906r', 'NEWB-TIT-40', 'Titanium Grey', '#607D8B', '40', 3700, 6000, 5400, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzk', 'prod_nb_1906r', 'NEWB-TIT-41', 'Titanium Grey', '#607D8B', '41', 3700, 6000, 5400, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzl', 'prod_nb_1906r', 'NEWB-TIT-42', 'Titanium Grey', '#607D8B', '42', 3700, 6000, 5400, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzm', 'prod_nb_1906r', 'NEWB-TIT-43', 'Titanium Grey', '#607D8B', '43', 3700, 6000, 5400, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzn', 'prod_nb_1906r', 'NEWB-TIT-44', 'Titanium Grey', '#607D8B', '44', 3700, 6000, 5400, 10, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb190094tzo', 'prod_nb_1906r', 'NEWB-TIT-45', 'Titanium Grey', '#607D8B', '45', 3700, 6000, 5400, 11, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x74', 'prod_nb_9060', 'NEWB-SEA-36', 'Sea Salt', '#ECEFF1', '36', 4000, 6500, 5850, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x73', 'prod_nb_9060', 'NEWB-SEA-37', 'Sea Salt', '#ECEFF1', '37', 4000, 6500, 5850, 5, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x72', 'prod_nb_9060', 'NEWB-SEA-38', 'Sea Salt', '#ECEFF1', '38', 4000, 6500, 5850, 19, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x71', 'prod_nb_9060', 'NEWB-SEA-39', 'Sea Salt', '#ECEFF1', '39', 4000, 6500, 5850, 18, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6f', 'prod_nb_9060', 'NEWB-SEA-40', 'Sea Salt', '#ECEFF1', '40', 4000, 6500, 5850, 11, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6e', 'prod_nb_9060', 'NEWB-SEA-41', 'Sea Salt', '#ECEFF1', '41', 4000, 6500, 5850, 10, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6d', 'prod_nb_9060', 'NEWB-SEA-42', 'Sea Salt', '#ECEFF1', '42', 4000, 6500, 5850, 9, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6c', 'prod_nb_9060', 'NEWB-SEA-43', 'Sea Salt', '#ECEFF1', '43', 4000, 6500, 5850, 8, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6b', 'prod_nb_9060', 'NEWB-SEA-44', 'Sea Salt', '#ECEFF1', '44', 4000, 6500, 5850, 7, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb900138x6a', 'prod_nb_9060', 'NEWB-SEA-45', 'Sea Salt', '#ECEFF1', '45', 4000, 6500, 5850, 6, '/images/products/nb530_silver.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h55', 'prod_nb_9060', 'NEWB-RAI-36', 'Rain Cloud Grey', '#78909C', '36', 4000, 6500, 5850, 19, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h54', 'prod_nb_9060', 'NEWB-RAI-37', 'Rain Cloud Grey', '#78909C', '37', 4000, 6500, 5850, 18, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h53', 'prod_nb_9060', 'NEWB-RAI-38', 'Rain Cloud Grey', '#78909C', '38', 4000, 6500, 5850, 17, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h52', 'prod_nb_9060', 'NEWB-RAI-39', 'Rain Cloud Grey', '#78909C', '39', 4000, 6500, 5850, 16, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4g', 'prod_nb_9060', 'NEWB-RAI-40', 'Rain Cloud Grey', '#78909C', '40', 4000, 6500, 5850, 9, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4f', 'prod_nb_9060', 'NEWB-RAI-41', 'Rain Cloud Grey', '#78909C', '41', 4000, 6500, 5850, 8, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4e', 'prod_nb_9060', 'NEWB-RAI-42', 'Rain Cloud Grey', '#78909C', '42', 4000, 6500, 5850, 7, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4d', 'prod_nb_9060', 'NEWB-RAI-43', 'Rain Cloud Grey', '#78909C', '43', 4000, 6500, 5850, 6, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4c', 'prod_nb_9060', 'NEWB-RAI-44', 'Rain Cloud Grey', '#78909C', '44', 4000, 6500, 5850, 5, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodnb9007x7h4b', 'prod_nb_9060', 'NEWB-RAI-45', 'Rain Cloud Grey', '#78909C', '45', 4000, 6500, 5850, 19, '/images/products/nb574_grey.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvz7', 'vi3bo1003u2b1fx', 'CONV-CLA-36', 'Classic Black', '#111111', '36', 1900, 3300, 2970, 15, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvz8', 'vi3bo1003u2b1fx', 'CONV-CLA-37', 'Classic Black', '#111111', '37', 1900, 3300, 2970, 16, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvz9', 'vi3bo1003u2b1fx', 'CONV-CLA-38', 'Classic Black', '#111111', '38', 1900, 3300, 2970, 17, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvza', 'vi3bo1003u2b1fx', 'CONV-CLA-39', 'Classic Black', '#111111', '39', 1900, 3300, 2970, 18, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvzw', 'vi3bo1003u2b1fx', 'CONV-CLA-40', 'Classic Black', '#111111', '40', 1900, 3300, 2970, 10, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvzx', 'vi3bo1003u2b1fx', 'CONV-CLA-41', 'Classic Black', '#111111', '41', 1900, 3300, 2970, 11, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvzy', 'vi3bo1003u2b1fx', 'CONV-CLA-42', 'Classic Black', '#111111', '42', 1900, 3300, 2970, 12, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cvzz', 'vi3bo1003u2b1fx', 'CONV-CLA-43', 'Classic Black', '#111111', '43', 1900, 3300, 2970, 13, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cw00', 'vi3bo1003u2b1fx', 'CONV-CLA-44', 'Classic Black', '#111111', '44', 1900, 3300, 2970, 14, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo1000p0cw01', 'vi3bo1003u2b1fx', 'CONV-CLA-45', 'Classic Black', '#111111', '45', 1900, 3300, 2970, 0, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hdb', 'vi3bo1003u2b1fx', 'CONV-PAR-36', 'Parchment Egret', '#FFF8E1', '36', 1900, 3300, 2970, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hda', 'vi3bo1003u2b1fx', 'CONV-PAR-37', 'Parchment Egret', '#FFF8E1', '37', 1900, 3300, 2970, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hd9', 'vi3bo1003u2b1fx', 'CONV-PAR-38', 'Parchment Egret', '#FFF8E1', '38', 1900, 3300, 2970, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hd8', 'vi3bo1003u2b1fx', 'CONV-PAR-39', 'Parchment Egret', '#FFF8E1', '39', 1900, 3300, 2970, 19, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hcm', 'vi3bo1003u2b1fx', 'CONV-PAR-40', 'Parchment Egret', '#FFF8E1', '40', 1900, 3300, 2970, 12, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hcl', 'vi3bo1003u2b1fx', 'CONV-PAR-41', 'Parchment Egret', '#FFF8E1', '41', 1900, 3300, 2970, 11, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hck', 'vi3bo1003u2b1fx', 'CONV-PAR-42', 'Parchment Egret', '#FFF8E1', '42', 1900, 3300, 2970, 10, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hcj', 'vi3bo1003u2b1fx', 'CONV-PAR-43', 'Parchment Egret', '#FFF8E1', '43', 1900, 3300, 2970, 9, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hci', 'vi3bo1003u2b1fx', 'CONV-PAR-44', 'Parchment Egret', '#FFF8E1', '44', 1900, 3300, 2970, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vi3bo10006w3hch', 'vi3bo1003u2b1fx', 'CONV-PAR-45', 'Parchment Egret', '#FFF8E1', '45', 1900, 3300, 2970, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p1769', 'prod_conv_low', 'CONV-OPT-36', 'Optical White', '#FAFAFA', '36', 1300, 2300, 0, 17, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p1768', 'prod_conv_low', 'CONV-OPT-37', 'Optical White', '#FAFAFA', '37', 1300, 2300, 0, 16, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p1767', 'prod_conv_low', 'CONV-OPT-38', 'Optical White', '#FAFAFA', '38', 1300, 2300, 0, 15, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p1766', 'prod_conv_low', 'CONV-OPT-39', 'Optical White', '#FAFAFA', '39', 1300, 2300, 0, 14, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175k', 'prod_conv_low', 'CONV-OPT-40', 'Optical White', '#FAFAFA', '40', 1300, 2300, 0, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175j', 'prod_conv_low', 'CONV-OPT-41', 'Optical White', '#FAFAFA', '41', 1300, 2300, 0, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175i', 'prod_conv_low', 'CONV-OPT-42', 'Optical White', '#FAFAFA', '42', 1300, 2300, 0, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175h', 'prod_conv_low', 'CONV-OPT-43', 'Optical White', '#FAFAFA', '43', 1300, 2300, 0, 19, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175g', 'prod_conv_low', 'CONV-OPT-44', 'Optical White', '#FAFAFA', '44', 1300, 2300, 0, 18, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv04p175f', 'prod_conv_low', 'CONV-OPT-45', 'Optical White', '#FAFAFA', '45', 1300, 2300, 0, 17, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g79', 'prod_conv_low', 'CONV-BLA-36', 'Black Canvas', '#212121', '36', 1300, 2300, 0, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g78', 'prod_conv_low', 'CONV-BLA-37', 'Black Canvas', '#212121', '37', 1300, 2300, 0, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g77', 'prod_conv_low', 'CONV-BLA-38', 'Black Canvas', '#212121', '38', 1300, 2300, 0, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g76', 'prod_conv_low', 'CONV-BLA-39', 'Black Canvas', '#212121', '39', 1300, 2300, 0, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6k', 'prod_conv_low', 'CONV-BLA-40', 'Black Canvas', '#212121', '40', 1300, 2300, 0, 13, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6j', 'prod_conv_low', 'CONV-BLA-41', 'Black Canvas', '#212121', '41', 1300, 2300, 0, 12, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6i', 'prod_conv_low', 'CONV-BLA-42', 'Black Canvas', '#212121', '42', 1300, 2300, 0, 11, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6h', 'prod_conv_low', 'CONV-BLA-43', 'Black Canvas', '#212121', '43', 1300, 2300, 0, 10, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6g', 'prod_conv_low', 'CONV-BLA-44', 'Black Canvas', '#212121', '44', 1300, 2300, 0, 9, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0ru4g6f', 'prod_conv_low', 'CONV-BLA-45', 'Black Canvas', '#212121', '45', 1300, 2300, 0, 0, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d5u', 'prod_conv_runstar', 'CONV-BLA-36', 'Black / White / Gum', '#111111', '36', 2400, 4000, 3600, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d5v', 'prod_conv_runstar', 'CONV-BLA-37', 'Black / White / Gum', '#111111', '37', 2400, 4000, 3600, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d5w', 'prod_conv_runstar', 'CONV-BLA-38', 'Black / White / Gum', '#111111', '38', 2400, 4000, 3600, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d5x', 'prod_conv_runstar', 'CONV-BLA-39', 'Black / White / Gum', '#111111', '39', 2400, 4000, 3600, 8, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6j', 'prod_conv_runstar', 'CONV-BLA-40', 'Black / White / Gum', '#111111', '40', 2400, 4000, 3600, 15, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6k', 'prod_conv_runstar', 'CONV-BLA-41', 'Black / White / Gum', '#111111', '41', 2400, 4000, 3600, 16, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6l', 'prod_conv_runstar', 'CONV-BLA-42', 'Black / White / Gum', '#111111', '42', 2400, 4000, 3600, 17, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6m', 'prod_conv_runstar', 'CONV-BLA-43', 'Black / White / Gum', '#111111', '43', 2400, 4000, 3600, 18, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6n', 'prod_conv_runstar', 'CONV-BLA-44', 'Black / White / Gum', '#111111', '44', 2400, 4000, 3600, 19, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0bn8d6o', 'prod_conv_runstar', 'CONV-BLA-45', 'Black / White / Gum', '#111111', '45', 2400, 4000, 3600, 0, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr1q', 'prod_conv_runstar', 'CONV-WHI-36', 'White Canvas', '#FFFFFF', '36', 2400, 4000, 3600, 19, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr1r', 'prod_conv_runstar', 'CONV-WHI-37', 'White Canvas', '#FFFFFF', '37', 2400, 4000, 3600, 5, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr1s', 'prod_conv_runstar', 'CONV-WHI-38', 'White Canvas', '#FFFFFF', '38', 2400, 4000, 3600, 6, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr1t', 'prod_conv_runstar', 'CONV-WHI-39', 'White Canvas', '#FFFFFF', '39', 2400, 4000, 3600, 7, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2f', 'prod_conv_runstar', 'CONV-WHI-40', 'White Canvas', '#FFFFFF', '40', 2400, 4000, 3600, 14, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2g', 'prod_conv_runstar', 'CONV-WHI-41', 'White Canvas', '#FFFFFF', '41', 2400, 4000, 3600, 15, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2h', 'prod_conv_runstar', 'CONV-WHI-42', 'White Canvas', '#FFFFFF', '42', 2400, 4000, 3600, 16, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2i', 'prod_conv_runstar', 'CONV-WHI-43', 'White Canvas', '#FFFFFF', '43', 2400, 4000, 3600, 17, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2j', 'prod_conv_runstar', 'CONV-WHI-44', 'White Canvas', '#FFFFFF', '44', 2400, 4000, 3600, 18, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodconv0x4dr2k', 'prod_conv_runstar', 'CONV-WHI-45', 'White Canvas', '#FFFFFF', '45', 2400, 4000, 3600, 19, '/images/products/converse_chuck_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3d6', 'vansoldskool001', 'VANS-BLA-36', 'Black / White', '#111111', '36', 1700, 2900, 2610, 17, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3d5', 'vansoldskool001', 'VANS-BLA-37', 'Black / White', '#111111', '37', 1700, 2900, 2610, 16, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3d4', 'vansoldskool001', 'VANS-BLA-38', 'Black / White', '#111111', '38', 1700, 2900, 2610, 15, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3d3', 'vansoldskool001', 'VANS-BLA-39', 'Black / White', '#111111', '39', 1700, 2900, 2610, 14, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3ch', 'vansoldskool001', 'VANS-BLA-40', 'Black / White', '#111111', '40', 1700, 2900, 2610, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3cg', 'vansoldskool001', 'VANS-BLA-41', 'Black / White', '#111111', '41', 1700, 2900, 2610, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3cf', 'vansoldskool001', 'VANS-BLA-42', 'Black / White', '#111111', '42', 1700, 2900, 2610, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3ce', 'vansoldskool001', 'VANS-BLA-43', 'Black / White', '#111111', '43', 1700, 2900, 2610, 19, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3cd', 'vansoldskool001', 'VANS-BLA-44', 'Black / White', '#111111', '44', 1700, 2900, 2610, 18, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0vsg3cc', 'vansoldskool001', 'VANS-BLA-45', 'Black / White', '#111111', '45', 1700, 2900, 2610, 0, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixju', 'vansoldskool001', 'VANS-CHE-36', 'Checkerboard', '#424242', '36', 1700, 2900, 2610, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixjt', 'vansoldskool001', 'VANS-CHE-37', 'Checkerboard', '#424242', '37', 1700, 2900, 2610, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixjs', 'vansoldskool001', 'VANS-CHE-38', 'Checkerboard', '#424242', '38', 1700, 2900, 2610, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixjr', 'vansoldskool001', 'VANS-CHE-39', 'Checkerboard', '#424242', '39', 1700, 2900, 2610, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj5', 'vansoldskool001', 'VANS-CHE-40', 'Checkerboard', '#424242', '40', 1700, 2900, 2610, 13, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj4', 'vansoldskool001', 'VANS-CHE-41', 'Checkerboard', '#424242', '41', 1700, 2900, 2610, 12, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj3', 'vansoldskool001', 'VANS-CHE-42', 'Checkerboard', '#424242', '42', 1700, 2900, 2610, 11, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj2', 'vansoldskool001', 'VANS-CHE-43', 'Checkerboard', '#424242', '43', 1700, 2900, 2610, 10, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj1', 'vansoldskool001', 'VANS-CHE-44', 'Checkerboard', '#424242', '44', 1700, 2900, 2610, 9, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('vansolds0hvixj0', 'vansoldskool001', 'VANS-CHE-45', 'Checkerboard', '#424242', '45', 1700, 2900, 2610, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw1w', 'prod_vans_sk8hi', 'VANS-BLA-36', 'Black / White Canvas', '#111111', '36', 2000, 3300, 2970, 10, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw1v', 'prod_vans_sk8hi', 'VANS-BLA-37', 'Black / White Canvas', '#111111', '37', 2000, 3300, 2970, 9, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw1u', 'prod_vans_sk8hi', 'VANS-BLA-38', 'Black / White Canvas', '#111111', '38', 2000, 3300, 2970, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw1t', 'prod_vans_sk8hi', 'VANS-BLA-39', 'Black / White Canvas', '#111111', '39', 2000, 3300, 2970, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw17', 'prod_vans_sk8hi', 'VANS-BLA-40', 'Black / White Canvas', '#111111', '40', 2000, 3300, 2970, 15, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw16', 'prod_vans_sk8hi', 'VANS-BLA-41', 'Black / White Canvas', '#111111', '41', 2000, 3300, 2970, 14, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw15', 'prod_vans_sk8hi', 'VANS-BLA-42', 'Black / White Canvas', '#111111', '42', 2000, 3300, 2970, 13, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw14', 'prod_vans_sk8hi', 'VANS-BLA-43', 'Black / White Canvas', '#111111', '43', 2000, 3300, 2970, 12, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw13', 'prod_vans_sk8hi', 'VANS-BLA-44', 'Black / White Canvas', '#111111', '44', 2000, 3300, 2970, 11, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00olw12', 'prod_vans_sk8hi', 'VANS-BLA-45', 'Black / White Canvas', '#111111', '45', 2000, 3300, 2970, 0, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7ov', 'prod_vans_sk8hi', 'VANS-NAV-36', 'Navy / White', '#1A237E', '36', 2000, 3300, 2970, 18, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7ow', 'prod_vans_sk8hi', 'VANS-NAV-37', 'Navy / White', '#1A237E', '37', 2000, 3300, 2970, 19, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7ox', 'prod_vans_sk8hi', 'VANS-NAV-38', 'Navy / White', '#1A237E', '38', 2000, 3300, 2970, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7oy', 'prod_vans_sk8hi', 'VANS-NAV-39', 'Navy / White', '#1A237E', '39', 2000, 3300, 2970, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7pk', 'prod_vans_sk8hi', 'VANS-NAV-40', 'Navy / White', '#1A237E', '40', 2000, 3300, 2970, 13, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7pl', 'prod_vans_sk8hi', 'VANS-NAV-41', 'Navy / White', '#1A237E', '41', 2000, 3300, 2970, 14, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7pm', 'prod_vans_sk8hi', 'VANS-NAV-42', 'Navy / White', '#1A237E', '42', 2000, 3300, 2970, 15, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7pn', 'prod_vans_sk8hi', 'VANS-NAV-43', 'Navy / White', '#1A237E', '43', 2000, 3300, 2970, 16, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7po', 'prod_vans_sk8hi', 'VANS-NAV-44', 'Navy / White', '#1A237E', '44', 2000, 3300, 2970, 17, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0nqc7pp', 'prod_vans_sk8hi', 'VANS-NAV-45', 'Navy / White', '#1A237E', '45', 2000, 3300, 2970, 18, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlfi', 'prod_vans_authentic', 'VANS-TRU-36', 'True White', '#FFFFFF', '36', 1400, 2400, 0, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlfh', 'prod_vans_authentic', 'VANS-TRU-37', 'True White', '#FFFFFF', '37', 1400, 2400, 0, 19, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlfg', 'prod_vans_authentic', 'VANS-TRU-38', 'True White', '#FFFFFF', '38', 1400, 2400, 0, 18, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlff', 'prod_vans_authentic', 'VANS-TRU-39', 'True White', '#FFFFFF', '39', 1400, 2400, 0, 17, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlet', 'prod_vans_authentic', 'VANS-TRU-40', 'True White', '#FFFFFF', '40', 1400, 2400, 0, 10, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarles', 'prod_vans_authentic', 'VANS-TRU-41', 'True White', '#FFFFFF', '41', 1400, 2400, 0, 9, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarler', 'prod_vans_authentic', 'VANS-TRU-42', 'True White', '#FFFFFF', '42', 1400, 2400, 0, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarleq', 'prod_vans_authentic', 'VANS-TRU-43', 'True White', '#FFFFFF', '43', 1400, 2400, 0, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarlep', 'prod_vans_authentic', 'VANS-TRU-44', 'True White', '#FFFFFF', '44', 1400, 2400, 0, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans0tarleo', 'prod_vans_authentic', 'VANS-TRU-45', 'True White', '#FFFFFF', '45', 1400, 2400, 0, 5, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz00u', 'prod_vans_authentic', 'VANS-BLA-36', 'Black / Black', '#111111', '36', 1400, 2400, 0, 11, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz00v', 'prod_vans_authentic', 'VANS-BLA-37', 'Black / Black', '#111111', '37', 1400, 2400, 0, 12, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz00w', 'prod_vans_authentic', 'VANS-BLA-38', 'Black / Black', '#111111', '38', 1400, 2400, 0, 13, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz00x', 'prod_vans_authentic', 'VANS-BLA-39', 'Black / Black', '#111111', '39', 1400, 2400, 0, 14, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01j', 'prod_vans_authentic', 'VANS-BLA-40', 'Black / Black', '#111111', '40', 1400, 2400, 0, 6, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01k', 'prod_vans_authentic', 'VANS-BLA-41', 'Black / Black', '#111111', '41', 1400, 2400, 0, 7, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01l', 'prod_vans_authentic', 'VANS-BLA-42', 'Black / Black', '#111111', '42', 1400, 2400, 0, 8, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01m', 'prod_vans_authentic', 'VANS-BLA-43', 'Black / Black', '#111111', '43', 1400, 2400, 0, 9, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01n', 'prod_vans_authentic', 'VANS-BLA-44', 'Black / Black', '#111111', '44', 1400, 2400, 0, 10, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodvans00gz01o', 'prod_vans_authentic', 'VANS-BLA-45', 'Black / Black', '#111111', '45', 1400, 2400, 0, 0, '/images/products/vans_old_skool.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n1p', 'pumasuedeclsx01', 'PUMA-PUM-36', 'Puma Black / White', '#111111', '36', 1800, 3200, 2880, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n1q', 'pumasuedeclsx01', 'PUMA-PUM-37', 'Puma Black / White', '#111111', '37', 1800, 3200, 2880, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n1r', 'pumasuedeclsx01', 'PUMA-PUM-38', 'Puma Black / White', '#111111', '38', 1800, 3200, 2880, 17, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n1s', 'pumasuedeclsx01', 'PUMA-PUM-39', 'Puma Black / White', '#111111', '39', 1800, 3200, 2880, 18, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2e', 'pumasuedeclsx01', 'PUMA-PUM-40', 'Puma Black / White', '#111111', '40', 1800, 3200, 2880, 10, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2f', 'pumasuedeclsx01', 'PUMA-PUM-41', 'Puma Black / White', '#111111', '41', 1800, 3200, 2880, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2g', 'pumasuedeclsx01', 'PUMA-PUM-42', 'Puma Black / White', '#111111', '42', 1800, 3200, 2880, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2h', 'pumasuedeclsx01', 'PUMA-PUM-43', 'Puma Black / White', '#111111', '43', 1800, 3200, 2880, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2i', 'pumasuedeclsx01', 'PUMA-PUM-44', 'Puma Black / White', '#111111', '44', 1800, 3200, 2880, 14, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0k47n2j', 'pumasuedeclsx01', 'PUMA-PUM-45', 'Puma Black / White', '#111111', '45', 1800, 3200, 2880, 0, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3g2', 'pumasuedeclsx01', 'PUMA-PEA-36', 'Peacoat Navy', '#1A237E', '36', 1800, 3200, 2880, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3g3', 'pumasuedeclsx01', 'PUMA-PEA-37', 'Peacoat Navy', '#1A237E', '37', 1800, 3200, 2880, 14, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3g4', 'pumasuedeclsx01', 'PUMA-PEA-38', 'Peacoat Navy', '#1A237E', '38', 1800, 3200, 2880, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3g5', 'pumasuedeclsx01', 'PUMA-PEA-39', 'Peacoat Navy', '#1A237E', '39', 1800, 3200, 2880, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gr', 'pumasuedeclsx01', 'PUMA-PEA-40', 'Peacoat Navy', '#1A237E', '40', 1800, 3200, 2880, 8, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gs', 'pumasuedeclsx01', 'PUMA-PEA-41', 'Peacoat Navy', '#1A237E', '41', 1800, 3200, 2880, 9, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gt', 'pumasuedeclsx01', 'PUMA-PEA-42', 'Peacoat Navy', '#1A237E', '42', 1800, 3200, 2880, 10, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gu', 'pumasuedeclsx01', 'PUMA-PEA-43', 'Peacoat Navy', '#1A237E', '43', 1800, 3200, 2880, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gv', 'pumasuedeclsx01', 'PUMA-PEA-44', 'Peacoat Navy', '#1A237E', '44', 1800, 3200, 2880, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('pumasued0c4l3gw', 'pumasuedeclsx01', 'PUMA-PEA-45', 'Peacoat Navy', '#1A237E', '45', 1800, 3200, 2880, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk98', 'prod_puma_palermo', 'PUMA-ALP-36', 'Alpine Snow / Blue', '#E0F7FA', '36', 2100, 3600, 3240, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk99', 'prod_puma_palermo', 'PUMA-ALP-37', 'Alpine Snow / Blue', '#E0F7FA', '37', 2100, 3600, 3240, 17, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk9a', 'prod_puma_palermo', 'PUMA-ALP-38', 'Alpine Snow / Blue', '#E0F7FA', '38', 2100, 3600, 3240, 18, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk9b', 'prod_puma_palermo', 'PUMA-ALP-39', 'Alpine Snow / Blue', '#E0F7FA', '39', 2100, 3600, 3240, 19, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk9x', 'prod_puma_palermo', 'PUMA-ALP-40', 'Alpine Snow / Blue', '#E0F7FA', '40', 2100, 3600, 3240, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk9y', 'prod_puma_palermo', 'PUMA-ALP-41', 'Alpine Snow / Blue', '#E0F7FA', '41', 2100, 3600, 3240, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pk9z', 'prod_puma_palermo', 'PUMA-ALP-42', 'Alpine Snow / Blue', '#E0F7FA', '42', 2100, 3600, 3240, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pka0', 'prod_puma_palermo', 'PUMA-ALP-43', 'Alpine Snow / Blue', '#E0F7FA', '43', 2100, 3600, 3240, 14, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pka1', 'prod_puma_palermo', 'PUMA-ALP-44', 'Alpine Snow / Blue', '#E0F7FA', '44', 2100, 3600, 3240, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma059pka2', 'prod_puma_palermo', 'PUMA-ALP-45', 'Alpine Snow / Blue', '#E0F7FA', '45', 2100, 3600, 3240, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpoh', 'prod_puma_palermo', 'PUMA-PEL-36', 'Pelé Yellow / Green', '#FDD835', '36', 2100, 3600, 3240, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpoi', 'prod_puma_palermo', 'PUMA-PEL-37', 'Pelé Yellow / Green', '#FDD835', '37', 2100, 3600, 3240, 17, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpoj', 'prod_puma_palermo', 'PUMA-PEL-38', 'Pelé Yellow / Green', '#FDD835', '38', 2100, 3600, 3240, 18, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpok', 'prod_puma_palermo', 'PUMA-PEL-39', 'Pelé Yellow / Green', '#FDD835', '39', 2100, 3600, 3240, 19, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpp6', 'prod_puma_palermo', 'PUMA-PEL-40', 'Pelé Yellow / Green', '#FDD835', '40', 2100, 3600, 3240, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpp7', 'prod_puma_palermo', 'PUMA-PEL-41', 'Pelé Yellow / Green', '#FDD835', '41', 2100, 3600, 3240, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpp8', 'prod_puma_palermo', 'PUMA-PEL-42', 'Pelé Yellow / Green', '#FDD835', '42', 2100, 3600, 3240, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzpp9', 'prod_puma_palermo', 'PUMA-PEL-43', 'Pelé Yellow / Green', '#FDD835', '43', 2100, 3600, 3240, 14, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzppa', 'prod_puma_palermo', 'PUMA-PEL-44', 'Pelé Yellow / Green', '#FDD835', '44', 2100, 3600, 3240, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodpuma0oqzppb', 'prod_puma_palermo', 'PUMA-PEL-45', 'Pelé Yellow / Green', '#FDD835', '45', 2100, 3600, 3240, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzv3', 'asicsgelkayan01', 'ASIC-WHI-36', 'White / Pure Gold / Silver', '#CFD8DC', '36', 3300, 5500, 4950, 17, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzv4', 'asicsgelkayan01', 'ASIC-WHI-37', 'White / Pure Gold / Silver', '#CFD8DC', '37', 3300, 5500, 4950, 18, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzv5', 'asicsgelkayan01', 'ASIC-WHI-38', 'White / Pure Gold / Silver', '#CFD8DC', '38', 3300, 5500, 4950, 19, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzv6', 'asicsgelkayan01', 'ASIC-WHI-39', 'White / Pure Gold / Silver', '#CFD8DC', '39', 3300, 5500, 4950, 5, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvs', 'asicsgelkayan01', 'ASIC-WHI-40', 'White / Pure Gold / Silver', '#CFD8DC', '40', 3300, 5500, 4950, 12, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvt', 'asicsgelkayan01', 'ASIC-WHI-41', 'White / Pure Gold / Silver', '#CFD8DC', '41', 3300, 5500, 4950, 13, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvu', 'asicsgelkayan01', 'ASIC-WHI-42', 'White / Pure Gold / Silver', '#CFD8DC', '42', 3300, 5500, 4950, 14, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvv', 'asicsgelkayan01', 'ASIC-WHI-43', 'White / Pure Gold / Silver', '#CFD8DC', '43', 3300, 5500, 4950, 15, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvw', 'asicsgelkayan01', 'ASIC-WHI-44', 'White / Pure Gold / Silver', '#CFD8DC', '44', 3300, 5500, 4950, 16, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0x1jzvx', 'asicsgelkayan01', 'ASIC-WHI-45', 'White / Pure Gold / Silver', '#CFD8DC', '45', 3300, 5500, 4950, 17, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf5d', 'asicsgelkayan01', 'ASIC-CRE-36', 'Cream / Metallic Plum', '#D7CCC8', '36', 3300, 5500, 4950, 12, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf5e', 'asicsgelkayan01', 'ASIC-CRE-37', 'Cream / Metallic Plum', '#D7CCC8', '37', 3300, 5500, 4950, 13, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf5f', 'asicsgelkayan01', 'ASIC-CRE-38', 'Cream / Metallic Plum', '#D7CCC8', '38', 3300, 5500, 4950, 14, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf5g', 'asicsgelkayan01', 'ASIC-CRE-39', 'Cream / Metallic Plum', '#D7CCC8', '39', 3300, 5500, 4950, 15, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf62', 'asicsgelkayan01', 'ASIC-CRE-40', 'Cream / Metallic Plum', '#D7CCC8', '40', 3300, 5500, 4950, 7, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf63', 'asicsgelkayan01', 'ASIC-CRE-41', 'Cream / Metallic Plum', '#D7CCC8', '41', 3300, 5500, 4950, 8, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf64', 'asicsgelkayan01', 'ASIC-CRE-42', 'Cream / Metallic Plum', '#D7CCC8', '42', 3300, 5500, 4950, 9, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf65', 'asicsgelkayan01', 'ASIC-CRE-43', 'Cream / Metallic Plum', '#D7CCC8', '43', 3300, 5500, 4950, 10, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf66', 'asicsgelkayan01', 'ASIC-CRE-44', 'Cream / Metallic Plum', '#D7CCC8', '44', 3300, 5500, 4950, 11, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('asicsgel0kyuf67', 'asicsgelkayan01', 'ASIC-CRE-45', 'Cream / Metallic Plum', '#D7CCC8', '45', 3300, 5500, 4950, 12, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm74', 'prod_asics_1130', 'ASIC-WHI-36', 'White / Shark Skin', '#ECEFF1', '36', 2300, 3900, 3510, 9, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm73', 'prod_asics_1130', 'ASIC-WHI-37', 'White / Shark Skin', '#ECEFF1', '37', 2300, 3900, 3510, 8, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm72', 'prod_asics_1130', 'ASIC-WHI-38', 'White / Shark Skin', '#ECEFF1', '38', 2300, 3900, 3510, 7, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm71', 'prod_asics_1130', 'ASIC-WHI-39', 'White / Shark Skin', '#ECEFF1', '39', 2300, 3900, 3510, 6, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6f', 'prod_asics_1130', 'ASIC-WHI-40', 'White / Shark Skin', '#ECEFF1', '40', 2300, 3900, 3510, 14, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6e', 'prod_asics_1130', 'ASIC-WHI-41', 'White / Shark Skin', '#ECEFF1', '41', 2300, 3900, 3510, 13, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6d', 'prod_asics_1130', 'ASIC-WHI-42', 'White / Shark Skin', '#ECEFF1', '42', 2300, 3900, 3510, 12, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6c', 'prod_asics_1130', 'ASIC-WHI-43', 'White / Shark Skin', '#ECEFF1', '43', 2300, 3900, 3510, 11, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6b', 'prod_asics_1130', 'ASIC-WHI-44', 'White / Shark Skin', '#ECEFF1', '44', 2300, 3900, 3510, 10, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic017xm6a', 'prod_asics_1130', 'ASIC-WHI-45', 'White / Shark Skin', '#ECEFF1', '45', 2300, 3900, 3510, 9, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feouo', 'prod_asics_1130', 'ASIC-GLA-36', 'Glacier Grey', '#90A4AE', '36', 2300, 3900, 3510, 14, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feoup', 'prod_asics_1130', 'ASIC-GLA-37', 'Glacier Grey', '#90A4AE', '37', 2300, 3900, 3510, 15, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feouq', 'prod_asics_1130', 'ASIC-GLA-38', 'Glacier Grey', '#90A4AE', '38', 2300, 3900, 3510, 16, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feour', 'prod_asics_1130', 'ASIC-GLA-39', 'Glacier Grey', '#90A4AE', '39', 2300, 3900, 3510, 17, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feovd', 'prod_asics_1130', 'ASIC-GLA-40', 'Glacier Grey', '#90A4AE', '40', 2300, 3900, 3510, 9, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feove', 'prod_asics_1130', 'ASIC-GLA-41', 'Glacier Grey', '#90A4AE', '41', 2300, 3900, 3510, 10, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feovf', 'prod_asics_1130', 'ASIC-GLA-42', 'Glacier Grey', '#90A4AE', '42', 2300, 3900, 3510, 11, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feovg', 'prod_asics_1130', 'ASIC-GLA-43', 'Glacier Grey', '#90A4AE', '43', 2300, 3900, 3510, 12, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feovh', 'prod_asics_1130', 'ASIC-GLA-44', 'Glacier Grey', '#90A4AE', '44', 2300, 3900, 3510, 13, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodasic07feovi', 'prod_asics_1130', 'ASIC-GLA-45', 'Glacier Grey', '#90A4AE', '45', 2300, 3900, 3510, 14, '/images/products/asics_gel_kayano.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs089l', 'prod_tiger_mex66', 'ONIT-WHI-36', 'White / Blue / Red', '#EEEEEE', '36', 2900, 4900, 4410, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs089m', 'prod_tiger_mex66', 'ONIT-WHI-37', 'White / Blue / Red', '#EEEEEE', '37', 2900, 4900, 4410, 9, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs089n', 'prod_tiger_mex66', 'ONIT-WHI-38', 'White / Blue / Red', '#EEEEEE', '38', 2900, 4900, 4410, 10, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs089o', 'prod_tiger_mex66', 'ONIT-WHI-39', 'White / Blue / Red', '#EEEEEE', '39', 2900, 4900, 4410, 11, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08aa', 'prod_tiger_mex66', 'ONIT-WHI-40', 'White / Blue / Red', '#EEEEEE', '40', 2900, 4900, 4410, 18, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08ab', 'prod_tiger_mex66', 'ONIT-WHI-41', 'White / Blue / Red', '#EEEEEE', '41', 2900, 4900, 4410, 19, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08ac', 'prod_tiger_mex66', 'ONIT-WHI-42', 'White / Blue / Red', '#EEEEEE', '42', 2900, 4900, 4410, 5, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08ad', 'prod_tiger_mex66', 'ONIT-WHI-43', 'White / Blue / Red', '#EEEEEE', '43', 2900, 4900, 4410, 6, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08ae', 'prod_tiger_mex66', 'ONIT-WHI-44', 'White / Blue / Red', '#EEEEEE', '44', 2900, 4900, 4410, 7, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0hs08af', 'prod_tiger_mex66', 'ONIT-WHI-45', 'White / Blue / Red', '#EEEEEE', '45', 2900, 4900, 4410, 8, '/images/products/adidas_samba_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btlz', 'prod_tiger_mex66', 'ONIT-YEL-36', 'Yellow / Black', '#FBC02D', '36', 2900, 4900, 4410, 13, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btly', 'prod_tiger_mex66', 'ONIT-YEL-37', 'Yellow / Black', '#FBC02D', '37', 2900, 4900, 4410, 12, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btlx', 'prod_tiger_mex66', 'ONIT-YEL-38', 'Yellow / Black', '#FBC02D', '38', 2900, 4900, 4410, 11, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btlw', 'prod_tiger_mex66', 'ONIT-YEL-39', 'Yellow / Black', '#FBC02D', '39', 2900, 4900, 4410, 10, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btla', 'prod_tiger_mex66', 'ONIT-YEL-40', 'Yellow / Black', '#FBC02D', '40', 2900, 4900, 4410, 18, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btl9', 'prod_tiger_mex66', 'ONIT-YEL-41', 'Yellow / Black', '#FBC02D', '41', 2900, 4900, 4410, 17, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btl8', 'prod_tiger_mex66', 'ONIT-YEL-42', 'Yellow / Black', '#FBC02D', '42', 2900, 4900, 4410, 16, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btl7', 'prod_tiger_mex66', 'ONIT-YEL-43', 'Yellow / Black', '#FBC02D', '43', 2900, 4900, 4410, 15, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btl6', 'prod_tiger_mex66', 'ONIT-YEL-44', 'Yellow / Black', '#FBC02D', '44', 2900, 4900, 4410, 14, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodtige0o3btl5', 'prod_tiger_mex66', 'ONIT-YEL-45', 'Yellow / Black', '#FBC02D', '45', 2900, 4900, 4410, 0, '/images/products/puma_suede_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld414', 'prod_salomon_xt6', 'SALO-BLA-36', 'Black / Phantom', '#212121', '36', 4400, 7200, 6480, 18, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld413', 'prod_salomon_xt6', 'SALO-BLA-37', 'Black / Phantom', '#212121', '37', 4400, 7200, 6480, 17, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld412', 'prod_salomon_xt6', 'SALO-BLA-38', 'Black / Phantom', '#212121', '38', 4400, 7200, 6480, 16, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld411', 'prod_salomon_xt6', 'SALO-BLA-39', 'Black / Phantom', '#212121', '39', 4400, 7200, 6480, 15, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40f', 'prod_salomon_xt6', 'SALO-BLA-40', 'Black / Phantom', '#212121', '40', 4400, 7200, 6480, 8, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40e', 'prod_salomon_xt6', 'SALO-BLA-41', 'Black / Phantom', '#212121', '41', 4400, 7200, 6480, 7, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40d', 'prod_salomon_xt6', 'SALO-BLA-42', 'Black / Phantom', '#212121', '42', 4400, 7200, 6480, 6, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40c', 'prod_salomon_xt6', 'SALO-BLA-43', 'Black / Phantom', '#212121', '43', 4400, 7200, 6480, 5, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40b', 'prod_salomon_xt6', 'SALO-BLA-44', 'Black / Phantom', '#212121', '44', 4400, 7200, 6480, 19, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo0pld40a', 'prod_salomon_xt6', 'SALO-BLA-45', 'Black / Phantom', '#212121', '45', 4400, 7200, 6480, 0, '/images/products/nike_af1_black.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqvp', 'prod_salomon_xt6', 'SALO-VAN-36', 'Vanilla Ice / White', '#FFF9C4', '36', 4400, 7200, 6480, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqvq', 'prod_salomon_xt6', 'SALO-VAN-37', 'Vanilla Ice / White', '#FFF9C4', '37', 4400, 7200, 6480, 13, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqvr', 'prod_salomon_xt6', 'SALO-VAN-38', 'Vanilla Ice / White', '#FFF9C4', '38', 4400, 7200, 6480, 14, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqvs', 'prod_salomon_xt6', 'SALO-VAN-39', 'Vanilla Ice / White', '#FFF9C4', '39', 4400, 7200, 6480, 15, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwe', 'prod_salomon_xt6', 'SALO-VAN-40', 'Vanilla Ice / White', '#FFF9C4', '40', 4400, 7200, 6480, 7, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwf', 'prod_salomon_xt6', 'SALO-VAN-41', 'Vanilla Ice / White', '#FFF9C4', '41', 4400, 7200, 6480, 8, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwg', 'prod_salomon_xt6', 'SALO-VAN-42', 'Vanilla Ice / White', '#FFF9C4', '42', 4400, 7200, 6480, 9, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwh', 'prod_salomon_xt6', 'SALO-VAN-43', 'Vanilla Ice / White', '#FFF9C4', '43', 4400, 7200, 6480, 10, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwi', 'prod_salomon_xt6', 'SALO-VAN-44', 'Vanilla Ice / White', '#FFF9C4', '44', 4400, 7200, 6480, 11, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
INSERT INTO public.product_variants (id, product, sku, color, color_code, size, cost_price, selling_price, sale_price, stock_quantity, image_url, status, created_at, updated_at)
VALUES ('prodsalo09vkqwj', 'prod_salomon_xt6', 'SALO-VAN-45', 'Vanilla Ice / White', '#FFF9C4', '45', 4400, 7200, 6480, 12, '/images/products/nike_af1_white.jpg', 'active', NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET stock_quantity = EXCLUDED.stock_quantity, selling_price = EXCLUDED.selling_price, image_url = EXCLUDED.image_url;
