<template>
  <section class="hero">
    <div class="container">
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">Fdy Welcome!</h1>
          <p class="hero-subtitle">欢迎来到我的主页，希望通过这个主页你可以了解我、我的项目和我的技术爱好。</p>
          <p class="hero-description">
            GitHub 地址：<a href="https://github.com/panzerdream" target="_blank" class="github-link">我的GitHub</a>
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