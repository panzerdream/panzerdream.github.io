# GitHub Pages 部署指南

## 项目概述
这是一个使用Vue 3构建的个人主页项目，已配置为可通过GitHub Pages免费托管。

## 部署步骤

### 1. 准备GitHub仓库
1. 在GitHub上创建一个名为 `panzerdream.github.io` 的仓库（必须完全匹配你的用户名）
2. 将本地代码推送到该仓库：
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/panzerdream/panzerdream.github.io.git
   git push -u origin main
   ```

### 2. 启用GitHub Pages
1. 进入仓库的 **Settings**（设置）
2. 在左侧菜单中选择 **Pages**（页面）
3. 在 **Source**（源）部分：
   - 选择 **GitHub Actions** 作为源
   - 或者选择 **main** 分支，文件夹选择 `/frontend/dist`
4. 点击 **Save**（保存）

### 3. 等待部署完成
1. 推送代码后，GitHub Actions会自动开始构建和部署
2. 可以在仓库的 **Actions** 标签页查看部署进度
3. 部署完成后，你的网站将在以下地址可用：
   - `https://panzerdream.github.io`

## 本地开发

### 安装依赖
```bash
cd frontend
npm install
```

### 启动开发服务器
```bash
npm run dev
```
访问：http://localhost:5173

### 构建生产版本
```bash
npm run build
```
构建结果将生成在 `frontend/dist` 目录

### 预览生产版本
```bash
npm run preview
```
访问：http://localhost:4173

## 项目结构说明

```
my_pages/
├── frontend/                    # 前端代码
│   ├── src/                    # 源代码
│   ├── public/                 # 静态资源
│   │   ├── CNAME              # 自定义域名配置
│   │   └── .nojekyll          # 禁用Jekyll处理
│   ├── dist/                   # 构建输出目录（自动生成）
│   └── package.json           # 前端依赖和脚本
├── .github/workflows/          # GitHub Actions工作流
│   └── deploy.yml             # 自动部署配置
├── backend/                    # 后端代码（已不再需要）
└── DEPLOYMENT.md              # 本文件
```

## 注意事项

1. **路由模式**：项目使用哈希模式（Hash Mode）路由，URL会包含 `#`，如 `https://panzerdream.github.io/#/about`
2. **自动部署**：每次推送到 `main` 分支都会触发自动部署
3. **自定义域名**：如需使用自定义域名：
   - 在 `frontend/public/CNAME` 文件中设置域名
   - 在域名服务商处配置CNAME记录指向 `panzerdream.github.io`
4. **缓存问题**：如果更新后网站没有变化，可能是浏览器缓存，尝试强制刷新（Ctrl+F5）

## 故障排除

### 部署失败
1. 检查GitHub Actions日志中的错误信息
2. 确保 `package.json` 中的依赖版本兼容
3. 检查Node.js版本是否为18或更高

### 页面空白
1. 检查控制台是否有JavaScript错误
2. 确保路由配置正确
3. 检查静态资源路径是否正确

### 样式丢失
1. 检查CSS文件是否被正确加载
2. 确保字体和图标CDN链接可用

## 更新网站内容

1. 修改 `frontend/src/components/` 中的Vue组件
2. 本地测试：`npm run dev`
3. 提交更改并推送到GitHub：
   ```bash
   git add .
   git commit -m "更新网站内容"
   git push origin main
   ```
4. 等待GitHub Actions自动部署完成

## 技术支持
如有问题，请参考：
- [Vue 3官方文档](https://vuejs.org/)
- [Vite官方文档](https://vitejs.dev/)
- [GitHub Pages文档](https://docs.github.com/en/pages)
- [Vue Router文档](https://router.vuejs.org/)