// pb_hooks/02_orders_checkout.pb.js
// Transactional Checkout, Order Snapshotting, and Stock Ledger Automation

routerAdd("POST", "/api/ctown/checkout", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth) {
            return c.json(401, {
                success: false,
                message: "กรุณาเข้าสู่ระบบก่อนทำการสั่งซื้อ"
            });
        }

        const user = info.auth;
        const body = info.body || {};
        const { items, shipping_address, coupon_code, payment_method, notes } = body;

        if (!items || !Array.isArray(items) || items.length === 0) {
            return c.json(400, {
                success: false,
                message: "ไม่มีรายการสินค้าในคำสั่งซื้อ"
            });
        }

        if (!shipping_address || !shipping_address.recipient_name || !shipping_address.phone || !shipping_address.address_line || !shipping_address.province || !shipping_address.postal_code) {
            return c.json(400, {
                success: false,
                message: "กรุณากรอกข้อมูลที่อยู่จัดส่งให้ครบถ้วน"
            });
        }

        // Fetch store settings for shipping configuration
        let defaultShippingFee = 60;
        let freeShippingMin = 2500;
        try {
            const settings = $app.findRecordsByFilter("store_settings", "1=1", "", 1);
            if (settings.length > 0) {
                defaultShippingFee = settings[0].get("default_shipping_fee") || 60;
                freeShippingMin = settings[0].get("free_shipping_min_order") || 2500;
            }
        } catch (_) {}

        // Fetch and validate variants and stock
        const variantsCol = $app.findCollectionByNameOrId("product_variants");
        const productsCol = $app.findCollectionByNameOrId("products");
        const validatedItems = [];
        let subtotal = 0;

        for (const item of items) {
            if (!item.variant_id || !item.quantity || item.quantity <= 0) {
                return c.json(400, { success: false, message: "ข้อมูลสินค้าในตะกร้าไม่ถูกต้อง" });
            }

            let variantRec;
            try {
                variantRec = $app.findRecordById("product_variants", item.variant_id);
            } catch (_) {
                return c.json(400, { success: false, message: "ไม่พบข้อมูลสินค้าที่เลือกในระบบ" });
            }

            const currentStock = variantRec.get("stock_quantity") || 0;
            if (currentStock < item.quantity) {
                return c.json(400, {
                    success: false,
                    message: `สินค้าไซซ์ ${variantRec.get("size")} สี ${variantRec.get("color")} มีคงเหลือไม่พอ (คงเหลือ: ${currentStock} คู่)`
                });
            }

            let productRec;
            try {
                productRec = $app.findRecordById("products", variantRec.get("product"));
            } catch (_) {}

            const unitPrice = variantRec.get("sale_price") || variantRec.get("selling_price");
            const lineTotal = unitPrice * item.quantity;
            subtotal += lineTotal;

            validatedItems.push({
                variant: variantRec,
                product: productRec,
                quantity: item.quantity,
                unitPrice: unitPrice,
                lineTotal: lineTotal
            });
        }

        // Validate coupon if provided
        let discountAmount = 0;
        let couponRec = null;
        let isFreeShippingCoupon = false;

        if (coupon_code && coupon_code.trim()) {
            const cleanCode = coupon_code.trim().toUpperCase();
            try {
                const coupons = $app.findRecordsByFilter("coupons", `code = "${cleanCode}" && status = "active"`, "", 1);
                if (coupons.length > 0) {
                    const cp = coupons[0];
                    const minPurchase = cp.get("min_purchase") || 0;
                    const maxDiscount = cp.get("max_discount") || 999999;
                    const usageLimit = cp.get("usage_limit") || 999999;
                    const timesUsed = cp.get("times_used") || 0;
                    const usagePerCust = cp.get("usage_per_customer") || 1;

                    // Date check
                    const nowStr = new Date().toISOString().slice(0, 10);
                    const startDate = cp.get("start_date");
                    const expiryDate = cp.get("expiry_date");

                    let dateValid = true;
                    if (startDate && nowStr < startDate) dateValid = false;
                    if (expiryDate && nowStr > expiryDate) dateValid = false;

                    if (!dateValid) {
                        return c.json(400, { success: false, message: "คูปองส่วนลดนี้หมดอายุแล้วหรือไม่สามารถใช้งานได้ในขณะนี้" });
                    }

                    if (timesUsed >= usageLimit) {
                        return c.json(400, { success: false, message: "คูปองส่วนลดนี้ถูกใช้ครบสิทธิ์ทั้งหมดแล้ว" });
                    }

                    if (subtotal < minPurchase) {
                        return c.json(400, { success: false, message: `คูปองนี้ใช้ได้เมื่อมียอดสั่งซื้อขั้นต่ำ ${minPurchase.toLocaleString()} บาท` });
                    }

                    // Check customer usage count
                    const userUsages = $app.findRecordsByFilter("coupon_usages", `coupon = "${cp.id}" && user = "${user.id}"`, "", 100);
                    if (userUsages.length >= usagePerCust) {
                        return c.json(400, { success: false, message: `คุณได้ใช้สิทธิ์คูปองนี้ครบตามที่กำหนดแล้ว (${usagePerCust} ครั้ง)` });
                    }

                    // Calculate discount
                    const discType = cp.get("discount_type");
                    const discVal = cp.get("discount_value") || 0;

                    if (discType === "fixed") {
                        discountAmount = Math.min(discVal, subtotal);
                    } else if (discType === "percent") {
                        const calculated = Math.round((subtotal * discVal) / 100);
                        discountAmount = Math.min(calculated, maxDiscount);
                    } else if (discType === "free_shipping") {
                        isFreeShippingCoupon = true;
                    }

                    couponRec = cp;
                } else {
                    return c.json(400, { success: false, message: "รหัสคูปองส่วนลดไม่ถูกต้อง" });
                }
            } catch (couponErr) {
                console.log("[C-TOWN] Coupon validation error:", couponErr);
            }
        }

        // Calculate shipping fee
        let shippingFee = defaultShippingFee;
        if (subtotal >= freeShippingMin || isFreeShippingCoupon) {
            shippingFee = 0;
        }

        const grandTotal = Math.max(0, subtotal - discountAmount + shippingFee);

        // Generate Order ID: CT-ORD-YYYYMMDD-XXXX
        const now = new Date();
        const yyyymmdd = now.toISOString().slice(0, 10).replace(/-/g, "");
        const randomSuffix = Math.floor(1000 + Math.random() * 9000);
        const orderNumber = `CT-ORD-${yyyymmdd}-${randomSuffix}`;

        let createdOrderId = "";

        // Execute atomic transaction
        $app.runInTransaction((txApp) => {
            const ordersCol = txApp.findCollectionByNameOrId("orders");
            const orderItemsCol = txApp.findCollectionByNameOrId("order_items");
            const movementsCol = txApp.findCollectionByNameOrId("stock_movements");
            const shipmentsCol = txApp.findCollectionByNameOrId("shipments");
            const eventsCol = txApp.findCollectionByNameOrId("shipment_events");
            const auditCol = txApp.findCollectionByNameOrId("audit_logs");

            // 1. Create order
            const orderRec = new Record(ordersCol);
            orderRec.set("order_number", orderNumber);
            orderRec.set("user", user.id);
            orderRec.set("shipping_address_snapshot", shipping_address);
            orderRec.set("subtotal", subtotal);
            orderRec.set("discount_amount", discountAmount);
            if (couponRec) orderRec.set("coupon", couponRec.id);
            orderRec.set("shipping_fee", shippingFee);
            orderRec.set("grand_total", grandTotal);
            orderRec.set("payment_method", payment_method || "bank_transfer");
            orderRec.set("payment_status", "pending");
            orderRec.set("order_status", "pending_payment");
            orderRec.set("notes", notes || "");
            txApp.save(orderRec);
            createdOrderId = orderRec.id;

            // 2. Create order items and decrement stock
            for (const it of validatedItems) {
                const itemRec = new Record(orderItemsCol);
                itemRec.set("order", orderRec.id);
                itemRec.set("variant", it.variant.id);
                itemRec.set("product_id", it.product ? it.product.id : "");
                itemRec.set("product_name_snapshot", it.product ? it.product.get("name") : "Sneaker");
                itemRec.set("sku", it.variant.get("sku"));
                itemRec.set("color", it.variant.get("color"));
                itemRec.set("size", it.variant.get("size"));
                itemRec.set("quantity", it.quantity);
                itemRec.set("unit_price", it.unitPrice);
                itemRec.set("line_total", it.lineTotal);
                itemRec.set("image_snapshot", it.variant.get("image_url") || "");
                txApp.save(itemRec);

                // Decrement stock
                const currentQty = it.variant.get("stock_quantity") || 0;
                const newQty = currentQty - it.quantity;
                const soldQty = (it.variant.get("sold_quantity") || 0) + it.quantity;
                it.variant.set("stock_quantity", newQty);
                it.variant.set("sold_quantity", soldQty);
                if (newQty <= 0) {
                    it.variant.set("status", "out_of_stock");
                }
                txApp.save(it.variant);

                // Record stock movement: SALE_OUT
                const movRec = new Record(movementsCol);
                movRec.set("sku", it.variant.get("sku"));
                movRec.set("product", it.product ? it.product.id : "");
                movRec.set("variant", it.variant.id);
                movRec.set("movement_type", "SALE_OUT");
                movRec.set("quantity", it.quantity);
                movRec.set("unit_cost", it.variant.get("cost_price") || 0);
                movRec.set("reference_number", orderNumber);
                movRec.set("note", `Sale Order ${orderNumber}`);
                movRec.set("created_by", user.id);
                txApp.save(movRec);
            }

            // 3. Record coupon usage
            if (couponRec) {
                const usagesCol = txApp.findCollectionByNameOrId("coupon_usages");
                const usageRec = new Record(usagesCol);
                usageRec.set("coupon", couponRec.id);
                usageRec.set("user", user.id);
                usageRec.set("order_id", orderRec.id);
                usageRec.set("discount_amount", discountAmount);
                usageRec.set("used_at", new Date().toISOString());
                txApp.save(usageRec);

                couponRec.set("times_used", (couponRec.get("times_used") || 0) + 1);
                txApp.save(couponRec);
            }

            // 4. Create shipment and initial event
            const shipRec = new Record(shipmentsCol);
            shipRec.set("order", orderRec.id);
            shipRec.set("status", "pending_payment");
            txApp.save(shipRec);

            const evRec = new Record(eventsCol);
            evRec.set("shipment", shipRec.id);
            evRec.set("order", orderRec.id);
            evRec.set("status", "pending_payment");
            evRec.set("description", "คำสั่งซื้อถูกสร้างในระบบเรียบร้อยแล้ว รอการชำระเงิน");
            evRec.set("location", "C-TOWN Fulfillment Center");
            evRec.set("event_time", new Date().toISOString());
            txApp.save(evRec);

            // 5. Clean customer's cart
            try {
                const cartItems = txApp.findRecordsByFilter("cart_items", `user = "${user.id}"`, "", 100);
                for (const ci of cartItems) {
                    txApp.delete(ci);
                }
            } catch (_) {}

            // 6. Audit log
            try {
                const auditRec = new Record(auditCol);
                auditRec.set("user_id", user.id);
                auditRec.set("action", "ORDER_CREATED");
                auditRec.set("entity_type", "orders");
                auditRec.set("entity_id", orderRec.id);
                auditRec.set("new_values_json", {
                    order_number: orderNumber,
                    grand_total: grandTotal,
                    items_count: validatedItems.length
                });
                txApp.save(auditRec);
            } catch (_) {}
        });

        // Return order info
        const finalOrder = $app.findRecordById("orders", createdOrderId);
        return c.json(200, {
            success: true,
            message: "สร้างคำสั่งซื้อสำเร็จเรียบร้อยแล้ว",
            order: {
                id: finalOrder.id,
                order_number: finalOrder.get("order_number"),
                subtotal: finalOrder.get("subtotal"),
                discount_amount: finalOrder.get("discount_amount"),
                shipping_fee: finalOrder.get("shipping_fee"),
                grand_total: finalOrder.get("grand_total"),
                payment_method: finalOrder.get("payment_method"),
                payment_status: finalOrder.get("payment_status"),
                order_status: finalOrder.get("order_status"),
                shipping_address: shipping_address,
                created: finalOrder.created
            }
        });

    } catch (err) {
        console.log("[C-TOWN] Checkout error:", err);
        return c.json(500, {
            success: false,
            message: "เกิดข้อผิดพลาดในการประมวลผลคำสั่งซื้อ: " + String(err)
        });
    }
});
