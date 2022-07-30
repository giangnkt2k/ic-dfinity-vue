<template>
    <div class="container mx-auto px-4">
        <div class="navigation mt-8">
            <el-upload
                class="upload-demo"
                action="#"
                :before-upload="beforeAvatarUpload"
                multiple
                :limit="3"
              >
                <el-button size="small" type="primary">
                  Click to upload
                </el-button>
              </el-upload>
        </div>
        
        <div class="list-card"
        v-for="(item,index) in listImage"
        :key="index">
          <Card 
          :prop-url="item.url"
          :prop-name="item.file.name"
          :prop-date="item.file.lastModifiedDate"
          @minting="mintNFT(item)"
          />
        </div>
    </div>
</template>
<script setup lang="ts">
import { ref, onMounted, onBeforeMount, setup, computed, reactive } from 'vue'
import Main from '../../canisters/dip721/main.mo'
import { genFileId } from 'element-plus'
import process from 'process'
import minimist from 'minimist'
import { Web3Storage, getFilesFromPath } from 'web3.storage'
import type { UploadInstance, UploadProps, UploadRawFile } from 'element-plus'
import Card from '../components/Card.vue';
const tokenWeb3 = import.meta.env.VITE_WEB3STORAGE_TOKEN;

const upload = ref<UploadInstance>()
const listImage = ref([]);
var releaseImages = [];
 onMounted(() => {
  getList()
})
const beforeAvatarUpload: UploadProps['beforeUpload'] = async (rawFile) => {
  if (rawFile.size / 1024 / 1024 > 2) {
    ElMessage.error('Avatar picture size can not exceed 2MB!')
    return false
  }
    const token = tokenWeb3;
    const storage = new Web3Storage({ token })
    console.log(`Uploading files`)
    const cid = await storage.put([rawFile])
    console.log('Content added with CID:', cid)
  return true
}

const makeStorageClient = () => {
   const token = tokenWeb3;
   return new Web3Storage({ token: token })
}

const makeGatewayURL = (cid, name) => {
  return `https://${cid}.ipfs.dweb.link/${name}`;
}

const retrieveFiles = async (cid, upload, client) => {
  const res = await client.get(cid)
  if (!res.ok) {
    throw new Error(`failed to get ${cid} - [${res.status}] ${res.statusText}`)
  }
  // unpack File objects from the response
  const files = await res.files()
  for (const file of files) {
    listImage.value.push({
      file: file,
      upload: upload,
      url: makeGatewayURL(cid, file.name)
    })
  }
}

const getList = async () => {
  const client = makeStorageClient()
  for await (const upload of client.list()) {
    retrieveFiles(upload.cid, upload, client);
  }
  return(listImage._rawValue);
}

const mintNFT = async (item) => {
  console.log('minting', item);
  const res = await Main.mint({
    url : item.url,
    name: item.file.name,
    description: item.upload.cid,
    attribute: [item.file]
  })
}
</script>
