# 个人主页项目 - GitHub Pages 版本

这是一个使用Vue 3构建的个人主页项目，专门为GitHub Pages托管优化。

## 🚀 快速开始

### 在线访问
- **GitHub Pages地址**: https://panzerdream.github.io

### 本地开发
```bash
# 进入前端目录
cd frontend

# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build

# 预览生产版本
npm run preview
```

## 📁 项目结构

```
my_pages/
├── frontend/                    # 前端代码（GitHub Pages部署）
│   ├── src/                    # Vue组件和源代码
│   ├── public/                 # 静态资源
│   │   ├── CNAME              # GitHub Pages域名配置
│   │   └── .nojekyll          # 禁用Jekyll处理
│   ├── dist/                   # 构建输出目录
│   └── package.json           # 前端依赖和脚本
├── .github/workflows/          # GitHub Actions自动部署
│   └── deploy.yml             # 自动部署到GitHub Pages
├── backend/                    # 后端代码（保留，但不再使用）
├── DEPLOYMENT.md              # 详细部署指南
└── README.md                  # 本文件
```

## 🛠️ 技术栈

### 前端
- **框架**: Vue 3 + Composition API
- **构建工具**: Vite
- **路由**: Vue Router (哈希模式，兼容GitHub Pages)
- **UI组件**: Element Plus
- **样式**: CSS3 + 响应式设计
- **图标**: Font Awesome 6
- **字体**: Google Fonts (Inter + Poppins)

### 部署
- **托管**: GitHub Pages (免费静态网站托管)
- **CI/CD**: GitHub Actions (自动构建和部署)
- **路由**: 哈希模式，兼容静态托管

## 📄 页面内容

1. **首页** (`/`) - 个人介绍和导航
2. **关于** (`/#/about`) - 个人详细资料
3. **技能** (`/#/skills`) - 技术技能展示
4. **项目** (`/#/projects`) - 项目作品展示
5. **联系** (`/#/contact`) - 联系方式

## 🔧 配置说明

### GitHub Pages设置
1. 仓库必须命名为 `panzerdream.github.io`
2. 启用GitHub Pages，选择GitHub Actions作为源
3. 每次推送到main分支会自动部署

### 路由说明
- 使用哈希模式 (`#`) 路由，兼容静态托管
- 示例: `https://panzerdream.github.io/#/projects`

### 自定义域名
如需使用自定义域名：
1. 在 `frontend/public/CNAME` 中设置域名
2. 在域名服务商处配置CNAME记录
3. 在GitHub仓库设置中启用自定义域名

## 📝 更新内容

要更新网站内容：
1. 修改 `frontend/src/components/` 中的Vue组件
2. 本地测试: `npm run dev`
3. 提交并推送更改到GitHub
4. GitHub Actions会自动构建和部署

## 🆘 常见问题

### 页面空白
- 检查控制台错误
- 确保使用哈希模式URL访问
- 清除浏览器缓存

### 部署失败
- 查看GitHub Actions日志
- 检查Node.js版本兼容性
- 确保依赖安装正确

### 样式问题
- 检查网络连接，确保CDN资源可访问
- 验证CSS文件路径

## 📚 学习资源

- [Vue 3官方文档](https://vuejs.org/)
- [Vite官方文档](https://vitejs.dev/)
- [GitHub Pages文档](https://docs.github.com/en/pages)
- [Vue Router文档](https://router.vuejs.org/)

## 📄 许可证

本项目仅供个人学习使用。