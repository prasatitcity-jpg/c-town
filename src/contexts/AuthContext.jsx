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
    // Auto-login to obtain session
    const auth = await pb.collection('users').authWithPassword(email, password);
    setUser(auth.record);
    return regRes.user || auth.record;
  }, []);

  const loginWithPin = useCallback(async (pin) => {
    const res = await ctownFetch('/admin/pin-login', {
      method: 'POST',
      body: { pin },
    });
    if (!res.success || !res.email || !res.password) {
      throw new Error(res.message || 'รหัส PIN ไม่ถูกต้อง');
    }
    const auth = await pb.collection('users').authWithPassword(res.email, res.password);
    setUser(auth.record);
    return auth.record;
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
