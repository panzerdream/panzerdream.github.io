-- 个人博客系统数据库设计
-- 版本: 1.0
-- 作者: 个人主页项目

-- 用户表（用于管理员身份验证和用户信息）
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(100),
    avatar_url VARCHAR(255),
    bio TEXT,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 个人资料表（存储个人主页信息）
CREATE TABLE IF NOT EXISTS profiles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    full_name VARCHAR(100),
    title VARCHAR(200),
    location VARCHAR(100),
    education VARCHAR(200),
    experience_years INT,
    completed_projects INT,
    client_satisfaction INT,
    github_url VARCHAR(255),
    linkedin_url VARCHAR(255),
    twitter_url VARCHAR(255),
    wechat VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    about_me TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 技能表
CREATE TABLE IF NOT EXISTS skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    proficiency INT CHECK (proficiency >= 0 AND proficiency <= 100),
    display_order INT DEFAULT 0,
    FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE,
    INDEX idx_category (category)
);

-- 项目表
CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    technologies TEXT,
    github_url VARCHAR(255),
    live_url VARCHAR(255),
    image_url VARCHAR(255),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE
);

-- 博客文章表
CREATE TABLE IF NOT EXISTS blog_posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT,
    title VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    content LONGTEXT NOT NULL,
    excerpt TEXT,
    featured_image VARCHAR(255),
    category VARCHAR(50),
    tags JSON,
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    views INT DEFAULT 0,
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_status_published (status, published_at),
    INDEX idx_slug (slug)
);

-- 打卡记录表（用于功能集成）
CREATE TABLE IF NOT EXISTS checkins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    date DATE NOT NULL,
    checkin_type VARCHAR(50) NOT NULL,
    description TEXT,
    duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_date_type (user_id, date, checkin_type),
    INDEX idx_date (date)
);

-- 联系信息表
CREATE TABLE IF NOT EXISTS contact_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    status ENUM('unread', 'read', 'replied', 'archived') DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_status (status)
);

-- 初始化数据：创建默认管理员用户（密码需要在使用时哈希处理）
-- 默认密码: admin123 (需要在前端注册时修改)
INSERT INTO users (username, email, password_hash, display_name, role) VALUES
('admin', 'admin@example.com', '$2a$10$YourHashedPasswordHere', '管理员', 'admin')
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- 初始化个人资料
INSERT INTO profiles (user_id, full_name, title, location, education, experience_years, completed_projects, client_satisfaction) VALUES
(1, '开发者', '全栈开发者 & 技术爱好者', '中国', '计算机科学', 5, 50, 100)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- 初始化技能数据
INSERT INTO skills (profile_id, category, name, proficiency, display_order) VALUES
(1, '前端技术', 'HTML5 & CSS3', 95, 1),
(1, '前端技术', 'JavaScript', 90, 2),
(1, '前端技术', 'Vue.js', 85, 3),
(1, '前端技术', 'React', 80, 4),
(1, '后端技术', 'Node.js', 88, 5),
(1, '后端技术', 'Express', 85, 6),
(1, '后端技术', 'MySQL', 82, 7),
(1, '后端技术', 'Python', 75, 8),
(1, '工具 & 其他', 'Git', 90, 9),
(1, '工具 & 其他', 'Docker', 80, 10),
(1, '工具 & 其他', 'Nginx', 75, 11),
(1, '工具 & 其他', 'Linux', 85, 12)
ON DUPLICATE KEY UPDATE proficiency = VALUES(proficiency);

-- 初始化项目数据
INSERT INTO projects (profile_id, name, description, technologies, github_url, live_url, display_order) VALUES
(1, '个人博客系统', '一个完整的个人博客系统，包含前端、后端和数据库', 'Vue.js, Element Plus, Node.js, Express, MySQL', 'https://github.com/yourusername/personal-blog', 'https://blog.example.com', 1),
(1, '电子商务平台', '全栈电子商务解决方案', 'React, Node.js, MongoDB, Stripe', 'https://github.com/yourusername/ecommerce', 'https://shop.example.com', 2),
(1, '任务管理应用', '协同任务管理工具', 'Vue.js, Express, Socket.io, PostgreSQL', 'https://github.com/yourusername/task-manager', 'https://tasks.example.com', 3)
ON DUPLICATE KEY UPDATE description = VALUES(description);