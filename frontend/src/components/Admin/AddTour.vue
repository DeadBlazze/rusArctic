<template>
  <div class="addtour">
    <div class="addtour-inner">
      <h2>Добавление тура</h2>
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
        <p>Потоки на тур (1 обязателен)</p>
        <div class="stream">
          <p>Поток 1</p>
          <div class="stream-date">
            <input type="date" name="" id="date1" v-model="formData.tourStreams[0].date">
            <label for="date1">Дата отправления</label>
          </div>
          <div class="stream-startPoint">
            <input type="text" name="" id="stream-startPoint1" v-model="formData.tourStreams[0].start_point">
            <label for="stream-startPoint1">Точка отправления</label>
          </div>
        </div>
        <div class="stream streamLoop" v-for="(stream, index) in formData.tourStreams.slice(1)" :key="stream.id">
          <p>Поток {{ index+2 }}</p>
          <div class="stream-date">
            <input type="date" name="" :id="'date'+(index+2)" v-model="formData.tourStreams[index+1].date" placeholder="дд.мм.гггг">
            <label :for="'date'+(index+2)">Дата отправления</label>
          </div>
          <div class="stream-startPoint">
            <input type="text" name="" :id="'stream-startPoint'+(index+2)" v-model="formData.tourStreams[index+1].start_point">
            <label :for="'stream-startPoint'+(index+2)">Точка отправления</label>
          </div>
        </div>
        <div class="streams-btns">
          <button @click="addStream()">Добавить</button>
          <button @click="delStream()">Удалить</button>
        </div>
      </div>
      <input type="submit" value="Отправить" @click="sendData()">
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import uploadPhoto from './uploadPhoto.vue';
export default {
  components: {
    uploadPhoto
  },
  data() {
    return {
      formData: {
        tourTitle: '',
        tourRoute: '',
        tourDuration: '',
        tourDescription: '',
        tourPrice: '',
        tourIncludes: '',
        tourStreams: [{id: 0, date: '', start_point: ''}],
      },
      formDataFromChild: null,
      errors: {}
    }
  },
  methods: {
    addStream(){
      const idStream = this.formData.tourStreams.slice(-1)[0].id
      this.formData.tourStreams.push({id: idStream, date: '', start_point: ''})
    },
    delStream(){
      const lastEl = this.formData.tourStreams.length-1
      if(lastEl===0) {return} // первый поток удалять нельзя
      this.formData.tourStreams.splice(lastEl, 1)
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
      this.formDataFromChild.append('json', JSON.stringify(this.formData));
      console.log([...this.formDataFromChild.entries()])
      try {
        const response = await axios.post(import.meta.env.VITE_API_URL+'/admin-create-tour', 
        this.formDataFromChild, 
        {
          headers: {
            'Content-Type': 'multipart/form-data',
            Authorization: 'Bearer ' + localStorage.getItem('token')
          }
        });
        console.log('Success:', response.data);
        alert("Успешно загружено")
        sessionStorage.removeItem('tours')
        this.$router.push('/tours')
      } catch (error) {
        console.error('Error:', error);
        alert("Ошибка загрузки тура")
      }
    },
    validateForm(){
      this.errors = {}
      let valid = true
      if (!/^[А-Яа-яЁёA-Za-z\s\-]{1,100}$/.test(this.formData.tourTitle)) {
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
      if(!this.formData.tourStreams.every(stream => /^[А-Яа-яЁёA-Za-z\s\-\–]{1,100}$/.test(stream.start_point))){
        this.errors.streamsError = 'Названия точек отправления от 1 до 100 символов без !?*^&#$<+""'
        valid = false
      }
      if(!this.formData.tourStreams.every(stream => stream.date.length > 0)){
        this.errors.streamsError = 'У каждого потока должна быть выбрана дата'
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
    @use './AddTour.scss' as *;
</style>