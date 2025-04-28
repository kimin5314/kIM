import {createRouter, createWebHistory} from 'vue-router'
import Cube from '../pages/Cube.vue'
import CutImage from '../pages/CutImage.vue'
import Test from '../pages/Test.vue'

const routes = [
    {
        path:"/cube",
        name:"cube",
        component: Cube
    },
    {
        path:"/cut",
        name:"cut",
        component: CutImage
    },
    {
        path:"/test",
        name:"test",
        component: Test
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router