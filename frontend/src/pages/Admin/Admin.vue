<template lang="pug">
.lk
    button.lk__button(@click="logout") Выйти
.stream-list
    h1 Заявки пользователей
    .streams
        .stream(v-for='stream in streams' :key='stream.id' v-if='streams[0]')
            .stream__header
                .stream__title {{ stream.title }}
                .stream__route {{ stream.route }}
                img.stream__delete(src="../../assets/images/UI/icons/cross.svg" 
                title="Удалить заявку на поток"
                @click="deleteStream()")
            .stream__info
                .stream__item {{stream.fio}}
                .stream__item Почта: {{stream.email}}
                .stream__item Телефон: {{stream.tel}}
                <br>
                .stream__item {{ stream.description }}
                .stream__item {{ stream.duration }} дней
                .stream__item {{ stream.includes }} дней
                .stream__item Отправление: {{ stream.start_time }}
                .stream__item Город отправления: {{ stream.start_point }}
                .stream__price {{ stream.price }} ₽
            .delete-confirm__modal(v-if='deleteClick')
                .modal__inner
                    .modal__title
                        h3 Удалить заявку на тур?
                        img(src='../../assets/images/UI/icons/cross.svg' @click="confirmDelete(false)")
                    .modal__buttons
                        button(@click='confirmDelete(true, stream.id_stream, stream.id_user)') Да
                        button(@click='confirmDelete(false)') Нет
        h3(v-else) *Нет актуальных заявок
</template>
<script>
import axios from 'axios'
import { useUserStore } from '../../stores/user'
export default {
    data() {
        return {
            streams: [],
            deleteClick: null
        }
    },
    async mounted() {
        this.token = localStorage.getItem('token')
        if(!this.token){
            this.$router.push('/auth')
        }
        this.loadStreams();
    },
    methods:{
        async loadStreams(){
            const response = await axios.get(import.meta.env.VITE_API_URL + '/admin-get-streams', {
                headers:{
                    Authorization: 'Bearer ' + this.token
                }
            })
            this.streams = response.data;
        },
        deleteStream(){
            this.deleteClick = true
        },
        async confirmDelete(userSelect, id_stream, id_user){
            if(userSelect){
                const response = await axios.post(
                    import.meta.env.VITE_API_URL + '/admin-delete-user-stream', 
                    {
                        "id_user":id_user, "id_stream":id_stream
                    },
                    {
                        headers:{
                            Authorization: 'Bearer ' + this.token
                        }
                    }
                )
                this.loadStreams();
                this.deleteClick = false
            }
            else{
                this.deleteClick = false
            }
        },
        logout(){
            localStorage.removeItem('token')
            this.token = null
            useUserStore().unsetRole()
            this.$router.push('/auth')
        }
    }
}
</script>
<style lang="scss" scoped>
@use './admin.scss' as *;
</style>