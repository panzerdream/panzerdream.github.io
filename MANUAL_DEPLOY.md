# 手动部署到GitHub Pages指南

由于GitHub Actions工作流可能有问题，这里提供手动部署方法。

## 方法1：使用分支部署（推荐）

### 步骤1：构建项目
```bash
# 进入前端目录
cd frontend

# 安装依赖（如果还没安装）
npm install

# 构建项目
npm run build
```

### 步骤2：配置GitHub Pages
1. 访问：`https://github.com/panzerdream/panzerdream.github.io/settings/pages`
2. 在"Source"部分选择：**"Deploy from a branch"**
3. 选择分支：**"main"**
4. 选择文件夹：**"/frontend/dist"**
5. 点击 **"Save"**

### 步骤3：访问网站
等待1-2分钟，然后访问：`https://panzerdream.github.io`

## 方法2：使用gh-pages分支

### 步骤1：运行部署脚本
```bash
# 在项目根目录运行
./gh-pages-deploy.sh
```

### 步骤2：配置GitHub Pages
1. 访问：`https://github.com/panzerdream/panzerdream.github.io/settings/pages`
2. 在"Source"部分选择：**"Deploy from a branch"**
3. 选择分支：**"gh-pages"**
4. 选择文件夹：**"/"** (根目录)
5. 点击 **"Save"**

## 方法3：直接上传文件

### 步骤1：准备文件
1. 构建项目：`cd frontend && npm run build`
2. 进入 `frontend/dist` 目录
3. 压缩所有文件为ZIP文件

### 步骤2：创建新仓库
1. 在GitHub创建新仓库：`panzerdream.github.io`
2. 不要初始化README、.gitignore或license
3. 上传ZIP文件并解压

### 步骤3：配置GitHub Pages
1. 进入仓库Settings > Pages
2. 选择 **"main"** 分支，**"/"** 根目录
3. 点击 **"Save"**

## 故障排除

### 问题：仍然看到README.md
**解决**：
1. 确保GitHub Pages配置正确
2. 清除浏览器缓存（Ctrl+F5）
3. 等待5-10分钟让GitHub更新

### 问题：页面空白
**解决**：
1. 检查URL是否正确：`https://panzerdream.github.io/#/`
2. 查看浏览器控制台错误
3. 确保使用哈希路由：URL中应有 `#`

### 问题：样式丢失
**解决**：
1. 检查网络，确保CDN资源可访问
2. 验证CSS文件路径
3. 重新构建项目

## 快速检查清单

- [ ] 项目已构建：`npm run build` 成功
- [ ] `frontend/dist` 目录中有 `index.html`
- [ ] GitHub Pages已配置正确分支和文件夹
- [ ] 等待了足够时间（1-5分钟）
- [ ] 使用正确URL：`https://panzerdream.github.io`

## 紧急解决方案

如果以上方法都不行，可以使用最直接的方法：

1. **创建新仓库**：`panzerdream.github.io`
2. **只上传必要文件**：
   - `frontend/dist/index.html`
   - `frontend/dist/assets/` 目录
   - `frontend/dist/favicon.ico`
3. **配置Pages**：main分支，根目录
4. **访问**：`https://panzerdream.github.io`

## 技术支持

如果仍有问题：
1. 检查GitHub Pages状态：`https://www.githubstatus.com/`
2. 查看GitHub文档：`https://docs.github.com/pages`
3. 在GitHub仓库的Issues中提问