<template lang="pug">
.login
  .login__container
    h2 Вход в систему

    form(@submit.prevent='handleLogin')
        .form-group
            label(for='email') Почта
            input#email(type='email' v-model='form.email' autocomplete="on")
            span.error(v-if='errors.email') {{ errors.email }}

        .form-group
            label(for='password') Пароль
            input#password(type='password' v-model='form.password' autocomplete="on")
            span.error(v-if='errors.password') {{ errors.password }}

        button(type='submit') Войти
        router-link(to="/reg" class='reglink') Не зарегистрированы? 
</template>
<script>
import axios from 'axios'
import { useUserStore } from '../../stores/user'
export default {
  name: 'Login',
  data() {
    return {
      form: {
        email: '',
        password: ''
      },
      errors: {}
    }
  },
  methods: {
    // Метод для валидации формы
    validateForm() {
      this.errors = {}
      let valid = true

      if (!this.form.email || !/^[0-9A-Za-z_.+-]{1,64}@[0-9A-Za-z_-]{1,10}\.[0-9A-Za-z_-]{2,6}$/.test(this.form.email)) {
          this.errors.email = 'Некорректный email'
          valid = false
      }
      if (!/^(?=.*[.!,?])[0-9A-Za-z\s.!,?-]{8,40}$/.test(this.form.password)) {
        this.errors.password = 'Пароль должен быть от 8 символов и содержать спец символ(!.,?-)'
        valid = false
      }

      return valid
    },
    // Логика обработки кнопки войти
    async handleLogin() {
      if (!this.validateForm()) return

      try {
        const response = await axios.post(import.meta.env.VITE_API_URL + '/auth',
            {email: this.form.email,
            password: this.form.password}
        )
        console.log('Успешный вход', response.data)
        localStorage.setItem('token', response.data.access_token)
        let role = response.data.roles[0]
        console.log(role)
        useUserStore().setUserRole(role)
        if(role === 'user') this.$router.push('/user-cabinet')
        if(role === 'admin') this.$router.push('/admin')
      } catch (error) {
        const msg = error.response?.data?.msg || 'Ошибка входа';
        alert(msg);
      }
    }
  }
}
</script>
<style lang="scss">
    @use './login.scss' as *;
</style>