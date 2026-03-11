## 项目架构

本项目采用现代Web应用架构，实现了前后端分离的设计模式：

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   前端应用       │────▶│   后端API       │────▶│   数据库        │
│   (Vue.js)      │     │   (Express)     │     │   (MySQL)       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   用户界面       │     │   RESTful API   │     │   数据存储      │
│   组件化设计     │     │   业务逻辑      │     │   持久化        │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### 架构特点
1. **前后端分离**：前端负责UI展示和用户交互，后端提供数据API
2. **组件化设计**：前端采用Vue.js组件化开发，提高代码复用性
3. **RESTful API**：后端提供标准的RESTful接口，便于扩展和维护
4. **容器化部署**：使用Docker实现环境一致性，便于部署和扩展

## 详细技术栈

### 前端技术栈
- **框架**：Vue.js 3.5 + Composition API
- **构建工具**：Vite 7.3（快速构建和热重载）
- **UI组件库**：Element Plus 2.13（现代化UI组件）
- **HTTP客户端**：Axios 1.13（API请求处理）
- **样式**：CSS3 + Flexbox/Grid + 响应式设计
- **图标库**：Font Awesome 6.4
- **字体**：Google Fonts (Inter + Poppins)

### 后端技术栈
- **运行时**：Node.js 18+
- **框架**：Express 5.2（Web应用框架）
- **数据库驱动**：MySQL2 3.19（MySQL数据库连接）
- **中间件**：CORS 2.8（跨域资源共享）
- **环境管理**：Dotenv 17.3（环境变量管理）
- **开发工具**：Nodemon（开发热重载）

### 数据库技术栈
- **数据库**：MySQL 8.0（关系型数据库）
- **版本控制**：数据库模式版本管理
- **连接池**：MySQL2连接池管理

### 部署与运维
- **容器化**：Docker + Docker Compose
- **Web服务器**：Nginx（前端静态文件服务+反向代理）
- **进程管理**：PM2（可选，用于生产环境）

## 项目结构

```
my_pages/
├── frontend/                 # Vue.js前端项目
│   ├── src/
│   │   ├── components/       # Vue组件
│   │   │   ├── Header.vue    # 导航栏组件
│   │   │   ├── Hero.vue      # 首页英雄区域
│   │   │   ├── About.vue     # 关于我组件
│   │   │   ├── Skills.vue    # 技能展示组件
│   │   │   ├── Projects.vue  # 项目展示组件
│   │   │   ├── Contact.vue   # 联系我组件
│   │   │   └── Footer.vue    # 页脚组件
│   │   ├── App.vue           # 主应用组件
│   │   ├── main.js           # 应用入口文件
│   │   └── style.css         # 全局样式文件
│   ├── public/               # 静态资源
│   ├── index.html            # HTML模板
│   ├── vite.config.js        # Vite配置
│   ├── package.json          # 前端依赖配置
│   ├── Dockerfile            # 前端容器配置
│   └── nginx.conf            # Nginx配置
├── backend/                  # Express后端项目
│   ├── server.js            # 主服务器文件
│   ├── package.json         # 后端依赖配置
│   ├── .env.example         # 环境变量示例
│   └── Dockerfile           # 后端容器配置
├── database_schema.sql      # 数据库模式文件
├── docker-compose.yml       # Docker编排配置
├── README.md                # 项目文档
└── 原始文件备份/
    ├── index.html           # 原始静态页面
    └── style.css            # 原始样式文件
```

## 启动与运行指南

### 开发环境运行

#### 前端开发服务器
```bash
cd frontend
npm install          # 安装依赖
npm run dev          # 启动开发服务器
```
访问：http://localhost:5173

#### 后端开发服务器
```bash
cd backend
npm install          # 安装依赖
npm start            # 启动服务器
```
访问：http://localhost:3000/api/health

### 生产环境部署（Docker方式）

1. **安装Docker Desktop**
   - Windows：下载并安装Docker Desktop for Windows
   - 启动Docker服务

