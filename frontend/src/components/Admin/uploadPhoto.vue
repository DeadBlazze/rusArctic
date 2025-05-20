<template lang="">
    <div class="photo">
        <p class="photo__title">Фотографии для тура (от 1 до 4): </p>
        <div class="drop-zone"
             @dragenter.prevent="dragEnter"
             @dragover.prevent="dragOver"
             @dragleave="dragLeave"
             @drop.prevent="drop"
             :class="{ 'drop-zone--active': isDragging }">
          <p>Перетащите файлы сюда или <label for="fileInput">выберите файлы</label></p>
          <input type="file" multiple @change="onFileSelected" id="fileInput" ref="fileInput" style="display: none"/>
        </div>
        <div v-if="selectedFiles.length > 0" class="selectedFiles">
          <h3>Выбранные файлы:</h3>
          <ul>
            <li v-for="(file, index) in selectedFiles" :key="index">
              {{ file.name }} ({{ formatBytes(file.size) }})
            </li>
          </ul> 
        </div>
        <div v-if="uploadMessage" class="uploadMessage">
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
      maxFiles: 4,
      maxSizeMB: 4,
      allowedTypes: ['image/png', 'image/jpeg', 'image/jpg', 'image/webp'],
    };
  },
  methods: {
    dragEnter() {
      this.isDragging = true;
    },
    dragOver() {
      this.isDragging = true;
    },
    dragLeave() {
      this.isDragging = false;
    },
    drop(event) {
      const files = Array.from(event.dataTransfer.files);
      this.validateAndSetFiles(files);
      this.isDragging = false;
    },
    onFileSelected(event) {
      try {
        const files = Array.from(event.target.files);
        this.validateAndSetFiles(files);
      } catch (e) {
        console.error('Ошибка в onFileSelected:', e);
      }
    },
    validateAndSetFiles(files) {
      this.uploadMessage = null
      if (!files || !files.length) return;

      const maxSizeBytes = this.maxSizeMB * 1024 * 1024;
      if (files.length > this.maxFiles) {
        this.uploadMessage = `Можно загрузить максимум ${this.maxFiles} файла.`;
        return;
      }

      const hasInvalid = files.some(file => {
        if (!file || !file.type) return true;
        return file.size > maxSizeBytes || !this.allowedTypes.includes(file.type);
      });

      if (hasInvalid) {
        this.uploadMessage = `Допустимы только файлы PNG, JPEG, JPG, WEBP до ${this.maxSizeMB} МБ.`;
        return;
      }

      this.selectedFiles = files;
      this.uploadFiles();
    },
    formatBytes(bytes, decimals = 2) {  // Функция для форматирования размера файла
      if (bytes === 0) return '0 Bytes';
      const k = 1024;
      const dm = decimals < 0 ? 0 : decimals;
      const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    },
    uploadFiles() {
      this.uploading = true;
      this.uploadMessage = null;

      const formData = new FormData();
      this.selectedFiles.forEach(file => {
        formData.append('images[]', file); // [] для множественной загрузки
      });

      this.$emit('uploadPhotos', formData)
      this.uploading = false;
    },
  },
};
</script>
<style lang="scss" scoped>
    .photo{
      margin: 10px 0;
      &__title{
        margin-bottom: 10px;
      }
      .drop-zone {
        border: 2px dashed #ccc;
        padding: 50px 0;
        text-align: center;
        cursor: pointer;
        p{
          label {
            cursor: pointer;
            color: #3498db;
          }
        }
      }
      .drop-zone--active {
        border-color: #3498db;
      }
      button:disabled {
        cursor: not-allowed;
        opacity: 0.5;
      }
      .uploadMessage{
        color: red;
        margin-top: 5px;
      }
      .selectedFiles,.uploadProgress {
        margin-top: 5px;
        button.sendPhoto{
          height: fit-content;
          padding: 5px 10px;
          margin-top: 5px;
          border: 1px solid gray;
          border-radius: 3px;
          font-size: 13.3px;
        }
      }
    }
</style>