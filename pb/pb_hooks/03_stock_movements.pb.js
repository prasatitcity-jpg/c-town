// pb_hooks/03_stock_movements.pb.js
// Stock Management, Ledger Movements, and Negative Stock Prevention

routerAdd("POST", "/api/ctown/stock/movement", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth || info.auth.get("role") !== "ADMIN") {
            return c.json(403, {
                success: false,
                message: "ต้องใช้สิทธิ์ผู้ดูแลระบบ (ADMIN) เพื่อจัดการสต็อกสินค้า"
            });
        }

        const body = info.body || {};
        const { variant_id, movement_type, quantity, unit_cost, supplier_id, reference_number, note } = body;

        const qty = parseInt(quantity, 10);
        if (isNaN(qty) || qty <= 0) {
            return c.json(400, { success: false, message: "จำนวนสินค้าต้องเป็นตัวเลขที่มากกว่า 0" });
        }

        const validTypes = [
            "PURCHASE_IN", "SALE_OUT", "CUSTOMER_RETURN_IN",
            "DAMAGE_OUT", "ADJUSTMENT_IN", "ADJUSTMENT_OUT", "RETURN_TO_SUPPLIER"
        ];
        if (!validTypes.includes(movement_type)) {
            return c.json(400, { success: false, message: "ประเภทการเคลื่อนไหวสต็อกไม่ถูกต้อง" });
        }

        const isIncoming = ["PURCHASE_IN", "CUSTOMER_RETURN_IN", "ADJUSTMENT_IN"].includes(movement_type);
        const isOutgoing = ["SALE_OUT", "DAMAGE_OUT", "ADJUSTMENT_OUT", "RETURN_TO_SUPPLIER"].includes(movement_type);

        let variantRec;
        try {
            variantRec = $app.findRecordById("product_variants", variant_id);
        } catch (_) {
            return c.json(404, { success: false, message: "ไม่พบข้อมูล Variant สินค้านี้ในระบบ" });
        }

        const currentStock = variantRec.get("stock_quantity") || 0;

        // Prevent negative stock
        if (isOutgoing && currentStock < qty) {
            return c.json(400, {
                success: false,
                message: `ไม่สามารถตัดสต็อกออกได้ เนื่องจากสต็อกคงเหลือ (${currentStock} คู่) น้อยกว่าจำนวนที่ต้องการตัด (${qty} คู่)`
            });
        }

        const newStock = isIncoming ? currentStock + qty : currentStock - qty;

        $app.runInTransaction((txApp) => {
            const movementsCol = txApp.findCollectionByNameOrId("stock_movements");
            const auditCol = txApp.findCollectionByNameOrId("audit_logs");

            // Update variant
            variantRec.set("stock_quantity", newStock);
            if (newStock <= 0) {
                variantRec.set("status", "out_of_stock");
            } else if (variantRec.get("status") === "out_of_stock") {
                variantRec.set("status", "active");
            }
            txApp.save(variantRec);

            // Record movement
            const movRec = new Record(movementsCol);
            movRec.set("sku", variantRec.get("sku"));
            movRec.set("product", variantRec.get("product"));
            movRec.set("variant", variantRec.id);
            movRec.set("movement_type", movement_type);
            movRec.set("quantity", qty);
            if (unit_cost) movRec.set("unit_cost", parseFloat(unit_cost));
            if (supplier_id) movRec.set("supplier", supplier_id);
            movRec.set("reference_number", reference_number || "");
            movRec.set("note", note || "");
            movRec.set("created_by", info.auth.id);
            txApp.save(movRec);

            // Audit log
            try {
                const auditRec = new Record(auditCol);
                auditRec.set("user_id", info.auth.id);
                auditRec.set("action", "STOCK_MOVEMENT_" + movement_type);
                auditRec.set("entity_type", "product_variants");
                auditRec.set("entity_id", variantRec.id);
                auditRec.set("old_values_json", { stock_quantity: currentStock });
                auditRec.set("new_values_json", { stock_quantity: newStock, delta: isIncoming ? qty : -qty });
                txApp.save(auditRec);
            } catch (_) {}
        });

        return c.json(200, {
            success: true,
            message: `บันทึกการเคลื่อนไหวสต็อก (${movement_type}) เรียบร้อยแล้ว`,
            variant: {
                id: variantRec.id,
                sku: variantRec.get("sku"),
                old_stock: currentStock,
                new_stock: newStock
            }
        });
    } catch (err) {
        console.log("[C-TOWN] Stock movement error:", err);
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
});
