<template>
  <div class="login-container">
    <h2>系统登录</h2>
    <form @submit.prevent="handleLogin">
      <div class="field">
        <label>用户名</label>
        <input v-model="username" required />
      </div>
      <div class="field">
        <label>密码</label>
        <input type="password" v-model="password" required />
      </div>
      <button type="submit">登录</button>
      <p v-if="error" class="error">{{ error }}</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const username = ref('')
const password = ref('')
const error = ref('')
const auth = useAuthStore()
const router = useRouter()

async function handleLogin() {
  error.value = ''
  const success = await auth.login(username.value, password.value)
  if (success) {
    router.push('/')
  } else {
    error.value = '用户名或密码错误'
  }
}
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 80px auto;
  padding: 24px;
  border: 1px solid #ddd;
  border-radius: 8px;
}
.field {
  margin-bottom: 16px;
}
label {
  display: block;
  margin-bottom: 4px;
}
input {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 10px;
}
.error {
  color: red;
  margin-top: 8px;
}
</style>