// import { defineStore } from "pinia";
// import { ref } from 'vue';

// export const useUserStore = defineStore('user', ()=>{
//     const userRole = ref(localStorage.getItem('userRole') || 'user');

//     const isAdmin = () => userRole.value === 'admin';

//     function setUserRole(role) {
//         userRole.value = role;
//         localStorage.setItem('userRole', role);
//     }

//     function unsetRole() {
//         userRole.value = '';
//         localStorage.removeItem('userRole');
//     }

//     return { userRole, isAdmin, setUserRole, unsetRole };
// });