<template>
  <div style="width: 80%; margin: auto; border: 2px solid #ccc; border-radius: 20px; padding: 20px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1);">
    <h2 style="text-align: center; margin-bottom: 20px;">日志记录</h2>
    <div style="text-align: center;margin-bottom: 20px;">
      共计{{tableData.length}}条内容，当前是第1页 ➡
    </div>
    <el-table :data="tableData" border stripe class="light-green-table" style="width: 100%">
      <el-table-column label="日志ID" prop="id" />
      <el-table-column label="时间" prop="LocalDateTime" />
      <el-table-column label="顾客ID" prop="userId" />
      <el-table-column label="顾客账号" prop="username" />
      <el-table-column label="商品ID" prop="storageId"/>
      <el-table-column label="品名" prop="storageName" />
      <el-table-column label="操作" prop="action" />
    </el-table>
  </div>

</template>

<script>
import request from "../../utils/request";

export default {
  name: 'log' ,
  data() {
    return {
      dialogFormVisible:false,
      currentPage :1,
      tableData: [
      ],
      roleData:[],
      search: '',
      total:10,
      dialogImageUrl: '',
      user:0,
      user_form:{},
      Visible:false,
      customer_form:{},
      storage_form:{},
      log_form:{},
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.user_form = JSON.parse(str)
    this.load()
  },
  methods: {
    load(){
      if(this.user_form.role===2){
        request.get("/logController",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            search: this.search,
            id:this.user_form.id
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=res.data.total
        })
      }else if(this.user_form.role===1){
        this.$router.push("/customer")
      }else {
        request.get("/logController/admin",{
          params:{
            pageNum: this.currentPage,
            pageSize: this.pageSize,
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=res.data.total
        })
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

<style>
.light-green-table {
  background-color: #e0f2f1; /* 淡绿色 */
}

.light-green-table .el-table__header,
.light-green-table .el-table__body,
.light-green-table .el-table__row {
  background-color: #e0f2f1; /* 为表头、表体和行应用同样的淡绿色背景 */
}
</style>