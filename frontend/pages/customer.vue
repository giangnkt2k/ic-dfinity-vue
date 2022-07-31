<template>
  <div class="container mx-auto px-4">
    <div class="mb-4">
      <el-button @click="openCreate">Create</el-button>
    </div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column fixed prop="id" label="ID" width="150" />
      <el-table-column prop="full_name" label="Name" />
      <el-table-column prop="date" label="Birthday" />
      <el-table-column prop="phone" label="Phone" />
      <el-table-column prop="sex" label="Sex" />
      <el-table-column prop="address" label="Sex" />
      <el-table-column fixed="right" label="Operations" width="120">
        <template #default="scope">
          <el-button link type="primary" size="small" @click="handleClickEdit(scope.row)"
            >Edit</el-button
          >
          <el-button link type="primary" size="small" @click="handleDelete(scope.row)"
            >Delete</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <el-dialog v-model="dialogFormVisible" :before-close="resetForm" title="Edit customer">
      <el-form :model="formData">
        <el-form-item label="First name" :label-width="formLabelWidth">
          <el-input v-model="formData.first_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Last name" :label-width="formLabelWidth">
          <el-input v-model="formData.last_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Sex" :label-width="formLabelWidth">
          <el-radio-group v-model="formData.sex">
            <el-radio :label="true">Male</el-radio>
            <el-radio :label="false">Female</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="Birthday" :label-width="formLabelWidth">
          <el-date-picker
            v-model="formData.date"
            type="date"
            placeholder="Pick a day"
            size="small"
          />
        </el-form-item>
        <el-form-item label="Phone" :label-width="formLabelWidth">
          <el-input v-model="formData.phone" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Address" :label-width="formLabelWidth">
          <el-input v-model="formData.address" autocomplete="off" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisible = false">Cancel</el-button>
          <el-button type="primary" @click="confirmEdit">Confirm</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog
      v-model="dialogFormVisibleDelete"
      title="Notice"
      width="30%"
      destroy-on-close
      center
    >
      <span>Do you want to delete this account</span>
      <div>
        <strong>????</strong>
      </div>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisibleDelete = false">Cancel</el-button>
          <el-button type="primary" @click="confirmDelete">Confirm</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog v-model="dialogFormVisibleCreate" :before-close="resetForm" title="Create customer">
      <el-form :model="formData">
        <el-form-item label="First name" :label-width="formLabelWidth">
          <el-input v-model="formData.first_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Last name" :label-width="formLabelWidth">
          <el-input v-model="formData.last_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Sex" :label-width="formLabelWidth">
          <el-radio-group v-model="formData.sex">
            <el-radio :label="true">Male</el-radio>
            <el-radio :label="false">Female</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="Birthday" :label-width="formLabelWidth">
         <el-input v-model="formData.date" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Phone" :label-width="formLabelWidth">
          <el-input v-model="formData.phone" autocomplete="off" />
        </el-form-item>
        <el-form-item label="Address" :label-width="formLabelWidth">
          <el-input v-model="formData.address" autocomplete="off" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisibleCreate = false">Cancel</el-button>
          <el-button type="primary" @click="handleCreate"
            >Confirm</el-button
          >
        </span>
      </template>
    </el-dialog>
  </div>
</template>
<script lang="ts" setup>
import { reactive, ref, onMounted } from "vue";
import {manage} from 'canisters/manage';
const dialogFormVisible = ref(false);
const dialogFormVisibleDelete = ref(false);
const dialogFormVisibleCreate = ref(false);
const idDel = ref();
const formLabelWidth = "140px";
 onMounted(() => {
  getList()
})
const formData = reactive({
  id: "",
  first_name: "",
  last_name: "",
  full_name: "",
  date: "",
  phone: "",
  sex: "",
  address: "",
});
const resetForm = () => {
  formData.id ='';
  formData.first_name = '';
  formData.last_name = '';
  formData.full_name = '';
  formData.date = '';
  formData.phone = '';
  formData.sex = '';
  formData.address = '';
};

const handleClickEdit = (scope) => {
  console.log("click", dialogFormVisible);
  formData.id = scope.id;
  formData.first_name = scope.first_name;
  formData.last_name = scope.last_name;
  formData.full_name = scope.first_name + " " + scope.last_name;
  formData.date = scope.date;
  formData.phone = scope.phone;
  formData.sex = scope.sex;
  formData.address = scope.address;
  dialogFormVisible.value = true;
};

const confirmEdit = async () => {
    try {
        const res = await manage.updateAccount(formData)
        console.log(res)
    } catch (e) {
        console.log(e)
    }
}

const handleDelete = (scope) => {
  console.log("click22", scope.id);
  dialogFormVisibleDelete.value = true;
  idDel.value = scope.id;

};

const confirmDelete = async () => {
  console.log("idDel", idDel.value);
    try {
        const res = await manage.deleteAccount(idDel.value);
  } 
  catch(e) {
    console.log(e)
  }

  dialogFormVisibleDelete.value = false;
};

const openCreate = () => {
  dialogFormVisibleCreate.value = true;
};

const tableData = ref([]);
const handleCreate = async () => {
    try {
        
        const res = await manage.createAccount({
            first_name : formData.first_name,
            last_name : formData.last_name,
            full_name : 'abc',
            date : formData.date,
            phone : formData.phone,
            sex : formData.sex,
            address : formData.address
         })
        console.log('res',res)
         await  getList()
    } catch (e) {
        console.log(e)
    }
}

const getList = async () => {
    try {
        const res = await manage.readAccount()
        console.log('getList', res)
        tableData.value = res
    } catch (e) {

    }
} 
</script>
<style lang=""></style>
