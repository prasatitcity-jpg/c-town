// pb_hooks/01_auth_rules.pb.js
// Authentication rules, role guards, and secure Admin Setup

// 1. Guard against regular users setting role = 'ADMIN' during public registration
onRecordCreate((e) => {
    // If not flagged as internal system admin setup, strictly enforce CUSTOMER role
    if (!globalThis._isSystemAdminSetup) {
        if (e.record.get("role") !== "CUSTOMER") {
            console.log("[C-TOWN] Normal signup attempted to set role:", e.record.get("role"), "-> Forcing to CUSTOMER");
            e.record.set("role", "CUSTOMER");
        }
    }

    e.next();

    // Automatically create a linked customer profile after user creation
    try {
        const profilesCol = $app.findCollectionByNameOrId("customer_profiles");
        const existing = $app.findRecordsByFilter("customer_profiles", `user = "${e.record.id}"`, "", 1);
        if (existing.length === 0) {
            const prof = new Record(profilesCol);
            prof.set("user", e.record.id);
            prof.set("full_name", e.record.get("name") || "");
            prof.set("phone", e.record.get("phone") || "");
            $app.save(prof);
        }
    } catch (err) {
        console.log("[C-TOWN] Error creating default customer profile:", err);
    }
}, "users");

// 2. Secure Admin Setup Endpoint
// Allows the store owner to initialize their first Admin account with a secure setup key
routerAdd("POST", "/api/ctown/admin/setup", (c) => {
    try {
        const body = c.requestInfo().body || {};
        const { email, password, name, phone, setup_key } = body;

        // Default setup key or environment key
        const VALID_SETUP_KEY = $os.getenv("CTOWN_SETUP_KEY") || "CTOWN_ADMIN_INIT_2026";

        if (!setup_key || setup_key !== VALID_SETUP_KEY) {
            return c.json(403, {
                success: false,
                message: "รหัส Setup Key ไม่ถูกต้อง กรุณาติดต่อผู้ดูแลระบบหรือตรวจสอบในคู่มือติดตั้ง"
            });
        }

        if (!email || !password || password.length < 8) {
            return c.json(400, {
                success: false,
                message: "กรุณาระบุอีเมลและรหัสผ่านอย่างน้อย 8 ตัวอักษร"
            });
        }

        const usersCol = $app.findCollectionByNameOrId("users");
        
        // Check if user already exists
        let userRec;
        try {
            userRec = $app.findAuthRecordByEmail("users", email);
        } catch (_) {}

        globalThis._isSystemAdminSetup = true;
        try {
            if (userRec) {
                // Update existing user to ADMIN
                userRec.set("role", "ADMIN");
                userRec.set("verified", true);
                if (name) userRec.set("name", name);
                if (phone) userRec.set("phone", phone);
                userRec.setPassword(password);
                $app.save(userRec);
            } else {
                // Create new admin user
                userRec = new Record(usersCol);
                userRec.set("email", email);
                userRec.setPassword(password);
                userRec.set("role", "ADMIN");
                userRec.set("name", name || "Store Administrator");
                userRec.set("phone", phone || "");
                userRec.set("verified", true);
                $app.save(userRec);
            }
        } finally {
            globalThis._isSystemAdminSetup = false;
        }

        // Ensure admin profile exists
        try {
            const adminProfilesCol = $app.findCollectionByNameOrId("admin_profiles");
            const existingProfiles = $app.findRecordsByFilter("admin_profiles", `user = "${userRec.id}"`, "", 1);
            if (existingProfiles.length === 0) {
                const adminProf = new Record(adminProfilesCol);
                adminProf.set("user", userRec.id);
                adminProf.set("role_title", "Store Owner & Superadmin");
                adminProf.set("department", "Management");
                adminProf.set("permissions", JSON.stringify(["ALL"]));
                $app.save(adminProf);
            }
        } catch (profileErr) {
            console.log("[C-TOWN] Error creating admin profile:", profileErr);
        }

        return c.json(200, {
            success: true,
            message: "สร้างบัญชีแอดมิน C-TOWN สำเร็จแล้ว สามารถเข้าสู่ระบบแอดมินได้ทันที",
            user: {
                id: userRec.id,
                email: userRec.get("email"),
                name: userRec.get("name"),
                role: userRec.get("role")
            }
        });
    } catch (err) {
        console.log("[C-TOWN] Setup error:", err);
        return c.json(500, {
            success: false,
            message: "เกิดข้อผิดพลาดในการตั้งค่าแอดมิน: " + String(err)
        });
    }
});

// 3. User info and session validation
routerAdd("GET", "/api/ctown/auth/me", (c) => {
    try {
        const info = c.requestInfo();
        if (!info.auth) {
            return c.json(401, { success: false, message: "ไม่ได้เข้าสู่ระบบ" });
        }

        const user = info.auth;
        let addresses = [];
        let profile = null;

        try {
            addresses = $app.findRecordsByFilter("addresses", `user = "${user.id}"`, "-id", 10);
        } catch (_) {}

        try {
            const profs = $app.findRecordsByFilter("customer_profiles", `user = "${user.id}"`, "", 1);
            if (profs.length > 0) profile = profs[0];
        } catch (_) {}

        return c.json(200, {
            success: true,
            user: {
                id: user.id,
                email: user.get("email"),
                name: user.get("name"),
                phone: user.get("phone"),
                role: user.get("role") || "CUSTOMER",
                created: user.created
            },
            profile: profile,
            addresses: addresses
        });
    } catch (err) {
        return c.json(500, { success: false, error: String(err) });
    }
});

