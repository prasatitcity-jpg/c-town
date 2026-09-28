// pb_hooks/05_admin_api.pb.js
// Admin Dashboard Analytics, Order Processing, and Status Pipeline

// 1. Dashboard real statistics & summary
function handleAdminDashboard(c) {
    try {
        const info = c.requestInfo();
        if (!info.auth || info.auth.get("role") !== "ADMIN") {
            return c.json(403, { success: false, message: "สิทธิ์การเข้าถึงเฉพาะแอดมินเท่านั้น" });
        }

        const now = new Date();
        const todayStr = now.toISOString().slice(0, 10);
        const monthPrefix = todayStr.slice(0, 7); // YYYY-MM

        // Fetch all orders
        const orders = $app.findRecordsByFilter("orders", "1=1", "-id", 1000);
        let todaySales = 0;
        let monthSales = 0;
        let totalRevenue = 0;
        let pendingOrdersCount = 0;
        let awaitingVerificationCount = 0;

        const recentOrders = [];
        for (let i = 0; i < orders.length; i++) {
            const o = orders[i];
            const createdStr = (o.created || "").slice(0, 10);
            const total = Number(o.get("grand_total")) || 0;
            const pStatus = o.get("payment_status");
            const oStatus = o.get("order_status");

            if (oStatus !== "cancelled") {
                totalRevenue += total;
                if (createdStr === todayStr) todaySales += total;
                if (createdStr.startsWith(monthPrefix)) monthSales += total;
            }

            if (oStatus === "pending_payment") pendingOrdersCount++;
            if (oStatus === "awaiting_verification" || pStatus === "awaiting_verification") awaitingVerificationCount++;

            if (i < 10) {
                let shipAddr = o.get("shipping_address_snapshot") || o.get("shipping_address");
                if (typeof shipAddr === "string") {
                    try { shipAddr = JSON.parse(shipAddr); } catch (_) {}
                }
                const createdDate = o.getString("created") || o.get("created");
                recentOrders.push({
                    id: o.id,
                    order_number: o.get("order_number"),
                    grand_total: total,
                    order_status: oStatus,
                    payment_status: pStatus,
                    created: createdDate,
                    shipping_address: shipAddr,
                    shipping_address_snapshot: shipAddr,
                });
            }
        }

        // Inventory metrics
        const variants = $app.findRecordsByFilter("product_variants", "1=1", "", 1000);
        let totalVariantsCount = variants.length;
        let lowStockCount = 0;
        let outOfStockCount = 0;
        let totalStockUnits = 0;
        const lowStockVariants = [];

        for (const v of variants) {
            const stock = Number(v.get("stock_quantity")) || 0;
            totalStockUnits += stock;
            if (stock === 0) {
                outOfStockCount++;
                if (lowStockVariants.length < 10) {
                    lowStockVariants.push({
                        id: v.id,
                        sku: v.get("sku"),
                        color: v.get("color"),
                        size: v.get("size"),
                        stock_quantity: stock,
                    });
                }
            } else if (stock <= 5) {
                lowStockCount++;
                if (lowStockVariants.length < 10) {
                    lowStockVariants.push({
                        id: v.id,
                        sku: v.get("sku"),
                        color: v.get("color"),
                        size: v.get("size"),
                        stock_quantity: stock,
                    });
                }
            }
        }

        // Customer count
        const users = $app.findRecordsByFilter("users", "role = 'CUSTOMER'", "", 1000);
        const totalCustomers = users.length;

        // Unread messages
        let unreadMessagesCount = 0;
        try {
            const convs = $app.findRecordsByFilter("conversations", "unread_admin_count > 0", "", 100);
            for (const cv of convs) {
                unreadMessagesCount += (cv.get("unread_admin_count") || 0);
            }
        } catch (_) {}

        return c.json(200, {
            success: true,
            stats: {
                total_revenue: totalRevenue,
                total_sales: totalRevenue,
                today_sales: todaySales,
                month_sales: monthSales,
                total_orders: orders.length,
                pending_orders: pendingOrdersCount,
                pending_verification_count: awaitingVerificationCount,
                awaiting_verification: awaitingVerificationCount,
                total_stock_units: totalStockUnits,
                total_variants: totalVariantsCount,
                low_stock_count: lowStockCount,
                low_stock_items: lowStockCount,
                out_of_stock_items: outOfStockCount,
                total_customers: totalCustomers,
                unread_messages: unreadMessagesCount
            },
            recent_orders: recentOrders,
            low_stock_variants: lowStockVariants
        });
    } catch (err) {
        console.log("[C-TOWN] Dashboard stats error:", err);
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
}

routerAdd("GET", "/api/ctown/admin/dashboard", handleAdminDashboard);
routerAdd("GET", "/api/ctown/admin/dashboard-stats", handleAdminDashboard);

// 2. Order status update & tracking
routerAdd("POST", "/api/ctown/admin/orders/update-status", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth || info.auth.get("role") !== "ADMIN") {
            return c.json(403, { success: false, message: "สิทธิ์การเข้าถึงเฉพาะแอดมินเท่านั้น" });
        }

        const body = info.body || {};
        const { order_id, order_status, payment_status, courier_name, tracking_number } = body;

        const orderRec = $app.findRecordById("orders", order_id);
        const oldOrderStatus = orderRec.get("order_status");

        if (order_status) orderRec.set("order_status", order_status);
        if (payment_status) orderRec.set("payment_status", payment_status);
        if (courier_name) orderRec.set("courier_name", courier_name);
        if (tracking_number) {
            orderRec.set("tracking_number", tracking_number);
            if (!orderRec.get("shipping_date")) {
                orderRec.set("shipping_date", new Date().toISOString());
            }
        }
        $app.save(orderRec);

        // Update shipment record and append shipment event
        try {
            const shipments = $app.findRecordsByFilter("shipments", `order = "${order_id}"`, "", 1);
            let shipRec;
            if (shipments.length > 0) {
                shipRec = shipments[0];
            } else {
                const shipCol = $app.findCollectionByNameOrId("shipments");
                shipRec = new Record(shipCol);
                shipRec.set("order", order_id);
            }
            if (courier_name) shipRec.set("courier_name", courier_name);
            if (tracking_number) shipRec.set("tracking_number", tracking_number);
            if (order_status) shipRec.set("status", order_status);

            // Construct valid Thai courier tracking URLs
            if (courier_name && tracking_number) {
                const cLower = courier_name.toLowerCase();
                if (cLower.includes("flash")) {
                    shipRec.set("tracking_url", `https://www.flashexpress.co.th/tracking/?se=${tracking_number}`);
                } else if (cLower.includes("kerry") || cLower.includes("kerry express") || cLower.includes("kex")) {
                    shipRec.set("tracking_url", `https://th.kerryexpress.com/th/track/?track=${tracking_number}`);
                } else if (cLower.includes("post") || cLower.includes("ems") || cLower.includes("ไปรษณีย์")) {
                    shipRec.set("tracking_url", `https://track.thailandpost.co.th/?trackNumber=${tracking_number}`);
                } else if (cLower.includes("j&t") || cLower.includes("jt")) {
                    shipRec.set("tracking_url", `https://www.jtexpress.co.th/index/query/gzquery.html?bills=${tracking_number}`);
                }
            }
            $app.save(shipRec);

            // Append event
            const eventsCol = $app.findCollectionByNameOrId("shipment_events");
            const evRec = new Record(eventsCol);
            evRec.set("shipment", shipRec.id);
            evRec.set("order", order_id);
            evRec.set("status", order_status || oldOrderStatus);
            evRec.set("description", `อัปเดตสถานะ: ${order_status || oldOrderStatus} ${tracking_number ? '(เลขพัสดุ: ' + tracking_number + ')' : ''}`);
            evRec.set("location", "C-TOWN Fulfillment Center");
            evRec.set("event_time", new Date().toISOString());
            $app.save(evRec);

        } catch (shipErr) {
            console.log("[C-TOWN] Shipment update error:", shipErr);
        }

        // Audit log
        try {
            const auditCol = $app.findCollectionByNameOrId("audit_logs");
            const auditRec = new Record(auditCol);
            auditRec.set("user_id", info.auth.id);
            auditRec.set("action", "ORDER_STATUS_UPDATE");
            auditRec.set("entity_type", "orders");
            auditRec.set("entity_id", order_id);
            auditRec.set("old_values_json", { order_status: oldOrderStatus });
            auditRec.set("new_values_json", { order_status, payment_status, tracking_number });
            $app.save(auditRec);
        } catch (_) {}

        return c.json(200, {
            success: true,
            message: "อัปเดตสถานะคำสั่งซื้อเรียบร้อยแล้ว",
            order: {
                id: orderRec.id,
                order_number: orderRec.get("order_number"),
                order_status: orderRec.get("order_status"),
                payment_status: orderRec.get("payment_status"),
                tracking_number: orderRec.get("tracking_number"),
                courier_name: orderRec.get("courier_name")
            }
        });
    } catch (err) {
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
});

