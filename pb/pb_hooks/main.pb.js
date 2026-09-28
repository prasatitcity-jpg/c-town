// pb_hooks/main.pb.js
routerAdd("GET", "/api/ctown/health", (c) => {
    return c.json(200, {
        status: "ok",
        store: "C-TOWN SNEAKER STORE",
        version: "1.0.0"
    });
});
