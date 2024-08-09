<template>
  <el-button
      style="position: absolute; top: 10px; left: 10px;"
      type="primary"

      @click="handleBack">
    返回
  </el-button>
  <h2 style="text-align: center; margin-bottom: 10px;">个人信息</h2>
  <div>
    <div style="display: flex;  margin-top: 10px;justify-content: center; align-items: center;">
      <div style="flex-grow: 1; margin-right: 20px;">

        <!-- 卡片视图 -->

              <!-- 卡片内容 -->
        <div style="border: 2px solid black; border-radius: 10px; padding: 10px; background-color: white; display: flex; justify-content: center; align-items: center; flex-direction: column; margin: 10px auto; width: 400px;">
          <!-- 头像区域 -->

                <!-- 头像区域 -->
                <div>
                  <el-image
                      v-if="tableData[0].avatar"
                      style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;"
                      :src="tableData[0].avatar"
                      fit="cover"
                  />
                  <img v-else
                       src="https://freesvg.org/img/abstract-user-flat-1.png"
                       style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;"
                       alt="备用头像"/>
                </div>

                <!-- 用户信息区域 -->
          <div style="width: 300px; margin: auto;">
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>ID:</strong> {{ tableData[0].id }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>用户名:</strong> {{ tableData[0].username }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>昵称:</strong> {{ tableData[0].nickName }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>年龄:</strong> {{ tableData[0].age }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>性别:</strong> {{ tableData[0].sex }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>余额:</strong> {{ tableData[0].account }}</div>
            <div class="item" style="border-bottom: 1px solid #ccc; padding: 5px 0;"><strong>邮箱:</strong> {{ tableData[0].email }}</div>
            <div class="item" style="padding: 5px 0;"><strong>角色:</strong>
              <span v-if="tableData[0].role === 1">顾客</span>
              <span v-if="tableData[0].role === 2">商家</span>
              <span v-if="tableData[0].role === 3">管理员</span>
            </div>
          </div>

                <!-- 编辑按钮 -->
                <el-button size="mini" @click="handleEdit(tableData[0])">编辑</el-button>

              </div>

      </div>

    </div>

    <div class="demo-pagination-block">



      <!-- Form -->

      <el-dialog v-model="dialogFormVisible" title="编辑">
        <el-form
            :model="form"
            ref="ruleForm"
            label-width="120px">
          <el-form-item label="头像">
            <el-upload
                ref="upload"
                drag
                :action="filesUploadUrl"
                :on-success="filesUploadSuccess"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleRemove"
                multiple
            >
              <el-icon class="el-icon--upload"><upload-filled /></el-icon>
              <div class="el-upload__text">
                把文件拖拽到这里或者 <em>点击这里上传</em>
              </div>
              <template #tip>
                <div class="el-upload__tip">
                  请放置jpg或png文件
                </div>
              </template>
            </el-upload>
          </el-form-item>
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
            <el-input v-model="form.account" disabled autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="邮箱地址" >
            <el-input v-model="form.email" autocomplete="off" style="width: 80%"></el-input>
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

</template>

<script>
import request from "../../utils/request";
import {UploadFilled} from "@element-plus/icons";

export default {
  name: 'person' ,
  components:{
    UploadFilled,
  },
  data() {
    return {

      filesUploadUrl: "http://"+window.server.filesUploadUrl+":9090/files/upload",
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
    filesUploadSuccess(res,file){
      console.log(res)
      this.form.avatar=res.data
    },
    load(){
      request.get("/user",{
        params:{

          id: this.user_form.id
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
      sessionStorage.setItem("user", JSON.stringify(this.form))
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
    handleBack(){
      if(this.tableData[0].role === 1){
        this.$router.push('/customer')
      }else{
        this.$router.push('/storage')
      }
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


.card-content .item {
  margin-bottom: 10px; /* 调整间隔大小 */
}
</style>