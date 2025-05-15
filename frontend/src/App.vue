<template lang="pug">
  Header(ref='header')
  router-view
  Footer
</template>
<script>
import Header from './components/Header/Header.vue'
import Footer from './components/Footer/Footer.vue';
export default{
  name: 'App',
  components:{
    Header,
    Footer
  }
}
</script>