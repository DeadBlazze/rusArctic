<template lang="pug">
    .tours-list 
        .tour(v-for='tour in this.tours' :key='tour.id_tour')
            .tour__title 
                p {{tour.title}}
            button(@click="deleteTour(tour.id_tour)") Удалить
    .delete-confirm__modal(v-if='deleteClick')
            .modal__inner
                .modal__title
                    h3 Удалить тур?
                    img(src='../../assets/images/UI/icons/cross.svg' @click="confirmDelete(false)")
                .modal__buttons
                    button(@click='confirmDelete(true)') Да
                    button(@click='confirmDelete(false)') Нет
</template>
<script>
import axios from 'axios'
export default {
    data(){
        return{
            tours: [],
            deleteClick: null,
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
        },
        async deleteTour(id_tour){
            this.deleteClick = id_tour
            document.body.style.overflowY = 'hidden'
        },
        async confirmDelete(userSelect){
            if(userSelect){
                try {
                    const response = await axios.post(import.meta.env.VITE_API_URL + '/admin-delete-tour', 
                    {
                        'id_tour': this.deleteClick
                    }
                    ,{
                        headers: {
                            Authorization: 'Bearer ' + localStorage.getItem('token'),
                        },
                    })
                    alert('Тур удалён успешно')
                    sessionStorage.removeItem('tours')
                    this.$router.push('/tours')
                } catch (error) {
                    alert('Ошибка при удаления тура: ' + (error.response?.data?.msg || error.message))
                }
            }
            this.deleteClick = null
            document.body.style.overflowY = 'auto'
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
@use './DeleteTour.scss' as *;
</style>