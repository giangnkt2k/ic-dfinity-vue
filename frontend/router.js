import { def } from "@vue/shared";
import {createRouter, createWebHashHistory} from "vue-router"
import Home from "./pages/home.vue";
import Storage from "./pages/storage.vue";
import myNFT from "./pages/myNFT.vue";
const routes = [
    {
      path: "/",
      name: 'Home',
      component: Home
    },
    {
      path: "/storage",
      name: 'Storage',
      component: Storage
    },
    {
      path: "/myNFT",
      name: 'My NFT',
      component: myNFT
    },
];

const router = createRouter({
  // 4. Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHashHistory(),
  routes, // short for `routes: routes`
})

export default router;