import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Layout from "../layout/Layout.vue";
import User from "../views/User.vue";
import Register from "../views/Register";
import Person from "../views/Person";
import Storage from "../views/Storage"
import Customer from "../views/Customer";
import Cart from "../views/Cart";
import Order from "../views/Order";
import Log from "../views/Log";
import Pay from "@/views/Pay.vue";
import ItemChart from "@/views/ItemChart.vue";
import UnreceivedPackages from "@/views/UnreceivedPackages.vue";
import ReceivedPackages from "@/views/ReceivedPackages.vue";

const routes = [
  {
    path: '/',
    name: 'Layout',
    component: Layout,
    redirect: "/login",
    children:[
      {
        path: '/user',
        name: 'User',
        component: User
      }  ,
      {
        path: '/storage',
        name: 'Storage',
        component: Storage
      },

      {
        path: '/customer',
        name: 'Customer',
        component: Customer
      },
      {
        path: '/cart',
        name: 'Cart',
        component: Cart
      },
      {
        path: '/order',
        name: 'Order',
        component: Order
      },
      {
        path: '/log',
        name: 'Log',
        component: Log
      }
      ,
      {
        path: '/pay',
        name: 'Pay',
        component: Pay
      }
      ,
      {
        path:'/ItemChart',
        name: 'ItemChart',
        component: ItemChart
      }
      ,
      {
        path: '/UnreceivedPackages',
        name:'UnreceivedPackages',
        component: UnreceivedPackages
      }
      ,
      {
        path: '/ReceivedPackages',
        name:'ReceivedPackages',
        component: ReceivedPackages
      }


    ]
  },

  {
    path: '/person',
    name: 'Person',
    component: Person
  }
  ,
  {
    path: '/login',
    name: 'Login',
    component: Login
  }
  ,
  {
    path: '/register',
    name: 'Register',
    component: Register
  }


]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
