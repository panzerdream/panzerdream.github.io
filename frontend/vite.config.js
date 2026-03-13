import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  base: '/', // 设置为根路径，GitHub Pages会部署在根目录
  build: {
    outDir: 'dist', // 构建输出目录
    assetsDir: 'assets', // 静态资源目录
    emptyOutDir: true, // 构建前清空输出目录
  },
  server: {
    port: 5173, // 开发服务器端口
    open: true, // 自动打开浏览器
  }
})
