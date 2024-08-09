<template>
  <div>
    <div style="display: flex; justify-content: space-between; margin-top: 10px;">
    <div style="flex-grow: 1; margin-right: 20px;">

      <!-- 卡片视图 -->
      <el-row :gutter="20">
        <el-col
            v-for="(item, index) in tableData"
            :key="index"
            :xs="24"
            :sm="12"
            :md="8"
            :lg="6"
            :xl="4"
        >
          <el-card style="margin-bottom: 20px; position: relative;">
            <!-- 删除按钮 -->

            <el-popconfirm title="你确定要删除嘛？" @confirm="handleDelete(item.id)">
              <template #reference>
                <el-button
                    style="position: absolute; top: 10px; right: 10px;"
                    size="mini"
                    type="danger"
                >删除</el-button>
              </template>
            </el-popconfirm>
            <div>
              <!-- 当 avatar 不为空时显示图片 -->
              <el-image
                  v-if="item.avatar"
                  style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; margin-left: 70px;"
                  :src="item.avatar"
                  fit="cover"
                  class="image"
              />
              <!-- 当 avatar 为空时显示备用图标 -->
              <img v-else
                   src="https://freesvg.org/img/abstract-user-flat-1.png"
                   style="width: 100px; height: 100px; border-radius: 50%; margin-left: 70px; object-fit: cover;"
                   class="image"
               alt=""/>
            </div>
            <div class="card-content">
              <div class="item"><strong>ID:</strong> {{ item.id }}</div>
              <div class="item"><strong>用户名:</strong> {{ item.username }}</div>
              <div class="item"><strong>昵称:</strong> {{ item.nickName }}</div>
              <div class="item"><strong>年龄:</strong> {{ item.age }}</div>
              <div class="item"><strong>性别:</strong> {{ item.sex }}</div>
              <div class="item"><strong>余额:</strong> {{ item.account }}</div>
              <div class="item"><strong>邮箱:</strong> {{ item.email }}</div>
              <div class="item"><strong>角色:</strong>
                <span v-if="item.role === 1">顾客</span>
                <span v-if="item.role === 2">商家</span>
                <span v-if="item.role === 3">管理员</span>
              </div>
              <el-button size="mini" @click="handleEdit( item)"
              >编辑</el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
    <div style="width: 200px; height:520px;display: flex; flex-direction: column; align-items: stretch; border: 2px solid grey; border-radius: 10px; padding: 5px;">
      <div  style="margin: 10px 0">
        <el-button
            type="primary"
            @click="add"
            style="width: 190px; color: black; background-color: transparent; border: 1px solid black;">
          新增用户
        </el-button>
      </div>

      <!-- 搜索条 -->
      <div style="display: flex; justify-content: flex-start; margin-bottom: 20px;">
        <el-input v-model="search" placeholder="Input..." style="flex-grow: 1; border-bottom-color: black" clearable></el-input>
        <el-button
            type="primary"
            @click="load"
            style="margin-left: 5px; background-color: transparent; color: black; border: 1px solid black;">
          查询
        </el-button>
      </div>
      <!-- Black Label -->
      <div style="color: black; text-align: center; padding-bottom: 10px; margin-bottom: 20px; border-bottom: 2px solid grey;">
        搜索标签
      </div>
      <!-- 分类标签 -->
      <span
          v-for="category in categories"
          :key="category"
          @click="filterByCategory(category)"
          style="display: block; width: 100%; margin-bottom: 5px; cursor: pointer; color: rgb(128,128,128); background-color: #f2f2f2; padding: 5px 10px; border-radius: 15px; transition: background-color 0.3s; text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
          @mouseover="this.style.backgroundColor='#e6e6e6'"
          @mouseleave="this.style.backgroundColor='#f2f2f2'"
      >{{ category }}</span>
    </div>
      </div>

    <div class="demo-pagination-block">



      <!-- Form -->

      <el-dialog v-model="dialogFormVisible" title="添加">
        <el-form
            :model="form"
            ref="ruleForm"
            label-width="120px">
          <el-form-item label="用户名" >
            <el-input v-model="form.username" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="昵称" >
            <el-input v-model="form.nickName" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="年龄" >
            <el-input v-model="form.age" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="性别" >
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
            <el-radio v-model="form.sex" label="未知">未知</el-radio>
          </el-form-item>
          <el-form-item prop="account" label="余额" >
            <el-input v-model="form.account" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="邮箱地址" >
            <el-input v-model="form.email" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="角色">
            <el-radio v-model="form.role" label="1">顾客</el-radio>
            <el-radio v-model="form.role" label="2">商家</el-radio>
            <el-radio v-model="form.role" label="3">管理员</el-radio>
          </el-form-item>

        </el-form>
        <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="save"
        >确认</el-button
        >
      </span>
        </template>
      </el-dialog>
    </div>
  </div>
  <div style="text-align: center; position: relative; top: -20px;">
    共计{{tableData.length}}条内容，当前是第1页  ➡
  </div>
</template>

<script>
import request from "../../utils/request";

export default {
  name: 'user' ,
  data() {
    return {
      dialogFormVisible:false,
      form:{},
      currentPage :1,
      tableData: [
      ],
      search: '',
      total:10,
      categories: ['全部', '商家', '顾客','管理员'],
      role:-1,
      ruleForm: {},
      user_form:{},
      rules: {
        account: [
          {
            required: true,
            message: '请充值',
            trigger: 'blur',
          },
          {
            min: 0,
            max: 8,
            message: '长度在8八位数以内',
            trigger: 'blur',
          },
        ],
      },
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.user_form = JSON.parse(str)
    this.load()
  },
  methods: {
    load(){
      request.get("/user",{
        params:{
          pageNum: this.currentPage,
          search: this.search,
          role: this.role,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data.records
      })
    },
    add(){
      this.dialogFormVisible = true;
      this.form={};
    },
    save(){
      if(this.form.id){
        //update
        request.put("/user",this.form).then(res =>{
          if(res.code==='0'){
            this.$message({
              type:"success",
              message:"更新成功"
            })
          }else {
            this.$message({
              type:"error",
              message:res.msg
            })
          }
          this.load()
          this.dialogFormVisible =false
        })
      }else{
        request.post("/user",this.form).then(res =>{
          console.log(res)
          if(res.code==='0'){
            this.$message({
              type:"success",
              message:"新增成功"
            })
          }else {
            this.$message({
              type:"error",
              message:res.msg
            })
          }
          this.load()
          this.dialogFormVisible=false
        })
      }
    },
    handleEdit(row) {
      this.form=JSON.parse(JSON.stringify(row))
      this.dialogFormVisible=true
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/user/"+id).then(res=>{
        if(res.code==='0'){
          this.$message({
            type:"success",
            message:"删除成功"
          })
        }else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()
      })
    },
    filterByCategory(category) {
      if(category === '全部'){
        this.search = '';
        this.role = -1;
        this.load();

      }
      else if(category ==='商家'){
        this.role = 2;
        this.load();
      }else if(category === '管理员'){
        this.role = 3;
        this.load();
      }else  if(category === '顾客'){
        this.role = 1;
        this.load();

      }


    },
    handleSizeChange(pageSize){
      this.pageSize=pageSize
      this.load()
    },
    handleCurrentChange(pageNum){//改变页码
      this.currentPage=pageNum
      this.load()
    }
  },
}
</script>

<style scoped>
.card-content {
  display: flex;
  flex-direction: column;
}

.card-content .item {
  margin-bottom: 10px; /* 调整间隔大小 */
}
</style>