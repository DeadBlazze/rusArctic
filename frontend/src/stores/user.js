import { defineStore } from "pinia";

export const useUserStore = defineStore('user', {
    state: ()=> ({userRole: 'user'}),
    getters: {
        isAdmin: (state) => state.userRole === 'admin'
    },
    actions: {
        setUserRole(role) {
            this.userRole = role;
        },
        unsetRole() {
            this.userRole = '';
        }
    }
});