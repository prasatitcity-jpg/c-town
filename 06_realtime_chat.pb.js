// pb_hooks/06_realtime_chat.pb.js
// Customer-Admin Chat System and Conversation State

// 1. Get or create conversation for current customer
routerAdd("POST", "/api/ctown/chat/conversation", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth) {
            return c.json(401, { success: false, message: "กรุณาเข้าสู่ระบบก่อนเริ่มการสนทนา" });
        }

        const user = info.auth;
        const convsCol = $app.findCollectionByNameOrId("conversations");
        const existing = $app.findRecordsByFilter("conversations", `user = "${user.id}"`, "-id", 1);

        let convRec;
        if (existing.length > 0) {
            convRec = existing[0];
        } else {
            convRec = new Record(convsCol);
            convRec.set("user", user.id);
            convRec.set("subject", "การสอบถามสินค้าและบริการทั่วไป");
            convRec.set("last_message", "ยินดีต้อนรับสู่ C-TOWN SNEAKER STORE สอบถามรายละเอียดสินค้า สี ไซซ์ หรือสถานะออเดอร์ได้เลยครับ");
            convRec.set("last_message_at", new Date().toISOString());
            convRec.set("unread_customer_count", 0);
            convRec.set("unread_admin_count", 0);
            convRec.set("status", "open");
            $app.save(convRec);
        }

        return c.json(200, {
            success: true,
            conversation: convRec
        });
    } catch (err) {
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาด: " + String(err) });
    }
});

// 2. Send message
routerAdd("POST", "/api/ctown/chat/send", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth) {
            return c.json(401, { success: false, message: "กรุณาเข้าสู่ระบบก่อนส่งข้อความ" });
        }

        const sender = info.auth;
        const senderRole = sender.get("role") || "CUSTOMER";
        const body = info.body || {};
        const { conversation_id, message_text } = body;

        if (!conversation_id || !message_text || !message_text.trim()) {
            return c.json(400, { success: false, message: "กรุณาระบุข้อความที่ต้องการส่ง" });
        }

        const convRec = $app.findRecordById("conversations", conversation_id);
        const convUserId = convRec.get("user");

        // Authorization check: Customer can only message in their own conversation!
        if (senderRole !== "ADMIN" && sender.id !== convUserId) {
            return c.json(403, { success: false, message: "ไม่มีสิทธิ์เข้าถึงห้องสนทนานี้" });
        }

        const messagesCol = $app.findCollectionByNameOrId("messages");
        const msgRec = new Record(messagesCol);
        msgRec.set("conversation", convRec.id);
        msgRec.set("sender_id", sender.id);
        msgRec.set("sender_type", senderRole === "ADMIN" ? "ADMIN" : "CUSTOMER");
        msgRec.set("message_text", message_text.trim());
        msgRec.set("is_read", false);
        $app.save(msgRec);

        // Update conversation summary and unread count
        convRec.set("last_message", message_text.trim());
        convRec.set("last_message_at", new Date().toISOString());
        if (senderRole === "ADMIN") {
            convRec.set("unread_customer_count", (convRec.get("unread_customer_count") || 0) + 1);
        } else {
            convRec.set("unread_admin_count", (convRec.get("unread_admin_count") || 0) + 1);
        }
        $app.save(convRec);

        return c.json(200, {
            success: true,
            message: msgRec
        });
    } catch (err) {
        return c.json(500, { success: false, message: "เกิดข้อผิดพลาดในการส่งข้อความ: " + String(err) });
    }
});

// 3. Mark conversation as read
routerAdd("POST", "/api/ctown/chat/mark-read", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth) {
            return c.json(401, { success: false, message: "กรุณาเข้าสู่ระบบ" });
        }

        const user = info.auth;
        const role = user.get("role") || "CUSTOMER";
        const body = info.body || {};
        const { conversation_id } = body;

        const convRec = $app.findRecordById("conversations", conversation_id);
        if (role === "ADMIN") {
            convRec.set("unread_admin_count", 0);
        } else if (user.id === convRec.get("user")) {
            convRec.set("unread_customer_count", 0);
        }
        $app.save(convRec);

        return c.json(200, { success: true });
    } catch (err) {
        return c.json(500, { success: false, error: String(err) });
    }
});
