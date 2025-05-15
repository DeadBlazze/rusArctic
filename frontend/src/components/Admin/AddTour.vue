<template>
  <div>
    <div class="drop-zone"
         @dragenter.prevent="dragEnter"
         @dragover.prevent="dragOver"
         @dragleave="dragLeave"
         @drop.prevent="drop"
         :class="{ 'drop-zone--active': isDragging }">
      <p>Перетащите файлы сюда или <label for="fileInput">выберите файлы</label></p>
      <input type="file" multiple @change="onFileSelected" id="fileInput" ref="fileInput" style="display: none"/>
    </div>

    <div v-if="selectedFiles.length > 0">
      <h3>Выбранные файлы:</h3>
      <ul>
        <li v-for="(file, index) in selectedFiles" :key="index">
          {{ file.name }} ({{ formatBytes(file.size) }})
        </li>
      </ul>
      <button @click="uploadFiles" :disabled="uploading">
        {{ uploading ? 'Загрузка...' : 'Отправить' }}
      </button>
    </div>

    <div v-if="uploadProgress > 0">
      Загрузка: {{ uploadProgress }}%
    </div>

    <div v-if="uploadMessage">
      {{ uploadMessage }}
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      selectedFiles: [],
      isDragging: false,
      uploadProgress: 0,
      uploading: false,
      uploadMessage: null,
    };
  },
  methods: {
    dragEnter() {
      this.isDragging = true;
    },
    dragOver() {
      // Необходимо для работы drop
    },
    dragLeave() {
      this.isDragging = false;
    },
    drop(event) {
      this.selectedFiles = Array.from(event.dataTransfer.files);
      this.isDragging = false;
    },
    onFileSelected(event) {
      this.selectedFiles = Array.from(event.target.files);
    },
    formatBytes(bytes, decimals = 2) {  // Функция для форматирования размера файла
      if (bytes === 0) return '0 Bytes';
      const k = 1024;
      const dm = decimals < 0 ? 0 : decimals;
      const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    },
    async uploadFiles() {
      this.uploading = true;
      this.uploadProgress = 0;
      this.uploadMessage = null;

      const formData = new FormData();
      this.selectedFiles.forEach(file => {
        formData.append('images[]', file); // [] для множественной загрузки
      });

      // Добавьте другие поля, если нужно
      formData.append('description', 'Описание');

      try {
        const response = await axios.post('/api/upload', formData, {  //  <--- Ваш URL
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          onUploadProgress: progressEvent => { //  <--- Отслеживание прогресса
            this.uploadProgress = Math.round((progressEvent.loaded * 100) / progressEvent.total);
          }
        });

        this.uploadMessage = 'Файлы успешно загружены!';
        console.log('Success:', response.data);
      } catch (error) {
        this.uploadMessage = 'Ошибка при загрузке файлов.';
        console.error('Error:', error);
      } finally {
        this.uploading = false;
      }
    },
  },
};
</script>

<style scoped>
.drop-zone {
  border: 2px dashed #ccc;
  padding: 20px;
  text-align: center;
  cursor: pointer;
  margin-bottom: 20px;
}

.drop-zone--active {
  border-color: #3498db;
}

label {
  cursor: pointer;
  color: #3498db;
}

button:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}
</style>


<!-- <template lang="pug">
    div AddTour
</template>
<script>
export default {
    
}
</script>
<style lang="scss" scoped>
    @use './AddTour.scss' as *;
</style> -->