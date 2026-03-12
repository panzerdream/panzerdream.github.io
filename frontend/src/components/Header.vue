<template>
  <header class="header">
    <div class="container">
      <div class="logo">
        <router-link to="/">个人首页</router-link>
      </div>
      <nav class="nav">
        <ul>
          <li><router-link to="/">首页</router-link></li>
          <li><router-link to="/about">关于我</router-link></li>
          <li><router-link to="/skills">技能</router-link></li>
          <li><router-link to="/projects">项目</router-link></li>
          <li><router-link to="/contact">联系我</router-link></li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script setup>
// 组件逻辑可以在这里添加
</script>

<style scoped>
/* 样式已在全局CSS中定义 */

/* 添加活动链接样式 */
.router-link-active {
  color: #4a90e2;
  font-weight: bold;
}

.router-link-exact-active {
  color: #4a90e2;
  font-weight: bold;
}
</style>