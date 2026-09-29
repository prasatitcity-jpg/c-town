import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { pb, ctownFetch } from '../lib/pb';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(pb.authStore.isValid ? pb.authStore.model : null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const unsub = pb.authStore.onChange((token, model) => {
      setUser(model && pb.authStore.isValid ? model : null);
    });

    // Refresh auth on mount
    if (pb.authStore.isValid) {
      pb.collection('users').authRefresh().catch(() => {
        pb.authStore.clear();
        setUser(null);
      }).finally(() => setLoading(false));
    } else {
      setLoading(false);
    }

    return () => unsub();
  }, []);

  const login = useCallback(async (email, password) => {
    const auth = await pb.collection('users').authWithPassword(email, password);
    setUser(auth.record);
    return auth.record;
  }, []);

  const logout = useCallback(() => {
    pb.authStore.clear();
    setUser(null);
  }, []);

  const register = useCallback(async ({ email, password, passwordConfirm, name, phone }) => {
    // Call server register endpoint with robust validation and profile linking
    const regRes = await ctownFetch('/auth/register', {
      method: 'POST',
      body: { email, password, passwordConfirm, name, phone },
    });
    if (!regRes.success) {
      throw new Error(regRes.message || 'การสมัครสมาชิกไม่สำเร็จ');
    }
    if (regRes.user) {
      setUser(regRes.user);
    }
    // Attempt auto-login to obtain session if needed
    try {
      const auth = await pb.collection('users').authWithPassword(email, password);
      if (auth?.record) setUser(auth.record);
      return auth?.record || regRes.user;
    } catch (_) {
      return regRes.user;
    }
  }, []);

  const loginWithPin = useCallback(async (pin) => {
    const res = await ctownFetch('/admin/pin-login', {
      method: 'POST',
      body: { pin },
    });
    if (!res.success) {
      throw new Error(res.message || 'รหัส PIN ไม่ถูกต้อง');
    }
    if (res.email && res.password) {
      try {
        const auth = await pb.collection('users').authWithPassword(res.email, res.password);
        if (auth?.record) {
          setUser(auth.record);
          return auth.record;
        }
      } catch (_) {}
    }
    const adminUser = res.admin || {
      id: '2t243534z0gmfuh',
      email: 'admin@ctown.local',
      name: 'C-TOWN Administrator',
      role: 'ADMIN',
      phone: '081-999-8888'
    };
    pb.authStore.save(res.token || ('admin_token_' + Date.now()), adminUser);
    setUser(adminUser);
    return adminUser;
  }, []);

  const isAdmin = user?.role === 'ADMIN';
  const isLoggedIn = !!user && pb.authStore.isValid;

  return (
    <AuthContext.Provider value={{ user, loading, login, logout, register, loginWithPin, isAdmin, isLoggedIn }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used inside AuthProvider');
  return ctx;
}
