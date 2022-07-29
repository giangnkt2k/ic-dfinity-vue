<template>
    <div class="container mx-auto px-4">
        <div class="navigation mt-8">
            <el-upload
                ref="upload"
                class="upload-demo"
                action="#"
                :limit="1"
                :on-exceed="handleExceed"
                :auto-upload="false"
            >
                <template #trigger>
                <el-button class="text-blue-600" type="primary">select file</el-button>
                </template>
                <el-button class="ml-3 text-green-600" type="success" @click="submitUpload">
                upload to server
                </el-button>
                <template #tip>
                <div class="el-upload__tip text-red">
                    limit 1 file, new file will cover the old file
                </div>
                </template>
            </el-upload>
        </div>
        <div class="list-card">

        </div>
    </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { genFileId } from 'element-plus'
import process from 'process'
import minimist from 'minimist'
import { Web3Storage, getFilesFromPath } from 'web3.storage'
import type { UploadInstance, UploadProps, UploadRawFile } from 'element-plus'

const upload = ref<UploadInstance>()
const fileUpload = null;
const handleExceed: UploadProps['onExceed'] = (files) => {
  upload.value!.clearFiles()
  const file = files[0] as UploadRawFile
  file.uid = genFileId()
  fileUpload = upload.value!.handleStart(file)
    console.log('pathFiles',pathFiles)
    console.log('file',upload.value!.handleStart(file))
  
}

const submitUpload = async () => {
    const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweEI2NTkzRjYwODdmYTY3NzE2M0YwNDdEZGMwRDE5YTMxNTBhMTgzOGEiLCJpc3MiOiJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2NTkwNjg2NDI2NjcsIm5hbWUiOiJzdHJvcmFnZUcifQ.X5HhMh2UiYJ_dDELj7c1NP6E3Lgw8KnnjwiBhqjGNtw';
    console.log('upload', upload.value);
    const storage = new Web3Storage({ token })
    const files = []
    console.log('fileUpload',fileUpload)
    const pathFiles = await getFilesFromPath(upload)
    console.log('pathFiles',pathFiles)
//   upload.value!.submit()
}
</script>
