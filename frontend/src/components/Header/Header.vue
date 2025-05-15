<template lang="pug">
header.header__inner
    .tel 
        a(href="tel:+78182653858") +7 (8182) 65-38-58
        span Сообщить о пожарах, ЧС, отходах на территории, иных нарушениях
    .logo
        router-link(to="/")
            img(src='../../assets/images/header/logo.png')
    img.burger-button(src="../../assets/images/header/burger-menu.svg" alt="alt" @click="toggleBurgerMenu()")
    nav
        ul 
            li 
                router-link(to="/#about") О нас
            li 
                router-link(to="/tours") Туры
            li
                router-link(to="/contacts") Контакты
    .header__lk
        router-link(:to="!isAdmin ? '/user-cabinet' : '/admin'")
            .header__lk-buttons
                span Личный кабинет
                img(src='../../assets/images/header/lk-icon.svg')
    transition(name="fade")
        .header__mobile(v-if='isMobile')
            ul  
                li 
                    router-link(to="/" @click="toggleBurgerMenu()") Главная
                li 
                    a(href="/#about" @click="toggleBurgerMenu()") О нас
                li 
                    router-link(to="/tours" @click="toggleBurgerMenu()") Туры
                li
                    router-link(to="/contacts" @click="toggleBurgerMenu()") Контакты
            img.header__mobile-cross(src="../../assets/images/header/cross.svg" @click="toggleBurgerMenu()")
</template>

<script setup>
import './header.scss'
import { ref, computed } from 'vue'
const userRole = ref(localStorage.getItem('userRole') || 'user'); // Начальное значение роли
let isMobile = ref(false);
const isAdmin = computed(() => userRole.value === 'admin');

const setUserRole = (newRole) => { // Сеттер
    userRole.value = newRole;
    localStorage.setItem('userRole', newRole); // Сохраняем в localStorage
};

const unsetRole = ()=>{
    userRole.value = 'user'
    localStorage.removeItem('userRole')
}

defineExpose({
    setUserRole, unsetRole
});

const toggleBurgerMenu = () => {
    isMobile.value = !isMobile.value
}
</script>