<template>
  <header class="header">
    <div class="container">
      <div class="logo">
        <router-link to="/">
          <div class="logo-text">Xu Yao's Blog</div></router-link>
      </div>
      <nav class="nav">
        <ul>
          <li><router-link to="/">Home</router-link></li>
          <li><router-link to="/about">About me</router-link></li>
          <li><router-link to="/skills">Skills</router-link></li>
          <li><router-link to="/projects">Projects</router-link></li>
          <li><router-link to="/contact">Contact</router-link></li>
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
  color: #b08d57;
  font-weight: bold;
}

.router-link-exact-active {
  color: #b08d57;
  font-weight: bold;
}
</style>