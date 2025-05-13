import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import pug from 'vite-plugin-pug';
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(),pug(),vueDevTools()],
//   server: {
//     proxy: {
//       // Прокси для картинок из Laravel /public/data
//       '/data': {
//         target: 'http://127.0.0.1:8000/', // твой Laravel
//         changeOrigin: true,
//       }
//   }
// }
})