2. **使用Docker Compose启动完整系统**
   ```bash
   docker-compose up -d
   ```

3. **访问服务**
   - 前端应用：http://localhost:8080
   - 后端API：http://localhost:3000
   - MySQL数据库：localhost:3306

4. **停止服务**
   ```bash
   docker-compose down
   ```

### 数据库初始化
Docker Compose会自动执行 `database_schema.sql` 文件，初始化数据库并创建：
- 默认管理员用户：`admin` / `admin123`
- 个人资料数据
- 技能数据
- 示例项目数据

## API接口文档

### 基础信息
- **基础URL**：`http://localhost:3000/api`
- **响应格式**：JSON
- **认证方式**：无（开发版），后续可添加JWT

### 健康检查
```
GET /api/health
```
响应示例：
```json
{
  "status": "ok",
  "timestamp": "2026-03-11T08:00:00.000Z"
}
```

### 个人资料
```
GET /api/profile
```
获取个人主页的基本信息。

### 技能列表
```
GET /api/skills
```
获取技能分类和熟练度信息。

### 项目列表
```
GET /api/projects
```
获取项目展示信息。

### 博客文章
```
GET /api/blog/posts
```
获取博客文章列表，支持分页：
- `page`：页码（默认1）
- `limit`：每页数量（默认10）
- `status`：文章状态（published/draft）

```
GET /api/blog/posts/:slug
```
获取单篇博客文章的详细内容。

### 联系表单
```
POST /api/contact
```
提交联系信息：
```json
{
  "name": "张三",
  "email": "zhangsan@example.com",
  "subject": "合作咨询",
  "message": "您好，希望与您合作..."
}
```

### 打卡记录
```
GET /api/checkins
```
获取打卡记录，支持日期筛选：
- `start_date`：开始日期
- `end_date`：结束日期

```
POST /api/checkins
```
提交打卡记录：
```json
{
  "date": "2026-03-11",
  "checkin_type": "学习",
  "description": "学习了Vue 3新特性",
  "duration_minutes": 120
}
```

## 功能详细说明

### 1. 个人主页展示
- **响应式设计**：适配桌面、平板、手机等不同设备
- **现代化UI**：使用Element Plus组件库，界面美观
- **平滑滚动**：页面内导航平滑滚动效果
- **动态技能条**：技能熟练度可视化展示

### 2. 项目展示系统
- **项目分类展示**：按技术栈分类展示项目
- **项目详情**：包含项目描述、技术栈、链接等信息
- **交互效果**：卡片悬停动画效果

### 3. 博客系统
- **文章管理**：支持文章的发布、编辑、分类
- **Markdown支持**：支持Markdown格式内容编辑
- **分类标签**：文章按分类和标签组织
- **阅读统计**：记录文章阅读次数
- **搜索功能**：支持文章搜索（待实现）

### 4. 打卡功能
- **学习记录**：记录每日学习内容和时长
- **工作日志**：记录工作进度和成果
- **习惯养成**：支持习惯打卡和统计
- **数据可视化**：打卡数据图表展示（待实现）

### 5. 联系功能
- **联系表单**：访客可以通过表单联系
- **社交媒体链接**：展示GitHub、LinkedIn等社交账号
- **多种联系方式**：提供邮箱、电话、微信等多种联系途径

### 6. 管理员功能
- **内容管理**：管理个人资料、技能、项目等内容
- **博客管理**：发布、编辑、删除博客文章
- **消息管理**：查看和回复联系消息
- **数据统计**：查看网站访问统计（待实现）

## 数据库设计

### 核心数据表

#### users（用户表）
存储用户信息，用于身份验证和权限管理。

#### profiles（个人资料表）
存储个人主页的基本信息和统计数据。

#### skills（技能表）
存储技能分类和熟练度信息。

#### projects（项目表）
存储项目展示信息。

#### blog_posts（博客文章表）
存储博客文章内容及相关信息。

#### checkins（打卡记录表）
存储打卡记录信息。

#### contact_messages（联系信息表）
存储访客联系信息。

