# Open Graph 图片说明

## 需要创建的图片文件

为了让社交媒体分享时显示预览图片，你需要创建一个 `og-image.png` 文件。

### 图片要求：
- **文件名**: `og-image.png`
- **位置**: `frontend/public/og-image.png`
- **尺寸**: 1200×630 像素（推荐）
- **格式**: PNG 或 JPG
- **内容**: 可以包含你的名字、头像、标语等

### 创建方法：

1. **使用设计工具**（如 Canva、Photoshop、Figma）
2. **使用代码生成**（可以使用HTML转图片工具）
3. **使用现有图片**（确保有使用权限）

### 简单示例代码（如果你会用代码生成）：

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            padding: 40px;
            width: 1200px;
            height: 630px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .name {
            font-size: 72px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .title {
            font-size: 36px;
            opacity: 0.9;
        }
        .url {
            font-size: 24px;
            margin-top: 40px;
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <div class="name">panzerdream</div>
    <div class="title">个人主页 · 开发者 · 项目展示</div>
    <div class="url">panzerdream.github.io</div>
</body>
</html>
```

### 临时解决方案：
如果你暂时不想创建图片，可以删除 `index.html` 中的以下行：
```html
<meta property="og:image" content="https://panzerdream.github.io/og-image.png">
<meta property="twitter:image" content="https://panzerdream.github.io/og-image.png">
```

### 苹果触摸图标：
同样，你可以创建一个 `apple-touch-icon.png` 文件（180×180像素）用于iOS设备的主屏幕图标。

---

**注意**：这些图片文件不是必须的，没有它们网站也能正常工作，只是社交媒体分享时可能没有预览图片。