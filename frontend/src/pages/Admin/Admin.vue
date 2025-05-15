<template lang="pug">
.lk
    router-link(to="/admin/dashboard") Редактор туров
    button.lk__button(@click="logout") Выйти
router-view
</template>
<script>
export default {
    methods:{
        logout(){
            localStorage.removeItem('token')
            this.token = null

            // Обнуляем роль в header.vue
            const header = this.$root.$refs.header;
            if(header){
                console.log('header link find')
            }
            header.unsetRole();

            this.$router.push('/auth')
        }
    },
    mounted(){
        this.token = localStorage.getItem('token')
        if(!this.token){
            this.$router.push('/auth')
        }
    }
}
</script>
<style lang="scss" scoped>
@use './admin.scss' as *;
</style>