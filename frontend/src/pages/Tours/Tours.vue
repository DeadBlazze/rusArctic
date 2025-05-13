<template lang="pug">
h1 Туры по Русской Арктике
.tours
    .tour(v-for="tour, index in this.tours" :key="tour.id")
        .swiper__inner
            swiper(:modules="modules" :slides-per-view="1" :space-between="50" navigation)
                swiper-slide(v-for="image in tour.images" :key="tour.id + '123'")
                    img.tour__cover(:src="getImageSrc(image)")
        h2 {{tour.title}}
        span.tour__route {{tour.route}}
        .tour__time-price 
            .tour__time
                img(src='../../assets/images/tours/clock.svg')
                span {{tour.duration}}
            .tour__price 
                span(v-tippy="{content: tour.includes, theme: 'custom',  animation: 'scale',arrow: true,interactive: true}") Стоимость {{tour.price}}
        .tour__p 
            p {{tour.description}}
        .tour__buttons 
            button.tour__buttons-first(@click='handleRequest(tour)') Оставить заявку
            button.tour__buttons-last Отзывы
    .submitModal__inner(v-if="this.showSubmitModal")
        form.submitModal(@submit.prevent='sendData')
            .submitModal__title
                h2 Подтвердите заявку
                img(src='../../assets/images/UI/icons/cross.svg' @click="handleRequestClose()")
            p.tour-title {{this.selectedTour.title}}
            .submitModal__data__inner
                .data(v-for='stream in this.selectedTour.streams' :key="stream.id")
                    .date
                        input(type='radio' name='stream' :value='stream.id_stream' v-model='selectedStreamId' required)
                        p Точка отправления: {{stream.start_point}}
                    p Дата отправления: {{stream.start_time}}
            button(type='submit') Подтвердить
</template>
<script>
import axios from 'axios';
import { Navigation} from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';
import 'swiper/css/navigation';
export default {
    components: {
      Swiper,
      SwiperSlide,
    },
    data() {
        return {
            showSubmitModal: false,
            selectedTour:[],
            tours:[],
            modules: [Navigation],
            selectedStreamId: null,
            token: null
            }
    },
    methods: {
        getImageSrc(image) {
            return `${import.meta.env.VITE_API_IMAGES}/${image}`;
            // return new URL(`../../assets/images/tours/${image}`, import.meta.url).href;
        },
        async fetchTours() {
            try {
                const response = await axios.get(import.meta.env.VITE_API_URL + '/get-tours', {
                    headers: {
                    Authorization: 'Bearer ' + localStorage.getItem('token'),
                    },
                })
                this.tours = response.data
                sessionStorage.setItem('tours', JSON.stringify(this.tours));
            } catch (error) {
                console.error('Ошибка при получении туров:', error)
            }
        },
        async handleRequest(tour){
            this.selectedTour = tour
            try {
                const response = await axios.post(import.meta.env.VITE_API_URL + '/get-streams', {
                    "id_tour": tour.id_tour
                })
                // this.selectedTour.streams = response.data
                this.selectedTour.streams = response.data.map(stream => {
                    const [year, month, day] = stream.start_time.split('-');
                    return {
                        ...stream,
                        start_time: `${day}.${month}.${year}`
                    };
                });
            } catch (error) {
                console.error('Ошибка при получении расписания туров:', error)
            }
            this.showSubmitModal = true
            document.body.style.overflowY = 'hidden'
        },
        handleRequestClose(tour){
            this.showSubmitModal = false
            document.body.style.overflowY = 'auto'
        },
        async sendData(){
            this.token = localStorage.getItem('token')
            if(!this.token){
                this.$router.push('/auth')
                return
            }
            let success = false
            try{
                await axios.post(import.meta.env.VITE_API_URL+'/record-user-stream',{
                    "id_stream":this.selectedStreamId
                },
                {
                headers:{
                    Authorization: 'Bearer ' + this.token
                }})
                success = true
            }
            catch (err){
                alert(err.response.data.err || 'Ошибка: '+err)
            }
            finally{
                this.selectedStreamId = null
                this.showSubmitModal = false
                document.body.style.overflowY = 'auto'
                
                setTimeout(() => {
                    if(success){
                        alert('Вы успешно записались на тур')
                    }
                },0)
            }
        }
    },
    async mounted() {
        const cachedTours = sessionStorage.getItem('tours');
        if(cachedTours){
            this.tours = JSON.parse(cachedTours);
        }else {
            this.fetchTours();
        }
    },
}
</script>
<style lang="scss" scoped>
@use './tours.scss' as *;

</style>