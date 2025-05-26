<template lang="pug">
.lk
    router-link(to="/admin/dashboard") Редактор туров
    button.lk__button(@click="logout") Выйти
router-view(v-if="isReady")
</template>
<script>
export default {
    data() {
        return {
            isReady: false,
        }
    },
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
        const role = localStorage.getItem('userRole')
        console.log(role)
        if(role !== 'admin'){
            alert('Запрещённый ресурс')
            this.$router.push('/auth')
            return
        }
        this.isReady = true;
    }
}
</script>
<style lang="scss" scoped>
@use './admin.scss' as *;
</style>