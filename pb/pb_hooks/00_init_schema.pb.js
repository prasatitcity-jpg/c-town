// pb_hooks/00_init_schema.pb.js
// Automatic schema migration and seeding for C-TOWN SNEAKER STORE

onBootstrap((e) => {
    e.next();
    console.log("[C-TOWN] Checking database schema...");

    // Helper to find or create collection
    function ensureCollection(name, type, configureFields, listRule, viewRule, createRule, updateRule, deleteRule) {
        let col;
        try {
            col = $app.findCollectionByNameOrId(name);
        } catch (_) {}

        if (!col) {
            console.log("[C-TOWN] Creating collection:", name);
            col = new Collection({
                name: name,
                type: type || "base"
            });
            if (configureFields) {
                configureFields(col);
            }
            if (listRule !== undefined) col.listRule = listRule;
            if (viewRule !== undefined) col.viewRule = viewRule;
            if (createRule !== undefined) col.createRule = createRule;
            if (updateRule !== undefined) col.updateRule = updateRule;
            if (deleteRule !== undefined) col.deleteRule = deleteRule;
            $app.save(col);
            return $app.findCollectionByNameOrId(name);
        } else {
            // Collection exists; ensure rules are set
            let changed = false;
            if (listRule !== undefined && col.listRule !== listRule) { col.listRule = listRule; changed = true; }
            if (viewRule !== undefined && col.viewRule !== viewRule) { col.viewRule = viewRule; changed = true; }
            if (createRule !== undefined && col.createRule !== createRule) { col.createRule = createRule; changed = true; }
            if (updateRule !== undefined && col.updateRule !== updateRule) { col.updateRule = updateRule; changed = true; }
            if (deleteRule !== undefined && col.deleteRule !== deleteRule) { col.deleteRule = deleteRule; changed = true; }
            if (changed) {
                try { $app.save(col); } catch (err) { console.log("[C-TOWN] Error updating rules for", name, err); }
            }
            return col;
        }
    }

    // Helper to add field if it doesn't already exist
    function ensureField(col, fieldObj) {
        const existing = col.fields.getByName(fieldObj.name);
        if (!existing) {
            col.fields.add(fieldObj);
            return true;
        }
        return false;
    }

    try {
        // 1. Update `users` collection with role, name, phone
        const usersCol = $app.findCollectionByNameOrId("users");
        let usersChanged = false;
        if (ensureField(usersCol, new SelectField({
            name: "role",
            values: ["CUSTOMER", "ADMIN"],
            maxSelect: 1
        }))) usersChanged = true;
        if (ensureField(usersCol, new TextField({ name: "name" }))) usersChanged = true;
        if (ensureField(usersCol, new TextField({ name: "phone" }))) usersChanged = true;
        if (usersChanged) {
            $app.save(usersCol);
            console.log("[C-TOWN] Updated users collection fields.");
        }

        // 2. customer_profiles
        ensureCollection("customer_profiles", "base", (col) => {
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "full_name" }));
            col.fields.add(new TextField({ name: "phone" }));
            col.fields.add(new TextField({ name: "birthdate" }));
            col.fields.add(new TextField({ name: "gender" }));
            col.fields.add(new TextField({ name: "notes" }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.role = 'ADMIN'");

        // 3. addresses
        const addressesCol = ensureCollection("addresses", "base", (col) => {
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "recipient_name", required: true }));
            col.fields.add(new TextField({ name: "phone", required: true }));
            col.fields.add(new TextField({ name: "address_line", required: true }));
            col.fields.add(new TextField({ name: "subdistrict", required: true }));
            col.fields.add(new TextField({ name: "district", required: true }));
            col.fields.add(new TextField({ name: "province", required: true }));
            col.fields.add(new TextField({ name: "postal_code", required: true }));
            col.fields.add(new BoolField({ name: "is_default" }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')");

        // 4. admin_profiles
        ensureCollection("admin_profiles", "base", (col) => {
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "role_title" }));
            col.fields.add(new TextField({ name: "department" }));
            col.fields.add(new JSONField({ name: "permissions" }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 5. brands
        const brandsCol = ensureCollection("brands", "base", (col) => {
            col.fields.add(new TextField({ name: "name", required: true }));
            col.fields.add(new TextField({ name: "slug", required: true }));
            col.fields.add(new TextField({ name: "description" }));
            col.fields.add(new FileField({ name: "logo", maxSelect: 1 }));
            col.fields.add(new BoolField({ name: "is_active" }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 6. categories
        const categoriesCol = ensureCollection("categories", "base", (col) => {
            col.fields.add(new TextField({ name: "name", required: true }));
            col.fields.add(new TextField({ name: "slug", required: true }));
            col.fields.add(new TextField({ name: "description" }));
            col.fields.add(new FileField({ name: "image", maxSelect: 1 }));
            col.fields.add(new BoolField({ name: "is_active" }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 7. products
        const productsCol = ensureCollection("products", "base", (col) => {
            col.fields.add(new TextField({ name: "name", required: true }));
            col.fields.add(new TextField({ name: "slug", required: true }));
            col.fields.add(new RelationField({ name: "brand", collectionId: brandsCol.id, maxSelect: 1 }));
            col.fields.add(new RelationField({ name: "category", collectionId: categoriesCol.id, maxSelect: 1 }));
            col.fields.add(new TextField({ name: "description" }));
            col.fields.add(new FileField({ name: "main_image", maxSelect: 1 }));
            col.fields.add(new FileField({ name: "additional_images", maxSelect: 10 }));
            col.fields.add(new SelectField({ name: "status", values: ["active", "draft", "archived"], maxSelect: 1 }));
            col.fields.add(new BoolField({ name: "is_new" }));
            col.fields.add(new BoolField({ name: "is_bestseller" }));
            col.fields.add(new NumberField({ name: "base_price" }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 8. product_variants
        const variantsCol = ensureCollection("product_variants", "base", (col) => {
            col.fields.add(new RelationField({ name: "product", collectionId: productsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "sku", required: true }));
            col.fields.add(new TextField({ name: "barcode" }));
            col.fields.add(new TextField({ name: "color", required: true }));
            col.fields.add(new TextField({ name: "color_code" }));
            col.fields.add(new TextField({ name: "size", required: true }));
            col.fields.add(new NumberField({ name: "cost_price" }));
            col.fields.add(new NumberField({ name: "selling_price", required: true }));
            col.fields.add(new NumberField({ name: "sale_price" }));
            col.fields.add(new NumberField({ name: "stock_quantity" }));
            col.fields.add(new NumberField({ name: "sold_quantity" }));
            col.fields.add(new TextField({ name: "image_url" }));
            col.fields.add(new FileField({ name: "variant_image", maxSelect: 1 }));
            col.fields.add(new SelectField({ name: "status", values: ["active", "out_of_stock", "discontinued"], maxSelect: 1 }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 9. product_images
        ensureCollection("product_images", "base", (col) => {
            col.fields.add(new RelationField({ name: "product", collectionId: productsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "variant", collectionId: variantsCol.id, maxSelect: 1 }));
            col.fields.add(new FileField({ name: "image_file", maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "alt_text" }));
            col.fields.add(new NumberField({ name: "sort_order" }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 10. carts
        const cartsCol = ensureCollection("carts", "base", (col) => {
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new SelectField({ name: "status", values: ["active", "abandoned", "converted"], maxSelect: 1 }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')");

        // 11. cart_items
        ensureCollection("cart_items", "base", (col) => {
            col.fields.add(new RelationField({ name: "cart", collectionId: cartsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "variant", collectionId: variantsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "product", collectionId: productsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new NumberField({ name: "quantity", required: true }));
            col.fields.add(new NumberField({ name: "unit_price", required: true }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')");

        // 12. coupons
        const couponsCol = ensureCollection("coupons", "base", (col) => {
            col.fields.add(new TextField({ name: "code", required: true }));
            col.fields.add(new SelectField({ name: "discount_type", values: ["fixed", "percent", "free_shipping"], maxSelect: 1 }));
            col.fields.add(new NumberField({ name: "discount_value" }));
            col.fields.add(new NumberField({ name: "min_purchase" }));
            col.fields.add(new NumberField({ name: "max_discount" }));
            col.fields.add(new TextField({ name: "start_date" }));
            col.fields.add(new TextField({ name: "expiry_date" }));
            col.fields.add(new NumberField({ name: "usage_limit" }));
            col.fields.add(new NumberField({ name: "usage_per_customer" }));
            col.fields.add(new NumberField({ name: "times_used" }));
            col.fields.add(new SelectField({ name: "status", values: ["active", "inactive", "expired"], maxSelect: 1 }));
        }, "status = 'active' || @request.auth.role = 'ADMIN'",
           "status = 'active' || @request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 13. coupon_usages
        const couponUsagesCol = ensureCollection("coupon_usages", "base", (col) => {
            col.fields.add(new RelationField({ name: "coupon", collectionId: couponsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "order_id" }));
            col.fields.add(new NumberField({ name: "discount_amount" }));
            col.fields.add(new TextField({ name: "used_at" }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 14. orders
        const ordersCol = ensureCollection("orders", "base", (col) => {
            col.fields.add(new TextField({ name: "order_number", required: true }));
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new JSONField({ name: "shipping_address_snapshot" }));
            col.fields.add(new NumberField({ name: "subtotal" }));
            col.fields.add(new NumberField({ name: "discount_amount" }));
            col.fields.add(new RelationField({ name: "coupon", collectionId: couponsCol.id, maxSelect: 1 }));
            col.fields.add(new NumberField({ name: "shipping_fee" }));
            col.fields.add(new NumberField({ name: "grand_total", required: true }));
            col.fields.add(new SelectField({ name: "payment_method", values: ["bank_transfer", "qr_promptpay", "credit_card"], maxSelect: 1 }));
            col.fields.add(new SelectField({ name: "payment_status", values: ["pending", "awaiting_verification", "paid", "failed", "refunded"], maxSelect: 1 }));
            col.fields.add(new SelectField({ name: "order_status", values: ["pending_payment", "awaiting_verification", "paid", "preparing", "packed", "shipped", "delivered", "cancelled", "returned"], maxSelect: 1 }));
            col.fields.add(new TextField({ name: "tracking_number" }));
            col.fields.add(new TextField({ name: "courier_name" }));
            col.fields.add(new TextField({ name: "shipping_date" }));
            col.fields.add(new TextField({ name: "notes" }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 15. order_items
        ensureCollection("order_items", "base", (col) => {
            col.fields.add(new RelationField({ name: "order", collectionId: ordersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "variant", collectionId: variantsCol.id, maxSelect: 1 }));
            col.fields.add(new TextField({ name: "product_id" }));
            col.fields.add(new TextField({ name: "product_name_snapshot", required: true }));
            col.fields.add(new TextField({ name: "sku", required: true }));
            col.fields.add(new TextField({ name: "color", required: true }));
            col.fields.add(new TextField({ name: "size", required: true }));
            col.fields.add(new NumberField({ name: "quantity", required: true }));
            col.fields.add(new NumberField({ name: "unit_price", required: true }));
            col.fields.add(new NumberField({ name: "line_total", required: true }));
            col.fields.add(new TextField({ name: "image_snapshot" }));
        }, "@request.auth.id != ''",
           "@request.auth.id != ''",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 16. payments
        ensureCollection("payments", "base", (col) => {
            col.fields.add(new RelationField({ name: "order", collectionId: ordersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "payment_method" }));
            col.fields.add(new NumberField({ name: "amount" }));
            col.fields.add(new TextField({ name: "status" }));
            col.fields.add(new TextField({ name: "transaction_reference" }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 17. payment_proofs
        ensureCollection("payment_proofs", "base", (col) => {
            col.fields.add(new RelationField({ name: "order", collectionId: ordersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new FileField({ name: "slip_image", maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "transfer_bank" }));
            col.fields.add(new TextField({ name: "transfer_date" }));
            col.fields.add(new TextField({ name: "transfer_time" }));
            col.fields.add(new NumberField({ name: "transfer_amount" }));
            col.fields.add(new SelectField({ name: "status", values: ["pending", "approved", "rejected"], maxSelect: 1 }));
            col.fields.add(new TextField({ name: "admin_note" }));
            col.fields.add(new RelationField({ name: "verified_by", collectionId: usersCol.id, maxSelect: 1 }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'",
           "@request.auth.role = 'ADMIN'");

        // 18. shipments
        const shipmentsCol = ensureCollection("shipments", "base", (col) => {
            col.fields.add(new RelationField({ name: "order", collectionId: ordersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "courier_name" }));
            col.fields.add(new TextField({ name: "tracking_number" }));
            col.fields.add(new TextField({ name: "shipping_date" }));
            col.fields.add(new TextField({ name: "estimated_delivery_date" }));
            col.fields.add(new TextField({ name: "status" }));
            col.fields.add(new TextField({ name: "tracking_url" }));
        }, "@request.auth.id != ''", "@request.auth.id != ''", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 19. shipment_events
        ensureCollection("shipment_events", "base", (col) => {
            col.fields.add(new RelationField({ name: "shipment", collectionId: shipmentsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "order", collectionId: ordersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "status" }));
            col.fields.add(new TextField({ name: "description" }));
            col.fields.add(new TextField({ name: "location" }));
            col.fields.add(new TextField({ name: "event_time" }));
        }, "@request.auth.id != ''", "@request.auth.id != ''", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 20. suppliers
        const suppliersCol = ensureCollection("suppliers", "base", (col) => {
            col.fields.add(new TextField({ name: "name", required: true }));
            col.fields.add(new TextField({ name: "contact_name" }));
            col.fields.add(new TextField({ name: "email" }));
            col.fields.add(new TextField({ name: "phone" }));
            col.fields.add(new TextField({ name: "address" }));
            col.fields.add(new TextField({ name: "tax_id" }));
            col.fields.add(new TextField({ name: "notes" }));
            col.fields.add(new BoolField({ name: "is_active" }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 21. stock_movements
        ensureCollection("stock_movements", "base", (col) => {
            col.fields.add(new TextField({ name: "sku", required: true }));
            col.fields.add(new RelationField({ name: "product", collectionId: productsCol.id, maxSelect: 1 }));
            col.fields.add(new RelationField({ name: "variant", collectionId: variantsCol.id, maxSelect: 1 }));
            col.fields.add(new SelectField({
                name: "movement_type",
                values: ["PURCHASE_IN", "SALE_OUT", "CUSTOMER_RETURN_IN", "DAMAGE_OUT", "ADJUSTMENT_IN", "ADJUSTMENT_OUT", "RETURN_TO_SUPPLIER"],
                maxSelect: 1
            }));
            col.fields.add(new NumberField({ name: "quantity", required: true }));
            col.fields.add(new NumberField({ name: "unit_cost" }));
            col.fields.add(new RelationField({ name: "supplier", collectionId: suppliersCol.id, maxSelect: 1 }));
            col.fields.add(new TextField({ name: "reference_number" }));
            col.fields.add(new TextField({ name: "note" }));
            col.fields.add(new RelationField({ name: "created_by", collectionId: usersCol.id, maxSelect: 1 }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 22. purchase_orders
        const poCol = ensureCollection("purchase_orders", "base", (col) => {
            col.fields.add(new TextField({ name: "po_number", required: true }));
            col.fields.add(new RelationField({ name: "supplier", collectionId: suppliersCol.id, maxSelect: 1 }));
            col.fields.add(new SelectField({ name: "status", values: ["draft", "ordered", "received", "cancelled"], maxSelect: 1 }));
            col.fields.add(new NumberField({ name: "total_cost" }));
            col.fields.add(new TextField({ name: "ordered_at" }));
            col.fields.add(new TextField({ name: "received_at" }));
            col.fields.add(new TextField({ name: "notes" }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 23. purchase_order_items
        ensureCollection("purchase_order_items", "base", (col) => {
            col.fields.add(new RelationField({ name: "purchase_order", collectionId: poCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "variant", collectionId: variantsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new NumberField({ name: "quantity", required: true }));
            col.fields.add(new NumberField({ name: "unit_cost", required: true }));
            col.fields.add(new NumberField({ name: "received_quantity" }));
            col.fields.add(new NumberField({ name: "line_total" }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 24. conversations
        const conversationsCol = ensureCollection("conversations", "base", (col) => {
            col.fields.add(new RelationField({ name: "user", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new TextField({ name: "subject" }));
            col.fields.add(new TextField({ name: "last_message" }));
            col.fields.add(new TextField({ name: "last_message_at" }));
            col.fields.add(new NumberField({ name: "unread_customer_count" }));
            col.fields.add(new NumberField({ name: "unread_admin_count" }));
            col.fields.add(new SelectField({ name: "status", values: ["open", "closed"], maxSelect: 1 }));
        }, "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.id != ''",
           "@request.auth.id != '' && (@request.auth.id = user || @request.auth.role = 'ADMIN')",
           "@request.auth.role = 'ADMIN'");

        // 25. messages
        ensureCollection("messages", "base", (col) => {
            col.fields.add(new RelationField({ name: "conversation", collectionId: conversationsCol.id, maxSelect: 1, required: true }));
            col.fields.add(new RelationField({ name: "sender_id", collectionId: usersCol.id, maxSelect: 1, required: true }));
            col.fields.add(new SelectField({ name: "sender_type", values: ["CUSTOMER", "ADMIN"], maxSelect: 1 }));
            col.fields.add(new TextField({ name: "message_text" }));
            col.fields.add(new FileField({ name: "attachment_image", maxSelect: 1 }));
            col.fields.add(new BoolField({ name: "is_read" }));
            col.fields.add(new TextField({ name: "read_at" }));
        }, "@request.auth.id != ''",
           "@request.auth.id != ''",
           "@request.auth.id != ''",
           "@request.auth.id != ''",
           "@request.auth.role = 'ADMIN'");

        // 26. store_settings
        ensureCollection("store_settings", "base", (col) => {
            col.fields.add(new TextField({ name: "store_name" }));
            col.fields.add(new TextField({ name: "store_full_name" }));
            col.fields.add(new TextField({ name: "pronunciation" }));
            col.fields.add(new FileField({ name: "logo", maxSelect: 1 }));
            col.fields.add(new FileField({ name: "banner_image", maxSelect: 1 }));
            col.fields.add(new TextField({ name: "phone" }));
            col.fields.add(new TextField({ name: "email" }));
            col.fields.add(new TextField({ name: "line_id" }));
            col.fields.add(new TextField({ name: "facebook_page" }));
            col.fields.add(new TextField({ name: "instagram_handle" }));
            col.fields.add(new TextField({ name: "address" }));
            col.fields.add(new TextField({ name: "business_hours" }));
            col.fields.add(new TextField({ name: "currency" }));
            col.fields.add(new NumberField({ name: "default_shipping_fee" }));
            col.fields.add(new NumberField({ name: "free_shipping_min_order" }));
            col.fields.add(new TextField({ name: "welcome_message" }));
            col.fields.add(new TextField({ name: "return_policy" }));
            col.fields.add(new TextField({ name: "privacy_policy" }));
            col.fields.add(new TextField({ name: "terms_of_service" }));
            col.fields.add(new JSONField({ name: "bank_accounts_json" }));
            col.fields.add(new JSONField({ name: "notification_settings_json" }));
            col.fields.add(new JSONField({ name: "tax_settings_json" }));
        }, "", "", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        // 27. audit_logs
        ensureCollection("audit_logs", "base", (col) => {
            col.fields.add(new TextField({ name: "user_id" }));
            col.fields.add(new TextField({ name: "action" }));
            col.fields.add(new TextField({ name: "entity_type" }));
            col.fields.add(new TextField({ name: "entity_id" }));
            col.fields.add(new JSONField({ name: "old_values_json" }));
            col.fields.add(new JSONField({ name: "new_values_json" }));
            col.fields.add(new TextField({ name: "ip_address" }));
            col.fields.add(new TextField({ name: "user_agent" }));
        }, "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'", "@request.auth.role = 'ADMIN'");

        console.log("[C-TOWN] All 27 collections verified successfully!");

        // Seed initial data if empty
        seedInitialData();

    } catch (err) {
        console.log("[C-TOWN] Error initializing schema:", err);
    }

    function seedInitialData() {
        try {
            const brandsCol = $app.findCollectionByNameOrId("brands");
            const existingBrands = $app.findRecordsByFilter("brands", "1=1", "", 1);
            if (existingBrands.length > 0) {
                console.log("[C-TOWN] Database already contains seed data. Skipping seed.");
                return;
            }

            console.log("[C-TOWN] Seeding initial store settings, brands, categories, products and variants...");

            // 1. Store settings
            const settingsCol = $app.findCollectionByNameOrId("store_settings");
            const settingsRec = new Record(settingsCol);
            settingsRec.set("store_name", "C-TOWN");
            settingsRec.set("store_full_name", "C-TOWN SNEAKER STORE");
            settingsRec.set("pronunciation", "ซี-ทาวน์");
            settingsRec.set("phone", "02-888-9999");
            settingsRec.set("email", "contact@c-town-sneaker.com");
            settingsRec.set("line_id", "@ctown_sneakers");
            settingsRec.set("facebook_page", "facebook.com/ctownsneakers");
            settingsRec.set("instagram_handle", "@ctown.sneakers");
            settingsRec.set("address", "88 C-TOWN Complex, Sukhumvit Road, Khlong Toei, Bangkok 10110");
            settingsRec.set("business_hours", "Everyday 10:00 - 21:00");
            settingsRec.set("currency", "THB");
            settingsRec.set("default_shipping_fee", 60);
            settingsRec.set("free_shipping_min_order", 2500);
            settingsRec.set("welcome_message", "Step Into Your Style - C-TOWN ร้านรองเท้าผ้าใบสตรีทแวร์ระดับพรีเมียม");
            settingsRec.set("return_policy", "รับเปลี่ยนหรือคืนสินค้าภายใน 7 วัน นับจากวันที่ได้รับพัสดุ สินค้าต้องอยู่ในสภาพสมบูรณ์ กล่องและป้ายแท็กครบถ้วน");
            settingsRec.set("privacy_policy", "ทางร้านเก็บรักษาข้อมูลของลูกค้าตามมาตรฐานความปลอดภัย ไม่เปิดเผยข้อมูลส่วนบุคคลแก่บุคคลภายนอก");
            settingsRec.set("terms_of_service", "เงื่อนไขการสั่งซื้อและรับประกันสินค้าของแท้ 100% จาก C-TOWN SNEAKER STORE");
            settingsRec.set("bank_accounts_json", [
                {
                    bank: "KBANK (ธนาคารกสิกรไทย)",
                    account_name: "C-TOWN SNEAKER STORE CO., LTD.",
                    account_number: "088-2-33445-5",
                    branch: "Siam Paragon Branch",
                    promptpay_id: "0105566001234"
                },
                {
                    bank: "SCB (ธนาคารไทยพาณิชย์)",
                    account_name: "C-TOWN SNEAKER STORE CO., LTD.",
                    account_number: "111-4-55667-8",
                    branch: "EmQuartier Branch",
                    promptpay_id: "0105566001234"
                }
            ]);
            $app.save(settingsRec);

            // 2. Brands
            const brandDefs = [
                { name: "Nike", slug: "nike", description: "Iconic sportswear and streetwear sneaker leader" },
                { name: "Adidas", slug: "adidas", description: "Classic retro silhouettes and terrace culture" },
                { name: "Jordan", slug: "jordan", description: "Legendary basketball heritage and high fashion collabs" },
                { name: "New Balance", slug: "new-balance", description: "Timeless dad shoes and modern lifestyle runners" },
                { name: "Converse", slug: "converse", description: "Timeless vulcanized canvas icons" },
                { name: "Vans", slug: "vans", description: "Authentic Southern California skate culture" }
            ];
            const brandMap = {};
            for (const b of brandDefs) {
                const rec = new Record(brandsCol);
                rec.set("name", b.name);
                rec.set("slug", b.slug);
                rec.set("description", b.description);
                rec.set("is_active", true);
                $app.save(rec);
                brandMap[b.slug] = rec.id;
            }

            // 3. Categories
            const categoriesCol = $app.findCollectionByNameOrId("categories");
            const catDefs = [
                { name: "รองเท้าผ้าใบผู้ชาย", slug: "men", description: "Men's Sneaker Collection" },
                { name: "รองเท้าผ้าใบผู้หญิง", slug: "women", description: "Women's Sneaker Collection" },
                { name: "รองเท้าผ้าใบ Unisex", slug: "unisex", description: "Gender-neutral versatile sneakers" },
                { name: "รองเท้าสไตล์ Streetwear", slug: "streetwear", description: "Hype and lifestyle streetwear kicks" },
                { name: "รองเท้ากีฬา", slug: "performance-sports", description: "Comfort running and training footwear" },
                { name: "สินค้าใหม่", slug: "new-arrivals", description: "Latest drops and freshest arrivals" },
                { name: "สินค้าขายดี", slug: "best-sellers", description: "Top ranking most popular sneakers" }
            ];
            const catMap = {};
            for (const c of catDefs) {
                const rec = new Record(categoriesCol);
                rec.set("name", c.name);
                rec.set("slug", c.slug);
                rec.set("description", c.description);
                rec.set("is_active", true);
                $app.save(rec);
                catMap[c.slug] = rec.id;
            }

            // 4. Coupons
            const couponsCol = $app.findCollectionByNameOrId("coupons");
            const couponDefs = [
                { code: "WELCOME100", type: "fixed", val: 100, min: 1500, max: 100, limit: 1000 },
                { code: "CTOWN10", type: "percent", val: 10, min: 2000, max: 500, limit: 500 },
                { code: "FREESHIP", type: "free_shipping", val: 60, min: 1000, max: 60, limit: 2000 },
                { code: "VIP500", type: "fixed", val: 500, min: 4000, max: 500, limit: 200 }
            ];
            for (const cp of couponDefs) {
                const rec = new Record(couponsCol);
                rec.set("code", cp.code);
                rec.set("discount_type", cp.type);
                rec.set("discount_value", cp.val);
                rec.set("min_purchase", cp.min);
                rec.set("max_discount", cp.max);
                rec.set("start_date", "2026-01-01");
                rec.set("expiry_date", "2027-12-31");
                rec.set("usage_limit", cp.limit);
                rec.set("usage_per_customer", 3);
                rec.set("times_used", 0);
                rec.set("status", "active");
                $app.save(rec);
            }

            // 5. Suppliers
            const suppliersCol = $app.findCollectionByNameOrId("suppliers");
            const suppRec = new Record(suppliersCol);
            suppRec.set("name", "Nike Official Thailand Distribution");
            suppRec.set("contact_name", "Supplier Manager");
            suppRec.set("email", "supply@nikethailand.co.th");
            suppRec.set("phone", "02-999-1111");
            suppRec.set("is_active", true);
            $app.save(suppRec);

            // 6. Products and Variants
            const productsCol = $app.findCollectionByNameOrId("products");
            const variantsCol = $app.findCollectionByNameOrId("product_variants");
            const movementsCol = $app.findCollectionByNameOrId("stock_movements");

            const sampleProducts = [
                {
                    name: "Nike Air Force 1 '07",
                    slug: "nike-air-force-1-07",
                    brand: brandMap["nike"],
                    category: catMap["streetwear"],
                    description: "รองเท้าผ้าใบระดับตำนานที่ครองใจสายสตรีทมาอย่างยาวนาน โดดเด่นด้วยหนังพรีเมียมเรียบเนียน โทนสีคลีนสะดุดตา พร้อมระบบกันกระแทก Nike Air ที่สวมใส่สบายได้ตลอดวัน",
                    base_price: 3700,
                    is_new: false,
                    is_bestseller: true,
                    variants: [
                        {
                            color: "White",
                            color_code: "#FFFFFF",
                            sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44],
                            selling_price: 3700,
                            cost_price: 2400,
                            image: "/images/products/nike_af1_white.jpg"
                        },
                        {
                            color: "Rose Pink",
                            color_code: "#E05A88",
                            sizes: [36, 37, 38, 39, 40, 41],
                            selling_price: 3900,
                            sale_price: 3700,
                            cost_price: 2500,
                            image: "/images/products/nike_af1_pink.jpg"
                        },
                        {
                            color: "Triple Black",
                            color_code: "#18181B",
                            sizes: [38, 39, 40, 41, 42, 43, 44, 45],
                            selling_price: 3700,
                            cost_price: 2400,
                            image: "/images/products/nike_af1_black.jpg"
                        }
                    ]
                },
                {
                    name: "Adidas Samba OG",
                    slug: "adidas-samba-og",
                    brand: brandMap["adidas"],
                    category: catMap["streetwear"],
                    description: "ไอคอนทรงเสน่ห์แห่งยุค Terrace Culture รองเท้าหนังผิวเรียบตกแต่งด้วยหนังกลับรูปตัว T ที่หัวรองเท้า และพื้นยาง Gum Rubber อันเป็นเอกลักษณ์ แมตช์ง่ายกับทุกลุค",
                    base_price: 3800,
                    is_new: true,
                    is_bestseller: true,
                    variants: [
                        {
                            color: "Cloud White / Core Black",
                            color_code: "#FFFFFF",
                            sizes: [36, 37, 38, 39, 40, 41, 42, 43],
                            selling_price: 3800,
                            cost_price: 2500,
                            image: "/images/products/adidas_samba_white.jpg"
                        }
                    ]
                },
                {
                    name: "New Balance 530",
                    slug: "new-balance-530",
                    brand: brandMap["new-balance"],
                    category: catMap["unisex"],
                    description: "สนีกเกอร์สไตล์เรโทรยุค 90-2000 ที่ผสมผสานผ้าตาข่ายระบายอากาศเข้ากับดีเทลสีเงินเมทัลลิก พร้อมเทคโนโลยีซับแรงกระแทก ABZORB น้ำหนักเบา สบายเท้า",
                    base_price: 4200,
                    is_new: true,
                    is_bestseller: true,
                    variants: [
                        {
                            color: "White / Silver Metallic",
                            color_code: "#E2E8F0",
                            sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44],
                            selling_price: 4200,
                            cost_price: 2800,
                            image: "/images/products/nb530_silver.jpg"
                        }
                    ]
                },
                {
                    name: "Air Jordan 1 Low",
                    slug: "air-jordan-1-low-rose-gold",
                    brand: brandMap["jordan"],
                    category: catMap["women"],
                    description: "ดีไซน์หรูหราสำหรับสุภาพสตรีและคอลเลกชันพิเศษ ตกแต่งด้วยโลโก้ Swoosh สี Rose Gold เมทัลลิก หนังสีขาวและบลัชพิงก์ สะท้อนความลักชัวรีของสตรีทแวร์",
                    base_price: 4700,
                    is_new: true,
                    is_bestseller: false,
                    variants: [
                        {
                            color: "Metallic Rose Gold / White",
                            color_code: "#E5B299",
                            sizes: [36, 37, 38, 39, 40, 41],
                            selling_price: 4700,
                            cost_price: 3100,
                            image: "/images/products/jordan1_rose_gold.jpg"
                        }
                    ]
                },
                {
                    name: "Converse Chuck 70 High",
                    slug: "converse-chuck-70-high",
                    brand: brandMap["converse"],
                    category: catMap["unisex"],
                    description: "รองเท้าผ้าใบระดับไอคอนิค ทรงไฮท็อปผ้าใบแคนวาส 12oz หนาทนทาน ขอบยางสี Egret วินเทจ เดินด้ายตะเข็บคู่ และแผ่นรองเท้า OrthoLite นุ่มสบาย",
                    base_price: 3300,
                    is_new: false,
                    is_bestseller: true,
                    variants: [
                        {
                            color: "Classic Black",
                            color_code: "#18181B",
                            sizes: [36, 37, 38, 39, 40, 41, 42, 43, 44],
                            selling_price: 3300,
                            cost_price: 2100,
                            image: "/images/products/converse_chuck_black.jpg"
                        }
                    ]
                }
            ];

            for (const p of sampleProducts) {
                const prodRec = new Record(productsCol);
                prodRec.set("name", p.name);
                prodRec.set("slug", p.slug);
                prodRec.set("brand", p.brand);
                prodRec.set("category", p.category);
                prodRec.set("description", p.description);
                prodRec.set("status", "active");
                prodRec.set("is_new", p.is_new);
                prodRec.set("is_bestseller", p.is_bestseller);
                prodRec.set("base_price", p.base_price);
                $app.save(prodRec);

                for (const v of p.variants) {
                    for (const s of v.sizes) {
                        const vRec = new Record(variantsCol);
                        const sku = `${p.slug.toUpperCase().slice(0, 6)}-${v.color.toUpperCase().replace(/[^A-Z]/g, "").slice(0, 3)}-SZ${s}`;
                        vRec.set("product", prodRec.id);
                        vRec.set("sku", sku);
                        vRec.set("barcode", "885" + Math.floor(100000000 + Math.random() * 900000000));
                        vRec.set("color", v.color);
                        vRec.set("color_code", v.color_code);
                        vRec.set("size", String(s));
                        vRec.set("cost_price", v.cost_price);
                        vRec.set("selling_price", v.selling_price);
                        if (v.sale_price) vRec.set("sale_price", v.sale_price);
                        
                        // initial stock between 8 and 15 pairs
                        const initialQty = Math.floor(8 + Math.random() * 8);
                        vRec.set("stock_quantity", initialQty);
                        vRec.set("sold_quantity", Math.floor(Math.random() * 5));
                        vRec.set("image_url", v.image);
                        vRec.set("status", "active");
                        $app.save(vRec);

                        // Record initial stock movement
                        const movRec = new Record(movementsCol);
                        movRec.set("sku", sku);
                        movRec.set("product", prodRec.id);
                        movRec.set("variant", vRec.id);
                        movRec.set("movement_type", "PURCHASE_IN");
                        movRec.set("quantity", initialQty);
                        movRec.set("unit_cost", v.cost_price);
                        movRec.set("supplier", suppRec.id);
                        movRec.set("reference_number", "INIT-BATCH-2026");
                        movRec.set("note", "Initial inventory opening stock");
                        $app.save(movRec);
                    }
                }
            }

            console.log("[C-TOWN] Seed data successfully populated!");
        } catch (err) {
            console.log("[C-TOWN] Error seeding data:", err);
        }
    }
});
