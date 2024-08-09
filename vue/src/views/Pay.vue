<template>
  <div style="margin-top: -75px;">


    <div class="pay-content">
      <div class="title">订单提交成功</div>
      <div class="text time-margin">
        <span>请在 </span>
        <span class="time">{{ ddlTime }}</span>
        <span> 之前付款，超时订单将自动取消</span>
      </div>
      <div class="text">支付金额</div>
      <div class="price">
        <span class="num">{{ totalPrice }}</span>
        <span>元</span>
      </div>
      <div class="pay-choose-view" style="text-align: center;">

        <div class="choose-box" style="text-align: center; margin-left: auto; margin-right: auto; display: block; width: fit-content;">
          <img src="https://upload.wikimedia.org/wikipedia/en/0/04/Huawei_Standard_logo.svg" alt="华为支付">
          <span>华为支付</span>
        </div>
        <div class="tips">请选择任意一种支付方式</div>
        <button class="pay-btn pay-btn-active" @click="handlePay()">确认支付</button>
      </div>
      <div class="pay-qr-view" style="display: none;">
        <div class="loading-tip" style="">正在生成安全支付二维码</div>
        <div class="qr-box" style="display: none;">
          <div id="qrCode" class="qr">
          </div>
          <div class="tips">请打开微信扫一扫进行支付</div>
          <button class="pay-finish-btn">支付完成</button>
          <button class="back-pay-btn">选择其他支付方式</button>
        </div>
      </div>
    </div>
  </div>

</template>

<script setup>

import {onMounted, ref} from "vue";
import {useRoute} from "vue-router";
import * as http from "http";
import * as https from "https";

const route = useRoute();

let ddlTime = ref()
let amount = ref()

onMounted(() => {
  amount.value = route.query.amount
  ddlTime.value = formatDate(new Date().getTime(), 'YY-MM-DD hh:mm:ss')
})


const formatDate = (time, format = 'YY-MM-DD hh:mm:ss') => {
  const date = new Date(time)

  const year = date.getFullYear(),
      month = date.getMonth() + 1,
      day = date.getDate() ,
      hour = date.getHours(),
      min = date.getMinutes()+ 1,
      sec = date.getSeconds()
  const preArr = Array.apply(null, Array(10)).map(function (elem, index) {
    return '0' + index
  })

  return format.replace(/YY/g, year)
      .replace(/MM/g, preArr[month] || month)
      .replace(/DD/g, preArr[day] || day)
      .replace(/hh/g, preArr[hour] || hour)
      .replace(/mm/g, preArr[min] || min)
      .replace(/ss/g, preArr[sec] || sec)
}

</script>

<script>
import { globalState } from '@/store/gvar';

export default {
  computed: {
    totalPrice() {
      return globalState.totalPrices;
    }
  },

  methods:{
    handlePay(){
      this.$message({
        type:"success",
        message:"支付成功"
      })
      this.$router.push("/Cart");
    }
  }
}
</script>
<style >
.flex-view {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
}

.pay-content {
  position: relative;
  margin: 120px auto 0;
  width: 500px;
  background: #fff;
  overflow: hidden;

  .title {
    color: #152844;
    font-weight: 500;
    font-size: 24px;
    line-height: 22px;
    height: 22px;
    text-align: center;
    margin-bottom: 11px;
  }

  .time-margin {
    margin: 11px 0 24px;
  }

  .text {
    height: 22px;
    line-height: 22px;
    font-size: 14px;
    text-align: center;
    color: #152844;
  }

  .time {
    color: #f62a2a;
  }

  .text {
    height: 22px;
    line-height: 22px;
    font-size: 14px;
    text-align: center;
    color: #152844;
  }

  .price {
    color: #ff8a00;
    font-weight: 500;
    font-size: 16px;
    height: 36px;
    line-height: 36px;
    text-align: center;

    .num {
      font-size: 28px;
    }
  }

  .pay-choose-view {
    margin-top: 24px;

    .choose-box {
      width: 140px;
      height: 126px;
      border: 1px solid #cedce4;
      border-radius: 4px;
      text-align: center;
      cursor: pointer;
    }

    .pay-choose-box {
      -webkit-box-pack: justify;
      -ms-flex-pack: justify;
      justify-content: space-between;
      max-width: 300px;
      margin: 0 auto;

      img {
        height: 40px;
        margin: 24px auto 16px;
        display: block;
      }
    }

    .tips {
      color: #6f6f6f;
      font-size: 14px;
      line-height: 22px;
      height: 22px;
      text-align: center;
      margin: 16px 0 24px;
    }



    .tips {
      color: #6f6f6f;
      font-size: 14px;
      line-height: 22px;
      height: 22px;
      text-align: center;
      margin: 16px 0 24px;
    }

    .pay-btn {
      cursor: pointer;
      background: #c3c9d5;
      border-radius: 32px;
      width: 104px;
      height: 32px;
      line-height: 32px;
      border: none;
      outline: none;
      font-size: 14px;
      color: #fff;
      text-align: center;
      display: block;
      margin: 0 auto;
    }
    .choose-box img {
      width: 100px; /* 设置图片宽度 */
      height: auto; /* 保持图片的纵横比 */
      display: block;
      margin: 0 auto; /* 水平居中图片 */
    }
    .choose-box {
      text-align: center; /* 将文本居中对齐 */
      margin-bottom: 20px; /* 在选项之间添加一些空间 */
    }
    .active {
      border: 2px solid #00a;  /* 举例：加一个蓝色边框 */
      background-color: #eef;  /* 举例：改变背景颜色 */
    }
    .pay-btn-active {
      background: #4684e2;
    }
  }
}

</style>
