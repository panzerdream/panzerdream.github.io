const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// 中间件
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 数据库连接池配置
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'password',
  database: process.env.DB_NAME || 'personal_blog',
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// 测试数据库连接
async function testConnection() {
  try {
    const connection = await pool.getConnection();
    console.log('数据库连接成功');
    connection.release();
    return true;
  } catch (error) {
    console.error('数据库连接失败:', error.message);
    return false;
  }
}

// 健康检查端点
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// 获取个人资料
app.get('/api/profile', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      `SELECT p.*, u.username, u.email 
       FROM profiles p 
       JOIN users u ON p.user_id = u.id 
       WHERE u.username = 'admin'`
    );
    
    if (rows.length === 0) {
      return res.status(404).json({ error: '个人资料未找到' });
    }
    
    res.json(rows[0]);
  } catch (error) {
    console.error('获取个人资料失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 获取技能列表
app.get('/api/skills', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      `SELECT s.* FROM skills s 
       JOIN profiles p ON s.profile_id = p.id 
       JOIN users u ON p.user_id = u.id 
       WHERE u.username = 'admin'
       ORDER BY s.category, s.display_order`
    );
    res.json(rows);
  } catch (error) {
    console.error('获取技能列表失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 获取项目列表
app.get('/api/projects', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      `SELECT * FROM projects 
       WHERE profile_id = (SELECT id FROM profiles WHERE user_id = (SELECT id FROM users WHERE username = 'admin'))
       ORDER BY display_order`
    );
    res.json(rows);
  } catch (error) {
    console.error('获取项目列表失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 获取博客文章列表
app.get('/api/blog/posts', async (req, res) => {
  try {
    const { page = 1, limit = 10, status = 'published' } = req.query;
    const offset = (page - 1) * limit;
    
    const [rows] = await pool.execute(
      `SELECT id, title, slug, excerpt, featured_image, category, tags, 
              status, views, published_at, created_at 
       FROM blog_posts 
       WHERE status = ? 
       ORDER BY published_at DESC 
       LIMIT ? OFFSET ?`,
      [status, parseInt(limit), offset]
    );
    
    const [countRows] = await pool.execute(
      'SELECT COUNT(*) as total FROM blog_posts WHERE status = ?',
      [status]
    );
    
    res.json({
      posts: rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total: countRows[0].total,
        totalPages: Math.ceil(countRows[0].total / limit)
      }
    });
  } catch (error) {
    console.error('获取博客文章失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 获取单篇博客文章
app.get('/api/blog/posts/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    
    const [rows] = await pool.execute(
      `SELECT bp.*, u.display_name as author_name 
       FROM blog_posts bp 
       JOIN users u ON bp.author_id = u.id 
       WHERE bp.slug = ? AND bp.status = 'published'`,
      [slug]
    );
    
    if (rows.length === 0) {
      return res.status(404).json({ error: '文章未找到' });
    }
    
    // 更新阅读次数
    await pool.execute(
      'UPDATE blog_posts SET views = views + 1 WHERE id = ?',
      [rows[0].id]
    );
    
    res.json(rows[0]);
  } catch (error) {
    console.error('获取博客文章失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 提交联系信息
app.post('/api/contact', async (req, res) => {
  try {
    const { name, email, subject, message } = req.body;
    
    if (!name || !email || !message) {
      return res.status(400).json({ error: '姓名、邮箱和消息是必填项' });
    }
    
    const [result] = await pool.execute(
      'INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)',
      [name, email, subject || '', message]
    );
    
    res.json({ 
      success: true, 
      message: '消息发送成功', 
      id: result.insertId 
    });
  } catch (error) {
    console.error('提交联系信息失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 获取打卡记录
app.get('/api/checkins', async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    
    let query = `SELECT * FROM checkins 
                 WHERE user_id = (SELECT id FROM users WHERE username = 'admin')`;
    const params = [];
    
    if (start_date) {
      query += ' AND date >= ?';
      params.push(start_date);
    }
    
    if (end_date) {
      query += ' AND date <= ?';
      params.push(end_date);
    }
    
    query += ' ORDER BY date DESC, created_at DESC';
    
    const [rows] = await pool.execute(query, params);
    res.json(rows);
  } catch (error) {
    console.error('获取打卡记录失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 提交打卡记录
app.post('/api/checkins', async (req, res) => {
  try {
    const { date, checkin_type, description, duration_minutes } = req.body;
    
    if (!date || !checkin_type) {
      return res.status(400).json({ error: '日期和打卡类型是必填项' });
    }
    
    const [result] = await pool.execute(
      `INSERT INTO checkins (user_id, date, checkin_type, description, duration_minutes) 
       VALUES ((SELECT id FROM users WHERE username = 'admin'), ?, ?, ?, ?)`,
      [date, checkin_type, description || '', duration_minutes || 0]
    );
    
    res.json({ 
      success: true, 
      message: '打卡记录添加成功', 
      id: result.insertId 
    });
  } catch (error) {
    console.error('提交打卡记录失败:', error);
    res.status(500).json({ error: '服务器内部错误' });
  }
});

// 错误处理中间件
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: '服务器内部错误' });
});

// 启动服务器
async function startServer() {
  const dbConnected = await testConnection();
  
  if (!dbConnected) {
    console.warn('警告：数据库连接失败，部分功能可能无法使用');
  }
  
  app.listen(PORT, () => {
    console.log(`服务器运行在 http://localhost:${PORT}`);
    console.log(`API文档: http://localhost:${PORT}/api`);
  });
}

// 如果直接运行此文件
if (require.main === module) {
  startServer();
}

module.exports = app;