<template>
  <div class="page-container">
    <!-- 头部 -->
    <Header/>
    <!-- 侧边栏 -->
    <Aside/>
    <!-- 主体 -->
    <div>
      <!-- 内容 -->
      <router-view/>
    </div>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Aside from "@/components/Aside";
import Down from "@/components/Down.vue";

export default {
  name: "Layout",
  components:{
    Down,
    Aside,
    Header
  }
}
</script>

<style scoped>

</style>