// 4. Admin PIN Login Endpoint (PIN: 1111)
routerAdd("POST", "/api/ctown/admin/pin-login", (c) => {
    try {
        const body = c.requestInfo().body || {};
        const { pin } = body;

        if (pin !== "1111") {
            return c.json(401, {
                success: false,
                message: "รหัส PIN ไม่ถูกต้อง (กรุณาระบุ PIN 1111)"
            });
        }

        const adminEmail = "admin@ctown.local";
        const adminPass = "Admin1111!";
        const usersCol = $app.findCollectionByNameOrId("users");

        let userRec;
        try {
            userRec = $app.findAuthRecordByEmail("users", adminEmail);
        } catch (_) {}

        globalThis._isSystemAdminSetup = true;
        try {
            if (!userRec) {
                userRec = new Record(usersCol);
                userRec.set("email", adminEmail);
                userRec.setPassword(adminPass);
                userRec.set("role", "ADMIN");
                userRec.set("name", "C-TOWN Administrator");
                userRec.set("verified", true);
                $app.save(userRec);
            } else {
                if (userRec.get("role") !== "ADMIN") {
                    userRec.set("role", "ADMIN");
                }
                userRec.setPassword(adminPass);
                userRec.set("verified", true);
                $app.save(userRec);
            }
        } finally {
            globalThis._isSystemAdminSetup = false;
        }

        // Ensure admin profile
        try {
            const adminProfilesCol = $app.findCollectionByNameOrId("admin_profiles");
            const existingProfiles = $app.findRecordsByFilter("admin_profiles", `user = "${userRec.id}"`, "", 1);
            if (existingProfiles.length === 0) {
                const adminProf = new Record(adminProfilesCol);
                adminProf.set("user", userRec.id);
                adminProf.set("role_title", "Store Owner & Superadmin");
                adminProf.set("department", "Management");
                adminProf.set("permissions", JSON.stringify(["ALL"]));
                $app.save(adminProf);
            }
        } catch (_) {}

        return c.json(200, {
            success: true,
            email: adminEmail,
            password: adminPass,
            user: {
                id: userRec.id,
                email: userRec.get("email"),
                name: userRec.get("name"),
                role: "ADMIN"
            }
        });
    } catch (err) {
        return c.json(500, {
            success: false,
            message: "เกิดข้อผิดพลาดในการเข้าสู่ระบบด้วย PIN: " + String(err)
        });
    }
});

// 5. Dedicated Public Customer Registration Endpoint
routerAdd("POST", "/api/ctown/auth/register", (c) => {
    try {
        const body = c.requestInfo().body || {};
        const email = (body.email || "").trim().toLowerCase();
        const password = body.password || "";
        const passwordConfirm = body.passwordConfirm || "";
        const name = (body.name || "").trim();
        const phone = (body.phone || "").trim();

        if (!email || !email.includes("@")) {
            return c.json(400, { success: false, message: "กรุณาระบุอีเมลที่ถูกต้อง" });
        }

        if (!password || password.length < 8) {
            return c.json(400, { success: false, message: "รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร" });
        }

        if (password !== passwordConfirm) {
            return c.json(400, { success: false, message: "รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน" });
        }

        if (!name) {
            return c.json(400, { success: false, message: "กรุณาระบุชื่อ-นามสกุล" });
        }

        const usersCol = $app.findCollectionByNameOrId("users");

        // Check duplicate email
        let existingUser = null;
        try {
            existingUser = $app.findAuthRecordByEmail("users", email);
        } catch (_) {}

        if (existingUser) {
            return c.json(400, {
                success: false,
                message: "อีเมลนี้มีอยู่ในระบบแล้ว กรุณาเข้าสู่ระบบหรือใช้อีเมลอื่น"
            });
        }

        globalThis._isSystemAdminSetup = true;
        let newUser;
        try {
            newUser = new Record(usersCol);
            newUser.set("email", email);
            newUser.setPassword(password);
            newUser.set("name", name);
            newUser.set("phone", phone);
            newUser.set("role", "CUSTOMER");
            newUser.set("verified", true);
            $app.save(newUser);
        } finally {
            globalThis._isSystemAdminSetup = false;
        }

        // Linked customer profile
        try {
            const profilesCol = $app.findCollectionByNameOrId("customer_profiles");
            const prof = new Record(profilesCol);
            prof.set("user", newUser.id);
            prof.set("full_name", name);
            prof.set("phone", phone);
            $app.save(prof);
        } catch (_) {}

        return c.json(200, {
            success: true,
            message: "สมัครสมาชิกสำเร็จ",
            user: {
                id: newUser.id,
                email: newUser.get("email"),
                name: newUser.get("name"),
                role: "CUSTOMER",
            }
        });
    } catch (err) {
        console.log("[C-TOWN] Register error:", err);
        return c.json(500, {
            success: false,
            message: "เกิดข้อผิดพลาดในการสมัครสมาชิก: " + String(err)
        });
    }
});
