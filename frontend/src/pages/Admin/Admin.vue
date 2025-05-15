<template lang="pug">
.lk
    button.lk__button(@click="logout") Выйти
.stream-list
    .stream-list__title
        h2 Заявки пользователей
        .stream-list__filter
            p Фильтр:
            select(v-model='filterKey') 
                option(value='data+') Сначала новые
                option(value='data-') Сначала старые
                option(value='fio') ФИО
                option(value='start_point') Точка отправления 
                option(value='title') Название тура
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
                .stream__item {{ stream.includes }}
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
            deleteClick: null,
            filterKey: 'data+',
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
        sortTours(){
            let key = this.filterKey
            const sortMethods = {
                'data+': (a,b) => new Date(a.timestamp) - new Date(b.timestamp),
                'data-': (a,b) => new Date(b.timestamp) - new Date(a.timestamp),
                'fio': (a,b) => a.title.localeCompare(b.title),
                'start_point': (a,b) => a.start_point.localeCompare(b.start_point),
                'title': (a,b) => a.title.localeCompare(b.title),
            }
            this.streams.sort(sortMethods[key])
        },
        logout(){
            localStorage.removeItem('token')
            this.token = null
            useUserStore().unsetRole()
            this.$router.push('/auth')
        }
    },
     watch: {
        filterKey(){
            this.sortTours();
        }
    }
}
</script>
<style lang="scss" scoped>
@use './admin.scss' as *;
</style>