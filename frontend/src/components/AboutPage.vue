<template>
  <div class="about-page">
    <About />
  </div>
</template>

<script setup>
import About from './About.vue'
</script>

<style scoped>
.about-page {
  min-height: 100vh;
  padding-top: 80px; /* 给header留出空间 */
}
</style>