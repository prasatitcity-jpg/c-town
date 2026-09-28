// pb_hooks/04_coupons.pb.js
// Coupon validation and discount calculations

routerAdd("POST", "/api/ctown/coupons/validate", (c) => {
    try {
        const info = c.requestInfo();
        const body = info.body || {};
        const { code, subtotal } = body;
        const userId = info.auth ? info.auth.id : null;

        if (!code || !code.trim()) {
            return c.json(400, { success: false, message: "กรุณาระบุรหัสคูปอง" });
        }

        const cleanCode = code.trim().toUpperCase();
        const coupons = $app.findRecordsByFilter("coupons", `code = "${cleanCode}" && status = "active"`, "", 1);

        if (coupons.length === 0) {
            return c.json(404, { success: false, message: "ไม่พบรหัสคูปองส่วนลดนี้ หรือคูปองหมดอายุแล้ว" });
        }

        const cp = coupons[0];
        const numSubtotal = parseFloat(subtotal) || 0;
        const minPurchase = cp.get("min_purchase") || 0;
        const maxDiscount = cp.get("max_discount") || 999999;
        const usageLimit = cp.get("usage_limit") || 999999;
        const timesUsed = cp.get("times_used") || 0;
        const usagePerCust = cp.get("usage_per_customer") || 1;

        // Date check
        const nowStr = new Date().toISOString().slice(0, 10);
        const startDate = cp.get("start_date");
        const expiryDate = cp.get("expiry_date");

        if (startDate && nowStr < startDate) {
            return c.json(400, { success: false, message: "คูปองนี้ยังไม่ถึงระยะเวลาการใช้งาน" });
        }
        if (expiryDate && nowStr > expiryDate) {
            return c.json(400, { success: false, message: "คูปองส่วนลดนี้หมดอายุแล้ว" });
        }

        if (timesUsed >= usageLimit) {
            return c.json(400, { success: false, message: "คูปองส่วนลดนี้ถูกใช้ครบสิทธิ์ทั้งหมดแล้ว" });
        }

        if (numSubtotal < minPurchase) {
            return c.json(400, {
                success: false,
                message: `คูปองนี้ใช้ได้เมื่อมียอดสั่งซื้อขั้นต่ำ ${minPurchase.toLocaleString()} บาท (ยอดปัจจุบัน ${numSubtotal.toLocaleString()} บาท)`
            });
        }

        if (userId) {
            const usages = $app.findRecordsByFilter("coupon_usages", `coupon = "${cp.id}" && user = "${userId}"`, "", 100);
            if (usages.length >= usagePerCust) {
                return c.json(400, {
                    success: false,
                    message: `คุณได้ใช้สิทธิ์คูปองนี้ครบตามที่กำหนดแล้ว (${usagePerCust} ครั้ง)`
                });
            }
        }

        const discType = cp.get("discount_type");
        const discVal = cp.get("discount_value") || 0;
        let discountAmount = 0;
        let description = "";

        if (discType === "fixed") {
            discountAmount = Math.min(discVal, numSubtotal);
            description = `ส่วนลดเงินสด ${discVal.toLocaleString()} บาท`;
        } else if (discType === "percent") {
            const raw = Math.round((numSubtotal * discVal) / 100);
            discountAmount = Math.min(raw, maxDiscount);
            description = `ส่วนลด ${discVal}% (สูงสุด ${maxDiscount.toLocaleString()} บาท)`;
        } else if (discType === "free_shipping") {
            discountAmount = 60; // Standard shipping discount
            description = "คูปองฟรีค่าจัดส่ง 60 บาท";
        }

        return c.json(200, {
            success: true,
            valid: true,
            coupon: {
                id: cp.id,
                code: cp.get("code"),
                discount_type: discType,
                discount_value: discVal,
                discount_amount: discountAmount,
                description: description
            }
        });
    } catch (err) {
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
});
