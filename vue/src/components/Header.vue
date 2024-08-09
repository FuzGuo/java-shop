
<template>
  <div style="height:50px;line-height: 50px;border-bottom: 1px solid #ccc;display: flex">

    <!-- SVG image container -->
    <div style="flex: 0 0 auto; padding: 10px;">

      <img src="https://images.ctfassets.net/xwxknivhjv1b/5CrY7L3asNKtTfZTEq4155/20e221344f16a54b5b4e8787b39c349f/CPU-Hero-Image1.svg" alt="Logo" style="height: 30px;" />
    </div>
    <div style="flex: 1"></div>

    <div style="display: flex; align-items: center; font-family: Arial, sans-serif;">
      <!-- 增强按钮样式，并加入分隔线 -->
      <div style="margin-right: 20px; display: flex; align-items: center;">
        <button @click="$router.push('/person')" style="border: none; background: none; margin-right: 10px; color: #333; font-size: 14px; cursor: pointer;">个人信息</button>
        <span style="background-color: grey; width: 1px; height: 20px; margin-right: 10px;"></span>
        <button @click="logout" style="border: none; background: none; color: #333; font-size: 14px; cursor: pointer;">退出系统</button>
      </div>
      <div>
        <el-image
            v-if="user.avatar"
            style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-top: 15px;margin-right: 10px;"
        :src="user.avatar"
        fit="cover"
        />
        <img v-else
             src="https://freesvg.org/img/abstract-user-flat-1.png"
             style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-top: 15px;margin-right: 10px;"
        alt="备用头像"/>
      </div>
      <!-- 用户昵称样式 -->
      <span style="margin-right: 10px;color: #555; font-size: 16px; font-weight: bold;">
    欢迎，{{ user.nickName }}
  </span>
    </div>

  </div>
</template>

<script>
import {defineComponent} from "vue";
import {ArrowDownBold} from "@element-plus/icons";

export default defineComponent({
  name:"Header",
  props:['user'],
  data(){
    return{
      user:{}
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.user= JSON.parse(str)
  },
  components: {
    ArrowDownBold,
  },
  methods:{
    logout(){
      sessionStorage.setItem("user", JSON.stringify(null))
      this.$router.push('/login')
    }
  }
})
</script>

<style scoped>

</style>