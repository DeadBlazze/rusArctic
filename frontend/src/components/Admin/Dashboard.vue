<template lang="pug">
    .admin-dashboard 
        router-link(to="/admin/add-tour") Добавить тур
        router-link(to="/admin/edit-tour-list") Редактировать тур
        router-link(to="/admin/delete-tour") Удалить тур
</template>
<script>
export default {
    
}
</script>
<style lang="scss">
    @use './Dashboard.scss' as *;
</style>