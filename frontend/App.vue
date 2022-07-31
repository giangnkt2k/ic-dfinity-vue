<script setup>
/*
 * Connect2ic provides essential utilities for IC app development
 */
import { createClient } from "@connect2ic/core"
import { defaultProviders } from "@connect2ic/core/providers"
import { ConnectButton, ConnectDialog, Connect2ICProvider } from "@connect2ic/vue"
import "@connect2ic/core/style.css"
import Menu from "./components/Menu.vue";
import { PlugWallet } from "@connect2ic/core/providers/plug-wallet"
import Profile from "./components/Profile.vue"
import { useRouter, useRoute } from 'vue-router'
import { ref, watch } from 'vue'


const router = useRouter()
const currentRoute =  ref(router)
console.log('currentRoute',currentRoute)
const client = createClient({

  providers: [new PlugWallet()],
  globalProviderConfig: {
    dev: import.meta.env.VITE_DEV,
  },
}) 

</script>

<template>
  <div class="main">
  <div class="header-main">
   <Menu />
  </div>
   <div class="banner">
        <p style="margin-top: 100px;" class="text-zinc-500 text-lg font-medium">{{currentRoute.currentRoute.name}}</p>
   </div>
  <router-view></router-view>
   <Connect2ICProvider :client="client">
      <div class="auth-section">
        <ConnectButton :onConnect="(async () => {
          try {
            const publicKey = await window.ic.plug.requestConnect();
            console.log(`The connected user's public key is:`, publicKey);
          } catch (e) {
            console.log(e);
          }
})()" />
      </div>
      <ConnectDialog />
      <div style="margin: auto;padding: 30px 100px;">
        <Profile />
      </div>
  </Connect2ICProvider>
  </div>
</template>

<style>
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
  "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
  sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #424242;
  background-color:#f6f6f6;
}

button {
  font-weight: 600;
}

.slogan {
  font-size: 1.7em;
  margin-bottom: 0;
}

.twitter {
  font-size: 0.4em;
}

.App-logo {
  height: 14vmin;
  pointer-events: none;
  transform: scale(1);
  animation: pulse 3s infinite;
}

.App-header {
  height: calc(100vh - 70px);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
}

.examples {
  padding: 30px 100px;
  display: grid;
  grid-gap: 30px;
  grid-template-columns: 1fr 1fr 1fr;
}

.examples-title {
  font-size: 1.3em;
  margin-bottom: 0;
  text-align: center;
}

.example {
  padding: 50px 50px;
  min-height: 300px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  /*border: 1px solid black;*/
  /*background: #f4f4f4;*/
  border-radius: 15px;
}

.example-disabled {
  font-size: 1.3em;
  color: #9e9e9e;
}

.demo-button {
  background: #a02480;
  padding: 0 1.3em;
  margin-top: 1em;
  border-radius: 60px;
  font-size: 0.7em;
  height: 35px;
  outline: 0;
  border: 0;
  cursor: pointer;
  color: white;
}

.demo-button:active {
  color: white;
  background: #979799;
}

.auth-section {
  padding: 1em;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  text-align: right;
  position: fixed;
  top: 60px !important;
  right: 0;
}
.banner {
  width: 100%;
  height: 400px;
  margin-top: 40px;
  text-align: center;
  background: url('./assets/banner-bg.9aa89a17.png') no-repeat;
  background-position: 50%;
  padding: 40px 0;
}
.nav-link {
  border: none;
  text-decoration: auto;
}
.header-main {
  background: #fff;
  box-shadow: 0 10px 9px rgb(17 17 17 / 2%);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 99;
  width: 100%;
}
@keyframes pulse {
  0% {
    transform: scale(0.97);
    opacity: 0;
  }

  70% {
    transform: scale(1);
    opacity: 1;
  }

  100% {
    transform: scale(0.97);
    opacity: 0;
  }
}
</style>
