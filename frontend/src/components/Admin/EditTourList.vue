<template lang="pug">
    .tours-list 
        .tour(v-for='tour in this.tours' :key='tour.id_tour')
            .tour__title 
                p {{tour.title}}
            router-link(:to="`/admin/edit-tour/${tour.id_tour}`") Изменить
</template>
<script>
import axios from 'axios'
export default {
    data(){
        return{
            tours: []
        }
    },
    methods: {
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
    @use './EditTourList.scss' as *;
</style>