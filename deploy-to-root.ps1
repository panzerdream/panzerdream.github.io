# PowerShell脚本：部署到GitHub Pages根目录

Write-Host "🚀 开始部署到GitHub Pages根目录..." -ForegroundColor Green

# 1. 构建前端应用
Write-Host "1. 构建前端应用..." -ForegroundColor Yellow
Set-Location frontend
npm run build
Set-Location ..

# 2. 创建临时部署目录
Write-Host "2. 准备部署文件..." -ForegroundColor Yellow
Remove-Item -Path "deploy-root" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "deploy-root" -Force

# 3. 复制构建文件到临时目录
Write-Host "3. 复制构建文件..." -ForegroundColor Yellow
Copy-Item -Path "frontend\dist\*" -Destination "deploy-root\" -Recurse -Force

# 4. 复制必要的配置文件
Write-Host "4. 添加配置文件..." -ForegroundColor Yellow
Copy-Item -Path "frontend\public\CNAME" -Destination "deploy-root\" -ErrorAction SilentlyContinue
Copy-Item -Path "frontend\public\.nojekyll" -Destination "deploy-root\" -ErrorAction SilentlyContinue
Copy-Item -Path "frontend\public\404.html" -Destination "deploy-root\" -ErrorAction SilentlyContinue
Copy-Item -Path "frontend\public\_redirects" -Destination "deploy-root\" -ErrorAction SilentlyContinue

# 5. 创建临时Git仓库并推送到main分支
Write-Host "5. 推送到GitHub main分支..." -ForegroundColor Yellow
Set-Location deploy-root
git init
git add -A
git commit -m "Deploy to GitHub Pages root"
git branch -M main

# 添加远程仓库（如果还没有）
git remote add origin https://github.com/panzerdream/panzerdream.github.io.git 2>$null
if ($LASTEXITCODE -ne 0) {
    # 如果添加失败，可能是已经存在，尝试设置URL
    git remote set-url origin https://github.com/panzerdream/panzerdream.github.io.git
}

# 强制推送到main分支
Write-Host "6. 强制推送到GitHub..." -ForegroundColor Yellow
git push -f origin main

Set-Location ..

# 6. 清理
Write-Host "7. 清理临时文件..." -ForegroundColor Yellow
Remove-Item -Path "deploy-root" -Recurse -Force

Write-Host "" -ForegroundColor Green
Write-Host "✅ 部署完成！" -ForegroundColor Green
Write-Host "" -ForegroundColor Green
Write-Host "📢 现在请配置GitHub Pages：" -ForegroundColor Cyan
Write-Host "   1. 访问：https://github.com/panzerdream/panzerdream.github.io/settings/pages" -ForegroundColor White
Write-Host "   2. 选择：'Deploy from a branch'" -ForegroundColor White
Write-Host "   3. 选择分支：'main'" -ForegroundColor White
Write-Host "   4. 选择文件夹：'/' (root)" -ForegroundColor White
Write-Host "   5. 点击：'Save'" -ForegroundColor White
Write-Host "" -ForegroundColor Cyan
Write-Host "🌐 等待1-2分钟，然后访问：https://panzerdream.github.io" -ForegroundColor Magenta
Write-Host "" -ForegroundColor Cyan
Write-Host "💡 提示：如果之前配置过Pages，可能需要等待几分钟更新。" -ForegroundColor Yellow