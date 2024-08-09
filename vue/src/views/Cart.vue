<template>
  <div class="receipt">
    <h2>购物清单</h2>
    <div class="items">
      <!-- 循环遍历每个商品 -->
      <div class="item" v-for="item in tableData" :key="item.id">

        <span class="name">{{ item.name }}</span>
        <span class="price">{{ item.price }}¥</span>
        <span class="quantity">
    <input type="number" v-model="item.num" min="0" class="quantity-input">
  </span>
        <span class="subtotal">小计: {{ item.price * item.num }}¥</span>
        <span class="delete-button" @click="handleDelete(item.num,item.id)">❌</span>
      </div>

    </div>
    <div class="total">
      总计: {{ totalPrice }}¥
    </div>
    <!-- 其他操作按钮 -->
    <div class="button-group">
      <button class="save-button" @click="saveAll">保存</button>
      <button class="clear-button" @click="clearTable">清空</button>
      <button class="checkout-button" @click="checkout">结算</button>
    </div>
  </div>
  <div>



  </div>
</template>

<script>
import request from "../../utils/request";
import { globalState, updateTotalPrice } from '../store/gvar.js';
export default {
  name: 'cart' ,
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
      user_form:{},
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.user_form = JSON.parse(str)
    this.form.userId=this.user_form.id
    this.form.role=this.user_form.role
    this.load()
  },
  computed: {
    totalPrice() {

      return this.tableData.reduce((total, item) => {
        return total + (item.price * item.num);
      }, 0);
    }
  },
  methods: {
    filesUploadSuccess(res,file){
      console.log(res)
      this.form.cover=res.data
    },
    //加载购物车数据
    load(){
      request.get("/USC",{
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
    },
    //保存购物车修改
    saveAll() {
      this.tableData.forEach(item => {
        this.save(item.num, item.id);
      });
      this.$message({
        type:"success",
        message:"已保存"
      })
    },
    save(num,id){
      this.form.num=num
      this.form.storageId=id
      console.log(this.form)
      request.put("/USC",this.form).then(res =>{
        console.log(res)
        if(res.code==='0'){

        }else {
          this.$message({
            type:"error",
            message:res.msg
          })
        }
        this.load()
      })

    },
    success(){
      this.$message({
        type:"success",
        message:"提交订单成功"
      })
    },
    //提交订单
    checkout(){
      if(this.totalPrice === 0)
        return;
      this.saveAll()
      this.tableData.forEach(item => {
        this.handleSubmit(item.num, item.id,item.price,item.storeId);
      });

      this.load()
      this.load()
      globalState.totalPrices = this.totalPrice;
      this.$router.push("/pay");
    },
    handleSubmit(num,id,price,sid){
      this.form.num=num
      this.form.storageId=id
      this.form.customerId=this.user_form.id
      this.form.storeId=sid
      this.form.ostate=0
      console.log(this.form)
      request.post("/Order",this.form, {params:{
        id:this.user_form.id,
        price:price

      }
        }).then(res =>{
        console.log(res)
        if(res.code==='0'){

        }else {
          this.$message({
            type:"error",
            message:res.msg
          })
        }

      })

      this.handleDelete(num,id)
    },

    //删除购物车
    clearTable(){
      this.tableData.forEach(item => {
        this.handleDelete(item.num, item.id);
      });
      this.tableData.forEach(item => {
        this.handleDelete(item.num, item.id);
      });
      this.$message({
        type:"success",
        message:"已清空"
      })
      this.load()
      this.load()
      this.load()
    },
    handleDelete(num,id) {
      this.form.num=num
      this.form.storageId=id
      console.log(this.form)
      request.post("/USC/deleteEntity",this.form).then(res=>{
        if(res.code==='0'){

        }else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()
      })
    },

    //页面修改
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
.receipt {
  display: flex;
  flex-direction: column;
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  background-color: #f9f9f9;
}

.receipt h2 {
  text-align: center;
  margin-bottom: 20px;
}

.items .item {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr 0.5fr;
  gap: 10px;
  margin-bottom: 10px;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

.total {
  font-size: 1.2em;
  font-weight: bold;
  text-align: right;
  margin-top: 20px;
}
.quantity-input {
  width: 100px; /* 或根据需要调整 */
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.delete-button {
  cursor: pointer;
  color: red;
  margin-left: 10px;
}

/* 可以添加额外的样式，如鼠标悬停效果 */
.delete-button:hover {
  color: darkred;
}
.button-group {
  display: flex;
  justify-content: center; /* 水平居中 */
  gap: 10px; /* 按钮之间的间距 */
  margin-top: 20px; /* 与上方内容的间距 */
}
.button-group button {
  width: 100px;
  /* 可以添加更多按钮样式 */
}
</style>