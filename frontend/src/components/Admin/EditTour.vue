<template lang="pug">
    div.edittour 123
</template>
<script>
export default {
    mounted() {
        console.log('ID тура:', this.$route.params.id_tour)
    }
}
</script>
<style lang="scss" scoped>
    @use './EditTour.scss' as *;
</style>