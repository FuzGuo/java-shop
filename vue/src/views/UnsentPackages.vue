<template>
  <div style="width: 80%; margin: auto; border: 2px solid #ccc; border-radius: 20px; padding: 20px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1);">
    <h2 style="text-align: center; margin-bottom: 20px;">待签收</h2>
    <div style="text-align: center;margin-bottom: 20px;">
      共计{{tableData.length}}条内容，当前是第1页 ➡
    </div>
    <el-table :data="tableData" border stripe style="width: 100%">
      <el-table-column label="订单ID" prop="orderId" />
      <el-table-column label="客户ID" prop="customerId" />
      <el-table-column label="商品ID" prop="id" />
      <el-table-column label="商户ID" prop="storeId"></el-table-column>
      <el-table-column label="名称" prop="name" />
      <el-table-column label="价格(¥)" prop="price" />
      <el-table-column label="品牌" prop="brand" />
      <el-table-column label="购买数量" prop="num" />

      <el-table-column label="订单状态">
        <template #default="scope">
          <span v-if="scope.row.ostate===0">等待发货</span>
          <span v-if="scope.row.ostate===1">已发货</span>
          <span v-if="scope.row.ostate===2">确认收货</span>
        </template>
      </el-table-column>

      <el-table-column v-if="user_form.role===2" label="发货">
        <template #default="scope">
          <el-popconfirm v-if="scope.row.ostate===0" title="你确定要发货嘛？" @confirm="save(scope.row.num,scope.row.id,scope.row.orderId,scope.row.price,scope.row.storeId,scope.row.customerId,scope.row)">
            <template #reference>
              <el-button
                  size="mini"
                  type="danger"
              >发货</el-button
              >
            </template>
          </el-popconfirm>
          <el-button  disabled v-if="scope.row.ostate===1">
            已发货
          </el-button>
          <el-button  disabled v-if="scope.row.ostate===2">
            已确认收货
          </el-button>
        </template>
      </el-table-column>
      <el-table-column v-if="user_form.role===1" label="确认收货">
        <template #default="scope">
          <el-button  disabled v-if="scope.row.ostate===0">
            待发货
          </el-button>
          <el-popconfirm v-if="scope.row.ostate===1" title="你确定收货嘛？" @confirm="save(scope.row.num,scope.row.id,scope.row.orderId,scope.row.price,scope.row.storeId,scope.row.customerId,scope.row)">
            <template #reference>
              <el-button
                  size="mini"
                  type="danger"
              >收货</el-button
              >
            </template>
          </el-popconfirm>
          <el-button  disabled v-if="scope.row.ostate===2">
            已确认收货
          </el-button>
        </template>
      </el-table-column>
    </el-table>

  </div>
</template>

<script>
import request from "../../utils/request";

export default {
  name: 'order' ,
  data() {
    return {
      dialogFormVisible:false,
      form:{},
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
    this.form.customerId=this.user_form.id
    this.form.role=this.user_form.role
    this.load()
  },
  methods: {
    filesUploadSuccess(res,file){
      console.log(res)
      this.form.cover=res.data
    },
    load(){
      if(this.user_form.role===1){
        request.get("/Order",{
          params:{
            pageNum: this.currentPage,
            pageSize: 100,
            search: this.search,
            id:this.user_form.id,
            ostate:1
          }
        }).then(res=>{
          console.log(res)
          this.tableData=res.data.records
          this.total=res.data.total
        })
      }else {
        console.log("store")
        request.get("/Order/store",{
          params:{
            pageNum: this.currentPage,
            pageSize: 100,
            search: this.search,
            id:this.user_form.id
          }
        }).then(res=>{
          this.tableData=res.data.records
          this.total=res.data.total
        })
      }

    },
    add(){
      this.dialogFormVisible = true;
      this.form={};
      this.$refs['upload'].clearFiles()
    },
    save(num,id,orderId,price,sid,cid,row){
      this.storage_form=JSON.parse(JSON.stringify(row))
      console.log(this.storage_form)
      this.form.num=num
      this.form.storageId=id
      this.form.customerId=cid
      if(this.user_form.role===1){
        this.form.ostate=2
      }else {
        this.form.ostate=1
        //邮件确认
        request.get("/user/getCustomer",{params:{id:this.form.customerId}}).then(res=>{
          this.customer_form=res.data
          this.storage_form.email=this.customer_form.email
          this.storage_form.username=this.customer_form.username
          console.log("222")
          console.log(this.storage_form)
          request.post("/send",
              this.storage_form
          ).then(res2 =>{
            if(res2.code==='0'){
              this.$message({
                type:"success",
                message:"邮件确认成功"
              })
            }else {
              this.$message({
                type:"error",
                message:res2.msg
              })
            }
          })
        })
      }
      this.form.id=orderId
      this.form.storeId=sid
      console.log(this.form)
      request.put("/Order",this.form,{params: {
          id: this.user_form.id,
          price: price
        }
      }).then(res =>{
        console.log(res)
        if(res.code==='0'){
          this.$message({
            type:"success",
            message:"已收货"
          })
        }else {
          this.$message({
            type:"error",
            message:res.msg
          })
        }
        this.load()
      })
      if(this.user_form.role===1) {
        this.log_form.userId = this.user_form.id+ ''
        this.log_form.storageId = this.storage_form.id+''
        this.log_form.action = "购买"
        request.post("/logController", this.log_form).then(res => {
          console.log(res)
          if (res.code === '0') {

          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
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
