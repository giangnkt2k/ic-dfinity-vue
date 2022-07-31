<template>
  <el-menu
    :default-active="activeIndex"
    class="el-menu-demo"
    mode="horizontal"
    :ellipsis="false"
    @select="handleSelect"
    
  >
    <el-menu-item index="0">
      <img :src="logo" class="Menu-logo" alt="logo" />
    </el-menu-item>
    <div class="flex-grow" />
    <el-menu-item index="1">
    <router-link class="nav-link" to="/storage">Storage</router-link>
    </el-menu-item>
    <el-menu-item index="1.2">
    <router-link class="nav-link" to="/myNFT">My NFT</router-link>
    </el-menu-item>
    <el-menu-item index="1.3">
    <router-link class="nav-link" to="/customer">Customer</router-link>
    </el-menu-item>
  </el-menu>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import logo from "../assets/logo-menu.svg"
const activeIndex = ref('1')
const handleSelect = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
</script>

<style>
.flex-grow {
  flex-grow: 1;
}
.el-menu-demo {
  max-width: 1156px;
  margin: auto;
  border: none;
}
.el-menu {
  margin: auto !important;
}
.el-menu--horizontal {
  border: none !important;
}
.Menu-logo {
  margin-top: 5px;
  height: 4vmin;
  pointer-events: none;
  transform: scale(1);
  animation: pulse 3s infinite;
}

@media only screen and (max-width: 600px) {
  .Menu-logo {
    display: none;
  }
}
</style>
