import { def } from "@vue/shared";
import {createRouter, createWebHashHistory} from "vue-router"
import Home from "./pages/home.vue";
const routes = [
    {
        path: "/home",
        component: Home
    }
];

const router = createRouter({
  // 4. Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHashHistory(),
  routes, // short for `routes: routes`
})

export default router;