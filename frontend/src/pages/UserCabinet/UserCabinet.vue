<template lang="pug">
.lk__inner
    img.lk__logo(src="../../assets/images/lk/avatar.png")
    .lk__content
        .lk__data(v-if="user")
            p {{user.fio}}
            p {{user.email}}
            p {{user.tel}}
        button.lk__button(@click="logout") Выйти
.tour-list
    .tour-list__title 
        h2 Список моих туров
        div.tour-list__filter
            p Фильтр:
            select(v-model='filterKey') 
                option(value='id_tour' selected) По умолчанию
                option(value='title') Название
                option(value='price') Стоимость
                option(value='start_time') Дата отправления
    .tours
        .tour(v-for="tour in tours" :key="tour.id_tour" v-if='tours[0]')
            .tour__header
                .tour__title {{ tour.title }}
                .tour__route {{ tour.route }}
            .tour__info
                .tour__item {{ tour.description }}
                .tour__item {{ tour.duration }} дней
                .tour__item {{ tour.includes }} дней
                .tour__item Отправление: {{ tour.start_time }}
                .tour__item Город отправления: {{ tour.start_point }}
                .tour__price-inner
                    p.tour__price {{ tour.price }} ₽
                    p.tour__cancel(@click='tourCancelOpen(tour.id_tour)') Отменить
            .tour__cancel-modal(v-if='tourCancel')
                .tour__cancel
                    p Вы действительно хотите отменить заявку на тур?
                    .tour__cancel-buttons 
                        button(@click='tourCancelRequest(tour.id_stream)') Да
                        button(@click='tourCancelClose()') Нет
        h3(v-else) *Нет актуальных заявок
</template>
<script>
import axios from 'axios'
export default {
    data() {
        return {
            tours: [],
            openedTour: null,
            user: null,
            filterKey: 'id_tour',
            tourCancel: null
        };
    },
    async mounted() {
        this.token = localStorage.getItem('token')
        if(!this.token){
            this.$router.push('/auth')
        }
        let response2 = null
        try{
            response2 = await axios.get(import.meta.env.VITE_API_URL + '/get-user-data', {
                headers:{
                    Authorization: 'Bearer ' + this.token
                }
            })
        } catch (error) {
            this.$router.push('/auth')
        }
        this.user = response2.data.user;
        this.fetchStreams()
    },
    methods:{
        logout(){
            localStorage.removeItem('token')
            this.token = null
            this.$router.push('/auth')
        },
        async fetchStreams(){
            const response = await axios.get(import.meta.env.VITE_API_URL + '/get-user-streams', {
                headers:{
                    Authorization: 'Bearer ' + this.token
                }
            })
            this.tours = response.data;
        },
        sortTours(){
            const key = this.filterKey;
            const sortMethods = {
                id_tour: (a,b) => a.id_tour - b.id_tour,
                price: (a,b) => a.price - b.price,
                title: (a,b) => a.title.localeCompare(b.title),
                start_time: (a,b) => new Date(a.start_time) - new Date(b.start_time),
            }
            this.tours.sort(sortMethods[key])
        },
        tourCancelOpen(tourId){
            this.tourCancel = tourId
            document.body.style.overflowY = 'hidden'
        },
        tourCancelClose(){
            this.tourCancel = false
            document.body.style.overflowY = 'auto'
        },
        async tourCancelRequest(tourId){
            let response = await axios.post(import.meta.env.VITE_API_URL + '/user-cancel-tour', {
                "id_tour": tourId
            },
            {
                headers:{
                    Authorization: 'Bearer ' + this.token
                }
            })
            this.tourCancel = null
            document.body.style.overflowY = 'auto'
            this.fetchStreams()
        }
    },
    watch: {
        filterKey(){
            this.sortTours();
        }
    }
};
</script>
<style lang="scss" scoped>
@use './userCabinet.scss';
</style>