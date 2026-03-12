# Vue Router 介绍

## 什么是 Vue Router？

Vue Router 是 Vue.js 官方的路由管理器。它和 Vue.js 的核心深度集成，让构建单页面应用（SPA）变得易如反掌。

## 为什么需要 Vue Router？

在本次项目改造前，我们的网站存在以下问题：

### 问题分析
1. **所有内容在同一个页面**：所有组件（首页、关于、技能、项目、联系）都在同一个 HTML 页面中渲染
2. **导航只是页面内滚动**：点击导航链接只是滚动到页面的不同部分，URL 显示为锚点（如 `#about`）
3. **缺乏真正的页面跳转**：无法实现独立的页面和 URL

### Vue Router 带来的好处
1. **真正的页面分离**：每个页面都是独立的组件，有自己的 URL
2. **更好的用户体验**：页面跳转更流畅，浏览器前进/后退按钮正常工作
3. **SEO 友好**：每个页面有独立的 URL，便于搜索引擎索引
4. **代码组织更清晰**：页面逻辑分离，便于维护

## Vue Router 核心概念

### 1. 路由 (Route)
路由定义了 URL 路径和组件之间的映射关系。

```javascript
const routes = [
  {
    path: '/about',      // URL 路径
    name: 'About',       // 路由名称
    component: AboutPage // 对应的组件
  }
]
```

### 2. 路由器 (Router)
路由器是 Vue Router 的核心实例，管理所有路由。

```javascript
const router = createRouter({
  history: createWebHistory(), // 使用 HTML5 History 模式
  routes                      // 路由配置
})
```

### 3. 路由视图 (Router View)
`<router-view>` 是一个组件，用于显示当前路由对应的页面内容。

```vue
<template>
  <div id="app">
    <Header />
    <main>
      <router-view />  <!-- 这里显示当前页面 -->
    </main>
    <Footer />
  </div>
</template>
```

### 4. 路由链接 (Router Link)
`<router-link>` 是 Vue Router 提供的导航组件，用于替代传统的 `<a>` 标签。

```vue
<!-- 传统方式（错误） -->
<a href="#about">关于我</a>

<!-- Vue Router 方式（正确） -->
<router-link to="/about">关于我</router-link>
```

## 本次项目改造步骤

### 1. 安装 Vue Router
```bash
npm install vue-router@4
```

### 2. 创建路由配置
创建 `src/router/index.js` 文件，定义所有路由。

### 3. 创建页面组件
将原来的内容组件包装成页面组件：
- `HomePage.vue` - 首页
- `AboutPage.vue` - 关于页面
- `SkillsPage.vue` - 技能页面
- `ProjectsPage.vue` - 项目页面
- `ContactPage.vue` - 联系页面

### 4. 更新主应用
修改 `main.js` 和 `App.vue` 以使用 Vue Router。

### 5. 更新导航
将 Header 和 Footer 中的锚点链接改为 `<router-link>`。

## 关键代码示例

### 路由配置 (router/index.js)
```javascript
import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '../components/HomePage.vue'
import AboutPage from '../components/AboutPage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomePage
  },
  {
    path: '/about',
    name: 'About',
    component: AboutPage
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
```

### 主应用配置 (main.js)
```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)
app.use(router)  // 使用路由器
app.mount('#app')
```

### 应用模板 (App.vue)
```vue
<template>
  <div id="app">
    <Header />
    <main>
      <router-view />  <!-- 动态显示当前页面 -->
    </main>
    <Footer />
  </div>
</template>
```

### 导航组件 (Header.vue)
```vue
<template>
  <nav>
    <router-link to="/">首页</router-link>
    <router-link to="/about">关于我</router-link>
  </nav>
</template>
```

## 路由模式

### HTML5 History 模式
我们使用的是 `createWebHistory()`，它创建的是 "干净" 的 URL，如：
- `http://example.com/about`
- `http://example.com/projects`

### Hash 模式
另一种选择是 `createWebHashHistory()`，它使用 URL 的 hash 部分：
- `http://example.com/#/about`
- `http://example.com/#/projects`

## 常见问题解答

### Q: 为什么我的页面刷新后显示 404？
A: 这是因为服务器没有配置 SPA 回退。需要配置服务器，让所有未匹配的路径都返回 `index.html`。

### Q: 如何添加页面切换动画？
A: 可以使用 Vue 的过渡组件包裹 `<router-view>`：
```vue
<router-view v-slot="{ Component }">
  <transition name="fade">
    <component :is="Component" />
  </transition>
</router-view>
```

### Q: 如何获取当前路由信息？
A: 在组件中使用 `useRoute()`：
```javascript
import { useRoute } from 'vue-router'

const route = useRoute()
console.log(route.path)    // 当前路径
console.log(route.name)    // 路由名称
```

## 学习资源

1. [Vue Router 官方文档](https://router.vuejs.org/)
2. [Vue.js 官方教程](https://vuejs.org/guide/)
3. [Vue Router 示例项目](https://github.com/vuejs/router/tree/main/packages/router/examples)

## 总结

通过引入 Vue Router，我们成功将原来的单页面滚动网站改造成了真正的多页面应用。现在：
- 每个页面都有独立的 URL
- 导航点击会跳转到新页面，而不是页面内滚动
- 浏览器历史记录正常工作
- 代码结构更清晰，便于维护和扩展

这对于用户体验和网站的可维护性都是重要的改进。