<template>
  <div style="display: flex; flex-direction: column; margin: 10px;">
    <div style="display: flex; justify-content: space-between;">
      <!-- 商品显示区域 -->

      <div style="flex-grow: 1; margin-right: 20px;">
        <el-row>
          <el-col
              v-for="(o, index) in tableData.length"
              :key="o"
              :span="110"
              :offset="1"
              style="margin-bottom: 50px;"
          >
            <el-card
                style="width: 300px; height:420px; display: flex; align-items: center; justify-content: space-between"
                :body-style="{ padding: '0px' }"
            >
              <div style="padding: 14px; text-align: left;">
                <span style="font-weight: bold;" >{{tableData[index].name}}</span>
                <div style="color:rgb(128,128,128);">
                  <span>{{tableData[index].price + "元"}}</span>
                  <span style="margin-left: 40px;">{{"已售：" + tableData[index].salesVolume}}</span>
                </div>
                <div class="bottom">
                  <!--<el-button type="primary"  class="button" @click="handleEdit( tableData[index])" >加入购物车</el-button>-->
                  <el-button
                      type="primary"
                      class="button"
                      @click="handleEdit(tableData[index])"
                      style="background-color: transparent; border: 1px solid black; color: black;"
                  >
                    编辑
                  </el-button>
                  <el-popconfirm title="你确定要删除嘛？" @confirm="handleDelete(tableData[index].id)">
                    <template #reference>
                      <el-button
                          size="mini"
                          type="danger"
                          style="margin-right: 120px;"
                      >删除</el-button
                      >
                    </template>
                  </el-popconfirm>
                </div>
              </div>
              <el-image
                  style="width: 300px; height:300px"
                  :src="tableData[index].cover"
                  fit="cover"
                  class="image"
              />
            </el-card>

          </el-col>

        </el-row>
      </div>


      <!-- 分类标签，占据右侧 -->
      <div style="width: 200px; height:520px;display: flex; flex-direction: column; align-items: stretch; border: 2px solid grey; border-radius: 10px; padding: 5px;">
        <div  style="margin: 10px 0">
          <el-button
              type="primary"
              @click="add"
              style="width: 190px; color: black; background-color: transparent; border: 1px solid black;">
            新增商品
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
    <!--    功能-->




    <div class="demo-pagination-block" v-if="myData">



      <!-- Form -->

      <el-dialog v-model="dialogFormVisible" title="更新">
        <el-form :model="form" label-width="120px">
          <el-form-item label="名称" >
            <el-input v-model="form.name" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="价格" >
            <el-input v-model="form.price" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="品牌" >
            <el-input v-model="form.brand" autocomplete="off" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="出厂时间" >
            <el-date-picker v-model="form.createTime" fvalue-format="YYYY-MM-DD" type="date" style="width: 80%" clearable></el-date-picker>
          </el-form-item>
          <el-form-item label="封面">
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
          <el-form-item label="状态" >
            <el-radio v-model="form.state" label="1">上架</el-radio>
            <el-radio v-model="form.state" label="0">下架</el-radio>
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
  <div style="text-align: center; position: relative; top: -30px;">
    共计{{tableData.length}}条内容，当前是第1页 ➡
  </div>
</template>

<script>
import request from "../../utils/request";
import { UploadFilled } from '@element-plus/icons'

export default {
  name: 'storage' ,
  components:{
    UploadFilled,
  },
  data() {
    return {
      dialogFormVisible:false,
      form:{},
      currentPage :1,
      tableData: [
      ],
      search: '',
      total:10,
      dialogImageUrl: '',
      user:{},
      filesUploadUrl: "http://"+window.server.filesUploadUrl+":9090/files/upload",
      categories: ['全部', 'CPU', 'GPU','RAM'],
      myData:null
    }
  },
  created() {
    let str = sessionStorage.getItem("user")
    this.user = JSON.parse(str)
    if(this.user.role===2){
      this.form.storeId=this.user.id
    }
    this.load()
  },mounted() {
    setTimeout(() => {
      this.loadData();
    }, 1000);
  },
  methods: {
    // switchState(st) {
    //   this.form.state=st
    //   request.put("/storage",this.form).then(res => {
    //     console.log(res)
    //     if (res.code === '0') {
    //       this.$message({
    //         type: "success",
    //         message: "更新成功"
    //       })
    //     } else {
    //       this.$message({
    //         type: "error",
    //         message: res.msg
    //       })
    //     }
    //   })
    // },
    async loadData() {
      // 在这里执行数据加载的逻辑
      // 例如，从 API 获取数据或准备要展示的内容
      this.myData = 1; // 假设这是一个异步的 API 调用
    },
    filterByCategory(category) {
      if(category === '全部'){
        this.search = '';
        this.load();
        return;
      }

      this.search = category;
      this.load();
      this.search = "";

    },
    filesUploadSuccess(res,file){
      console.log(res)
      this.form.cover=res.data
    },
    load(){
      if(this.user.role===3){
        request.get("/storage",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            search: this.search
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=this.tableData.length
        })
      }else{
        request.get("/storage/getStore",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            search: this.search,
            id:this.user.id,
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=this.tableData.length
        })
      }
    },
    add(){
      this.dialogFormVisible = true;
      this.form={};
      this.$refs['upload'].clearFiles()
    },
    save(){
      console.log(this.user)
      if(this.user.role===2){
        this.form.storeId=this.user.id
      }
      if(this.form.id){
        //update
        console.log(this.form)
        request.put("/storage",this.form).then(res =>{
          console.log(res)
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
        request.post("/storage",this.form).then(res =>{
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
      this.$nextTick(()=>{
        this.$refs['upload'].clearFiles()
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/storage/"+id).then(res=>{
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
