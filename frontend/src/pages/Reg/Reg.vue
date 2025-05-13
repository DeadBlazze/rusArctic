<template lang="pug">
    .registration
        .registration__container
            h2 Регистрация
            form(@submit.prevent="handleRegister")
              .form-group
                  label(for="fio") ФИО
                  input#fio(type="text" v-model="form.fio")
                  span.error(v-if="errors.fio") {{ errors.fio }}
          
              .form-group
                  label(for="email") Почта
                  input#email(type="email" v-model="form.email")
                  span.error(v-if="errors.email") {{ errors.email }}
          
              .form-group
                  label(for="tel") Телефон
                  input#tel(type="tel" v-model="form.tel")
                  span.error(v-if="errors.tel") {{ errors.tel }}
          
              .form-group
                  label(for="password") Пароль
                  input#password(type="password" v-model="form.password")
                  span.error(v-if="errors.password") {{ errors.password }}
              button.submit-btn(type="submit") Зарегистрироваться
    </template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      form: {
        fio: '',
        email: '',
        tel: '',
        password: '',
      },
      errors: {},
    }
  },
  methods: {
    validateForm() {
      this.errors = {}
      let valid = true

      if (!/^[А-Яа-яЁёA-Za-z\s\-]{1,200}$/.test(this.form.fio.trim())) {
          this.errors.fio = 'ФИО должно содержать только буквы, пробелы'
          valid = false
      }
      if (!this.form.email || !/^[0-9A-Za-z_.+-]{1,64}@[0-9A-Za-z_-]{1,10}\.[0-9A-Za-z_-]{2,6}$/.test(this.form.email)) {
          this.errors.email = 'Некорректный email'
          valid = false
      }
      if (!/^(?:\+7|8)\d{10}$/.test(this.form.tel)) {
        this.errors.tel = 'Телефон должен начинаться с +7 или 8 и содержать ровно 11 цифр';
        valid = false;
      }
      if (!/^(?=.*[.!,?])[0-9A-Za-z\s.!,?-]{8,40}$/.test(this.form.password)) {
        this.errors.password = 'Пароль должен быть от 8 символов и содержать спец символ(!.,?-)'
        valid = false
      }
    return valid
    },
    async handleRegister() {
      if (!this.validateForm()) return

      try {
        const response = await axios.post(import.meta.env.VITE_API_URL + '/register', 
        { 
          "email": this.form.email,
          "password": this.form.password,
          "fio": this.form.fio,
          "tel":  this.form.tel,
        }
      )
        console.log('Успешно зарегистрирован', response.data)
        localStorage.setItem('token', response.data.access_token)
        this.$router.push('/user-cabinet')
        // Перенаправление или уведомление
      } catch (error) {
        const msg = error.response?.data?.msg || 'Ошибка входа';
        alert(msg);яё
      }
    }
  }
}
</script>
<style lang="scss" scoped>
    @use './reg.scss' as *;
</style>