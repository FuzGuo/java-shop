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
                <div style="color:rgb(128,128,128);">{{tableData[index].price+"元"}}</div>
                <div class="bottom">
                  <!--<el-button type="primary"  class="button" @click="handleEdit( tableData[index])" >加入购物车</el-button>-->
                  <el-button
                      type="primary"
                      class="button"
                      @click="handleEdit(tableData[index])"
                      style="background-color: transparent; border: 1px solid black; color: black;"
                  >
                    加入购物车
                  </el-button>
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


      <div style="text-align: justify; margin-top: 20px;">
        <el-row>
          <!--    以下是显示页面码-->

        </el-row>
        <el-dialog v-model="dialogFormVisible" title="添加">
          <el-form
              :rules="rules"
              :model="form"
              label-width="120px">
            <el-form-item >
              <el-image
                  style="width: 300px; height:300px"
                  :src="form.cover"
                  fit="cover"
                  class="image"
              />
            </el-form-item>
            <el-form-item label="名称" >
              <el-input disabled v-model="form.name" autocomplete="off" style="width: 80%"></el-input>
            </el-form-item>
            <el-form-item label="价格" >
              <el-input disabled v-model="form.price" autocomplete="off" style="width: 80%"></el-input>
            </el-form-item>
            <el-form-item label="品牌" >
              <el-input disabled v-model="form.brand" autocomplete="off" style="width: 80%"></el-input>
            </el-form-item>
            <el-form-item label="出厂时间" >
              <el-date-picker disabled v-model="form.createTime" fvalue-format="YYYY-MM-DD" type="date" style="width: 80%" clearable></el-date-picker>
            </el-form-item>
            <el-form-item prop="num" label="购买数量" >
              <el-input
                  v-model="form.num"
                  autocomplete="off"
                  style="width: 80%"></el-input>
            </el-form-item>
          </el-form>
          <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取消</el-button>
          <el-button type="primary" @click="AddToCard" style="margin-left:  5px ;background-color: black; color: white;border-color: white;"
          >放入购物车</el-button
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
  name: 'customer' ,
  components:{
    UploadFilled,
  },
  data() {
    return {
      dialogFormVisible:false,
      form:{
      },
      currentPage :1,
      tableData: [
      ],
      rules: {
        num: [
          {
            required: true,
            message: '请输入数量',
            trigger: 'blur',
          },
        ],
      },
      search: '',
      total:10,
      dialogImageUrl: '',
      shoppingCart:{
      },
      user:{},
      log_form:{},

      categories: ['全部', 'CPU', 'GPU','RAM'],
    }
  },
  created() {
    let str = sessionStorage.getItem("user")
    this.user = JSON.parse(str)
    this.load()
  },
  methods: {
    // switchState(st) {
    //   this.form.state=st
    //   request.put("/customer",this.form).then(res => {
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
    filesUploadSuccess(res,file){
      console.log(res)
      this.form.cover=res.data

    },
    load(){
      request.get("/storage",{
        params:{
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data.records
        this.total=res.data.total
      })
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
    AddToCard(){
      if(this.form.id) {
        this.shoppingCart.userId = this.user.id+ ''
        this.shoppingCart.storageId = this.form.id+ ''
        this.shoppingCart.num = this.form.num
        this.shoppingCart.role = this.user.role
        //update
        console.log("start")
        console.log(this.shoppingCart)
        console.log("end")
        request.post("/USC", this.shoppingCart).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "已加入购物车"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load()
          this.dialogFormVisible = false
        })
      }
    },

    detail(row){
      this.form=JSON.parse(JSON.stringify(row))
      this.dialogFormVisible=true
      this.$nextTick(()=>{
        this.$refs['upload'].clearFiles()
      })
    },
    handleEdit(row) {
      this.form=JSON.parse(JSON.stringify(row))
      this.form.num=1
      this.dialogFormVisible=false
      this.log_form.userId=this.user.id+ ''
      this.log_form.storageId=this.form.id+ ''
      this.AddToCard();
      this.log_form.action="浏览"
      console.log(this.log_form)
      request.post("/logController",this.log_form).then(res => {
        console.log(res)
        if (res.code === '0') {
          //this.$message({
            //type: "success",
            //message: "浏览日志保存成功"
          //})
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
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


<style>
.el-row {
  margin-bottom: 20px;
}
.el-col {
  border-radius: 4px;
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
  color: black; /* 设置文字颜色为黑色 */
  border: 1px solid black; /* 设置1像素的黑色边框 */
  background-color: transparent; /* 设置背景颜色为透明 */
}

.image {
  width: 100%;
  display: block;
}
</style>