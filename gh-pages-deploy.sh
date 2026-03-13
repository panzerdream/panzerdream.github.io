#!/bin/bash
# GitHub Pages 手动部署脚本
# 使用方法：在项目根目录运行 ./gh-pages-deploy.sh

echo "开始部署到GitHub Pages..."

# 构建前端
echo "1. 构建前端应用..."
cd frontend
npm run build
cd ..

# 创建临时目录并复制构建文件
echo "2. 准备部署文件..."
rm -rf deploy
mkdir deploy
cp -r frontend/dist/* deploy/

# 添加必要的GitHub Pages文件
echo "3. 添加GitHub Pages配置文件..."
cp frontend/public/CNAME deploy/ 2>/dev/null || true
cp frontend/public/.nojekyll deploy/ 2>/dev/null || true
cp frontend/public/404.html deploy/ 2>/dev/null || true

# 初始化Git并推送到gh-pages分支
echo "4. 推送到GitHub..."
cd deploy
git init
git add -A
git commit -m "Deploy to GitHub Pages"
git branch -M gh-pages
git remote add origin https://github.com/panzerdream/panzerdream.github.io.git
git push -f origin gh-pages
cd ..

echo "5. 清理临时文件..."
rm -rf deploy

echo "✅ 部署完成！"
echo "📢 请在GitHub仓库设置中："
echo "   1. 进入 Settings > Pages"
echo "   2. 选择 'Deploy from a branch'"
echo "   3. 选择 'gh-pages' 分支"
echo "   4. 选择 '/' (根目录)"
echo "   5. 点击 Save"
echo ""
echo "🌐 你的网站将在几分钟后可用：https://panzerdream.github.io"