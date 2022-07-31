<template>
  <div class="container mx-auto px-4">
    <div class="mb-4">
      <el-button @click="openCreate">Create</el-button>
    </div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column fixed prop="id" label="ID" width="150" />
      <el-table-column prop="full_name" label="Name" />
      <el-table-column prop="birthday" label="Birthday" />
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
            <el-radio :label="0">Male</el-radio>
            <el-radio :label="1">Female</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="Birthday" :label-width="formLabelWidth">
          <el-date-picker
            v-model="formData.birthday"
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
          <el-button type="primary" @click="dialogFormVisible = false">Confirm</el-button>
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
            <el-radio :label="0">Male</el-radio>
            <el-radio :label="1">Female</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="Birthday" :label-width="formLabelWidth">
          <el-date-picker
            v-model="formData.birthday"
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
          <el-button @click="dialogFormVisibleCreate = false">Cancel</el-button>
          <el-button type="primary" @click="dialogFormVisibleCreate = false"
            >Confirm</el-button
          >
        </span>
      </template>
    </el-dialog>
  </div>
</template>
<script lang="ts" setup>
import { reactive, ref } from "vue";

const dialogFormVisible = ref(false);
const dialogFormVisibleDelete = ref(false);
const dialogFormVisibleCreate = ref(false);
const idDel = ref();
const formLabelWidth = "140px";
const formData = reactive({
  id: "",
  first_name: "",
  last_name: "",
  full_name: "",
  birthday: "",
  phone: "",
  sex: "",
  address: "",
});
const resetForm = () => {
  formData.id ='';
  formData.first_name = '';
  formData.last_name = '';
  formData.full_name = '';
  formData.birthday = '';
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
  formData.birthday = scope.birthday;
  formData.phone = scope.phone;
  formData.sex = scope.sex;
  formData.address = scope.address;
  dialogFormVisible.value = true;
};
const handleDelete = (scope) => {
  console.log("click22", scope.id);
  dialogFormVisibleDelete.value = true;
  idDel.value = scope.id;
};

const confirmDelete = () => {
  console.log("idDel", idDel.value);
  dialogFormVisibleDelete.value = false;
};

const openCreate = () => {
  dialogFormVisibleCreate.value = true;
};

const tableData = [
  {
    id: "2016-05-03",
    full_name: "Tom",
    last_name: "Tom",
    first_name: "Ok",
    birthday: "2022-07-17",
    phone: "02316546",
    sex: 0,
    address: "No. 189, Grove St, Los Angeles",
  },
  {
    id: "2016-05-03",
    full_name: "Tom",
    last_name: "Tom",
    first_name: "Ok",
    birthday: "California",
    phone: "Los Angeles",
    sex: "No. 189, Grove St, Los Angeles",
    address: "",
  },
];
</script>
<style lang=""></style>
