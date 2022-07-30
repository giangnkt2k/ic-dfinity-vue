<template>
    <div>
        <el-card :body-style="{ padding: '0px' }">
        <img
          :src="propUrl"
          class="image"
        />
        <div style="padding: 14px">
          <span>{{ propName }}</span>
          <div class="bottom">
            <time class="time">{{ propDate }}</time>
            <el-button @click="minting" text class="button">Mint NFT</el-button>
          </div>
        </div>
      </el-card>
    </div>
</template>
<script lang="ts" setup>
import { ref } from 'vue'

const currentDate = ref(new Date())
const props = defineProps({
  propUrl: String,
  propName: String,
  propDate: [String , Date]
})
const emit = defineEmits(['minting'])

const minting = () => {
  emit('minting');
}

</script>

<style>
.time {
  font-size: 12px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.button {
  padding: 0;
  min-height: auto;
}

.image {
  width: 100%;
  display: block;
}
</style>