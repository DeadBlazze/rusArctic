import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { plugin as VueTippy } from 'vue-tippy'
import {createPinia} from 'pinia'
const pinia = createPinia()

createApp(App).use(router).use(VueTippy).use(pinia).mount('#app')
