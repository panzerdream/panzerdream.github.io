<template>
  <section class="hero">
    <div class="container">
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">你好，我是<span class="highlight">开发者</span></h1>
          <p class="hero-subtitle">全栈开发者 & 技术爱好者</p>
          <p class="hero-description">
            专注于构建优雅、高效的Web应用，热爱学习新技术，享受解决问题的过程。
          </p>
          <div class="hero-buttons">
            <router-link to="/projects" class="btn btn-primary">查看我的项目</router-link>
            <router-link to="/contact" class="btn btn-secondary">联系我</router-link>
          </div>
        </div>
        <div class="hero-image">
          <div class="avatar-placeholder">
            <i class="fas fa-user-circle"></i>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// 组件逻辑可以在这里添加
</script>

<style scoped>
/* 样式已在全局CSS中定义 */
</style>