import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || null,
  }),
  actions: {
    async login(username, password) {
      try {
        const res = await fetch(`${import.meta.env.VITE_API_BASE_URL}/api/login`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ username, password }),
        })
        if (!res.ok) return false
        const data = await res.json()
        this.token = data.token
        localStorage.setItem('token', data.token)
        return true
      } catch (e) {
        return false
      }
    },
    logout() {
      this.token = null
      localStorage.removeItem('token')
    },
  },
})