### 数据库关系
- `users` 与 `profiles`：一对一关系
- `profiles` 与 `skills`：一对多关系
- `profiles` 与 `projects`：一对多关系
- `users` 与 `blog_posts`：一对多关系
- `users` 与 `checkins`：一对多关系

## Docker部署配置

### 容器服务
1. **MySQL容器**（`personal_blog_mysql`）
   - 端口：3306:3306
   - 数据卷：持久化存储数据
   - 健康检查：确保数据库服务可用

2. **后端容器**（`personal_blog_backend`）
   - 端口：3000:3000
   - 依赖：等待MySQL服务健康
   - 环境变量：数据库连接配置

3. **前端容器**（`personal_blog_frontend`）
   - 端口：8080:80
   - 依赖：后端服务
   - 配置：Nginx反向代理到后端API

### 网络配置
- 容器间通过Docker内部网络通信
- 前端通过Nginx代理访问后端API
- 数据库仅对后端服务开放

### 数据持久化
- MySQL数据通过Docker卷持久化
- 应用代码通过绑定挂载实时更新（开发模式）

## 开发说明

### 前端开发
1. **组件开发规范**
   - 使用Vue 3 Composition API
   - 组件文件命名：PascalCase.vue
   - 样式使用scoped CSS

2. **API调用规范**
   - 使用Axios进行HTTP请求
   - API接口统一管理
   - 错误处理统一拦截

3. **状态管理**
   - 简单场景使用组件状态
   - 复杂场景可使用Pinia（待实现）

### 后端开发
1. **代码结构规范**
   - 控制器、服务、模型分层
   - 错误处理中间件
   - 请求验证中间件

2. **数据库操作**
   - 使用连接池管理数据库连接
   - SQL查询使用参数化防止注入
   - 事务处理保证数据一致性

3. **API设计原则**
   - RESTful风格
   - 合适的HTTP状态码
   - 统一的响应格式

### 测试策略
1. **单元测试**（待实现）
   - 前端：Vitest + Vue Test Utils
   - 后端：Jest + Supertest

2. **集成测试**（待实现）
   - API接口测试
   - 数据库操作测试

3. **端到端测试**（待实现）
   - 使用Cypress进行UI测试

## 后续开发计划

### 短期计划
1. 实现用户认证系统（JWT）
2. 添加博客文章评论功能
3. 实现文件上传功能
4. 添加数据统计和图表展示

### 中期计划
1. 实现SSR服务端渲染（Nuxt.js）
2. 添加实时通知功能（WebSocket）
3. 实现多语言支持
4. 添加SEO优化

### 长期计划
1. 微服务架构改造
2. 引入消息队列
3. 实现分布式缓存
4. 容器编排（Kubernetes）

## 常见问题

### Q1: 如何修改个人资料？
A: 可以通过修改 `database_schema.sql` 文件中的初始化数据，或者通过管理员界面（待实现）进行修改。

### Q2: 如何添加新的技能？
A: 在 `database_schema.sql` 文件的 `skills` 表初始化部分添加新的技能记录。

### Q3: 如何部署到生产服务器？
A: 1. 准备服务器环境（安装Docker）
   2. 上传项目代码
   3. 修改环境变量配置文件
   4. 运行 `docker-compose up -d`
   5. 配置域名和SSL证书

### Q4: 如何备份数据库？
A: 使用MySQL的 `mysqldump` 工具或Docker卷备份。

## 贡献指南

欢迎提交Issue和Pull Request来改进这个项目。

### 开发流程
1. Fork本仓库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 开启Pull Request

### 代码规范
- 遵循ESLint规则
- 提交前运行代码检查
- 编写清晰的提交信息
- 添加必要的注释

## 许可证

本项目采用MIT许可证，详见LICENSE文件。

## 联系方式

- 项目维护者：[开发者]
- 邮箱：contact@example.com
- GitHub：[Your GitHub Username]

---

**最后更新**：2026-03-11
**版本**：1.0.0