// 3. Payment Slip Approval
routerAdd("POST", "/api/ctown/admin/payments/verify-slip", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth || info.auth.get("role") !== "ADMIN") {
            return c.json(403, { success: false, message: "สิทธิ์การเข้าถึงเฉพาะแอดมินเท่านั้น" });
        }

        const body = info.body || {};
        const { proof_id, action, admin_note } = body; // action: 'approve' or 'reject'

        const proofRec = $app.findRecordById("payment_proofs", proof_id);
        const orderId = proofRec.get("order");
        const orderRec = $app.findRecordById("orders", orderId);

        if (action === "approve") {
            proofRec.set("status", "approved");
            proofRec.set("admin_note", admin_note || "ตรวจสอบยอดเงินและสลิปถูกต้องเรียบร้อยแล้ว");
            proofRec.set("verified_by", info.auth.id);
            $app.save(proofRec);

            orderRec.set("payment_status", "paid");
            orderRec.set("order_status", "paid");
            $app.save(orderRec);
        } else if (action === "reject") {
            proofRec.set("status", "rejected");
            proofRec.set("admin_note", admin_note || "หลักฐานการโอนเงินไม่ถูกต้อง หรือยอดเงินไม่ตรง");
            proofRec.set("verified_by", info.auth.id);
            $app.save(proofRec);

            orderRec.set("payment_status", "pending");
            orderRec.set("order_status", "pending_payment");
            $app.save(orderRec);
        } else {
            return c.json(400, { success: false, message: "การกระทำ (action) ต้องเป็น approve หรือ reject" });
        }

        return c.json(200, {
            success: true,
            message: action === "approve" ? "อนุมัติหลักฐานการชำระเงินเรียบร้อยแล้ว" : "ปฏิเสธหลักฐานการชำระเงินเรียบร้อยแล้ว"
        });
    } catch (err) {
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
});
