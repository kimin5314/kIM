import {createRouter, createWebHistory} from 'vue-router'
import Cube from '../pages/Cube.vue'

const routes = [
    {
        path:"/cube",
        name:"cube",
        component: Cube
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router