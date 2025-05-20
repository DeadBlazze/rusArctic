<template>
  <div class="edittour">
    <div class="edittour-inner">
      <h2>Редактирование тура</h2>
      <div class="title">
        <div class="input-group">
          <input type="text" name="" id="tour_title" v-model="formData.tourTitle">
          <label for="tour_title">Заголовок тура</label>
        </div>
      </div>
      <div class="route">
        <div class="input-group">
          <input type="text" name="" id="tour_route" v-model="formData.tourRoute" placeholder='Формат: "Архангельск – Карское море – Новосибирские острова"'>
          <label for="tour_route">Маршрут тура через "–"</label>
        </div>
      </div>
      <div class="duration">
        <div class="input-group">
          <input type="text" name="" id="tour_duration" v-model="formData.tourDuration" placeholder='Формат: "12 дней / 11 ночей"'>
          <label for="tour_duration">Длительность</label>
        </div>
      </div>
      <div class="description">
        <div class="input-group">
          <textarea name="" id="tour_description" v-model="formData.tourDescription" placeholder="До 200 символов"></textarea>
          <label for="tour_description">Описание</label>
        </div>
      </div>
      <div class="price">
        <div class="input-group">
          <input type="text" name="" v-model="formData.tourPrice" id="tour_price">
          <label for="tour_price">Стоимость</label>
        </div>
      </div>
      <div class="includes">
        <div class="input-group">
          <input type="text" name="" id="tour_includes" v-model="formData.tourIncludes" placeholder="До 200 символов">
          <label for="tour_includes">Что включает</label>
        </div>
      </div>
      <uploadPhoto @uploadPhotos="uploadPhotos"></uploadPhoto>
      <div class="streams">
        <p>Потоки на тур</p>
        <template v-if="formData.tourStreams">
            <div class="stream" :class="{'streamLoop': index !== 0}" v-for="(stream, index) in formData.tourStreams" :key="stream">
                <div class="stream-title">
                    <p>Поток {{ index+1 }}</p>
                    <img src='../../assets/images/UI/icons/cross.svg' @click="delStream(index)" title="Удалить поток">
                </div>
                <div class="stream-date">
                    <input type="date" name="" :id="'date'+(index+1)" v-model="formData.tourStreams[index].start_time" placeholder="дд.мм.гггг">
                    <label :for="'date'+(index+1)">Дата отправления</label>
                </div>
                <div class="stream-startPoint">
                    <input type="text" name="" :id="'stream-startPoint'+(index+1)" v-model="formData.tourStreams[index].start_point">
                    <label :for="'stream-startPoint'+(index+1)">Точка отправления</label>
                </div>
            </div>
        </template>
        <div class="streams-btns">
          <button @click="addStream()">Добавить</button>
        </div>
      </div>
      <input type="submit" value="Отправить" @click="sendData()">
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import uploadPhoto from './uploadPhoto.vue';
export default {
    components: {
        uploadPhoto
    },
    data(){
        return {
            id_tour: null,
            tour: null,
            formData: {
              tourTitle: '',
              tourRoute: '',
              tourDuration: '',
              tourDescription: '',
              tourPrice: '',
              tourIncludes: '',
              tourStreams: [],
              id_tour: null
            },
            formDataFromChild: null,
            errors: {}
        }
    },
    async mounted() {
        this.id_tour = this.$route.params.id_tour

        const response2 = await axios.post(import.meta.env.VITE_API_URL + '/get-streams',
        {
            'id_tour': this.id_tour
        })
        this.formData.tourStreams = response2.data
        const cachedTours = sessionStorage.getItem('tours');
        if(cachedTours){
            this.tour = JSON.parse(cachedTours).find(tour => tour.id_tour ===  Number(this.id_tour))
        }
        else{
            try{
                const response = await axios.get(import.meta.env.VITE_API_URL + '/get-tours', {
                        headers: {
                            Authorization: 'Bearer ' + localStorage.getItem('token'),
                        },
                    })
                const tours = response.data   
                this.tour = tours.find(tour => tour.id_tour ===  Number(this.id_tour))
                sessionStorage.setItem('tours', JSON.stringify(tours));
            }catch(error){
                console.error('Ошибка при получении туров:', error.message)
            }
        }
        if(this.tour){ // Захват данных в поля формы
            this.formData.tourTitle = this.tour.title
            this.formData.tourRoute = this.tour.route
            this.formData.tourDuration = this.tour.duration
            this.formData.tourDescription = this.tour.description
            this.formData.tourPrice = this.tour.price
            this.formData.tourIncludes = this.tour.includes
        }
    },
    methods: {
        addStream(){
            this.formData.tourStreams.push({date: '', start_point: ''})
            console.log(this.formData.tourStreams)
        },
        delStream(index){
            this.formData.tourStreams.splice(index, 1)
        },
        uploadPhotos(formData){
        this.formDataFromChild = formData
        },
        async sendData(){
          if(!this.validateForm()){
              const errorMessages = 'Исправьте ошибки в форме: \n'+ Object.values(this.errors).join('\n');
              alert(errorMessages);
              return
          }
          this.formDataFromChild.delete('json');
          this.formData.id_tour = this.id_tour
          this.formDataFromChild.append('json', JSON.stringify(this.formData));
          console.log([...this.formDataFromChild.entries()])
          try {
            const response = await axios.post(import.meta.env.VITE_API_URL+'/admin-edit-tour', 
            this.formDataFromChild, 
            {
            headers: {
              'Content-Type': 'multipart/form-data',
              Authorization: 'Bearer ' + localStorage.getItem('token')
            }
            });
            console.log('Success:', response.data);
            alert("Данные обновлены")
            sessionStorage.removeItem('tours')
            this.$router.push('/tours')
          } catch (error) {
              console.error('Error:', error);
              alert("Ошибка обновления тура: " + error.response.data?.msg || '')
          }
        },
        validateForm(){
            this.errors = {}
            let valid = true
            if (!/^[А-Яа-яЁёA-Za-z\s\-:]{1,100}$/.test(this.formData.tourTitle)) {
                this.errors.tourTitle = 'Заголовок от 1 до 100 символов без !?*^&#$<+'
                valid = false
            }
            if (!/^[А-Яа-яЁёA-Za-z\s\-\–]{1,100}$/.test(this.formData.tourRoute)) {
                this.errors.tourRoute = 'Маршрут от 1 до 100 символов без !?*^&#$<+'
                valid = false
            }
            if (!/^[А-Яа-яЁёA-Za-z0-9\s\/]{1,100}$/.test(this.formData.tourDuration)) {
                this.errors.tourDuration = 'Длительность от 1 до 100 символов без !?*^&#$<+-'
                valid = false
            }
            if (!/^[А-Яа-яЁёA-Za-z\s./(),\-\–]{1,200}$/.test(this.formData.tourDescription)) {
                this.errors.tourDescription = 'Описание от 1 до 200 символов без !?*^&#$<+-""'
                valid = false
            }
            if (!/^[0-9]{1,10}$/.test(this.formData.tourPrice)) {
                this.errors.tourPrice = 'Стоимость целое число без пробелов'
                valid = false
            }
            if (!/^[А-Яа-яЁёA-Za-z\s./(),]{1,200}$/.test(this.formData.tourIncludes)) {
                this.errors.tourIncludes = 'Что включает от 1 до 200 символов без !?*^&#$<+-""'
                valid = false
            }
            if(!this.formData.tourStreams.every(stream => /^[А-Яа-яЁёA-Za-z\s\-–]{1,100}$/.test(stream.start_point))){
                this.errors.start_point = 'Названия точек отправления от 1 до 100 символов без !?*^&#$<+""'
                valid = false
            }
            if(!this.formData.tourStreams.every(stream => stream.start_time)){
                this.errors.start_time = 'У каждого потока должна быть выбрана дата'
                valid = false
            }
            if(!this.formDataFromChild){
                this.errors.formDataFromChild = 'Загрузите от 1 до 4 картинок'
                valid = false
            }
            return valid    
        }
  }
}
</script>
<style lang="scss" scoped>
    @use './EditTour.scss' as *;
</style>