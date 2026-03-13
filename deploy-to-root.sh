#!/bin/bash
# 部署到GitHub Pages根目录脚本

echo "🚀 开始部署到GitHub Pages根目录..."

# 1. 构建前端应用
echo "1. 构建前端应用..."
cd frontend
npm run build
cd ..

# 2. 创建临时部署目录
echo "2. 准备部署文件..."
rm -rf deploy-root
mkdir deploy-root

# 3. 复制构建文件到临时目录
echo "3. 复制构建文件..."
cp -r frontend/dist/* deploy-root/

# 4. 复制必要的配置文件
echo "4. 添加配置文件..."
cp frontend/public/CNAME deploy-root/ 2>/dev/null || true
cp frontend/public/.nojekyll deploy-root/ 2>/dev/null || true
cp frontend/public/404.html deploy-root/ 2>/dev/null || true
cp frontend/public/_redirects deploy-root/ 2>/dev/null || true

# 5. 创建临时Git仓库并推送到main分支
echo "5. 推送到GitHub main分支..."
cd deploy-root
git init
git add -A
git commit -m "Deploy to GitHub Pages root"
git branch -M main

# 添加远程仓库（如果还没有）
git remote add origin https://github.com/panzerdream/panzerdream.github.io.git 2>/dev/null || true

# 强制推送到main分支
echo "6. 强制推送到GitHub..."
git push -f origin main

cd ..

# 6. 清理
echo "7. 清理临时文件..."
rm -rf deploy-root

echo ""
echo "✅ 部署完成！"
echo ""
echo "📢 现在请配置GitHub Pages："
echo "   1. 访问：https://github.com/panzerdream/panzerdream.github.io/settings/pages"
echo "   2. 选择：'Deploy from a branch'"
echo "   3. 选择分支：'main'"
echo "   4. 选择文件夹：'/' (root)"
echo "   5. 点击：'Save'"
echo ""
echo "🌐 等待1-2分钟，然后访问：https://panzerdream.github.io"
echo ""
echo "💡 提示：如果之前配置过Pages，可能需要等待几分钟更新。"