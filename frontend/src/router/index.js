import { createRouter, createWebHistory } from 'vue-router';
import Home from '../pages/Home/Home.vue';
import Tours from '../pages/Tours/Tours.vue';
import Contacts from '../pages/Contacts/Contacts.vue';
import Reg from '../pages/Reg/Reg.vue';
import Login from '../pages/Login/Login.vue';
import UserCabinet from '../pages/UserCabinet/UserCabinet.vue';

import Admin from '../pages/Admin/Admin.vue';
import AdminRequests from '../components/Admin/AdminRequests.vue';
import Dashboard from '../components/Admin/Dashboard.vue';
import AddTour from '../components/Admin/AddTour.vue';
import EditTour from '../components/Admin/EditTour.vue';
import EditTourList from '../components/Admin/EditTourList.vue';
import DeleteTour from '../components/Admin/DeleteTour.vue';
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/tours',
      component: Tours
    },
    {
      path: '/contacts',
      component: Contacts
    },
    {
      path: '/reg',
      component: Reg
    },
    {
      path: '/auth',
      component: Login
    },
    {
      path: '/user-cabinet',
      component: UserCabinet
    },
    {
      path: '/admin',
      component: Admin,
      children: [
        {
          path: '',
          component: AdminRequests
        },
        {
          path: 'dashboard',
          component: Dashboard
        },
        {
          path: 'add-tour',
          component: AddTour
        },
        {
          path: 'edit-tour-list',
          component: EditTourList
        },
        {
          path: 'edit-tour/:id_tour',
          component: EditTour
        },
        {
          path: 'delete-tour',
          component: DeleteTour
        },
      ]
    },
  ],
  scrollBehavior(to, from, savedPosition) {
    if (to.hash) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({
            el: to.hash,  // Используем 'el' вместо 'selector' в Vue Router v4
            behavior: 'smooth',
          });
        }, 100);
      });
    } else if (savedPosition) {
      return savedPosition;
    } else {
      return { top: 0 }  // Используем 'top' вместо 'x' и 'y' в Vue Router v4
    }
  }
});

export default router; 