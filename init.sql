-- 创建数据库（如果不存在）
CREATE DATABASE kim;

-- 切换到数据库
\c kim;

-- 用户表
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    display_name VARCHAR(100),
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 用户token表
CREATE TABLE user_tokens (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    token TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT (CURRENT_TIMESTAMP + INTERVAL '1 hour') -- Token expires in 1 hour
);

-- 好友表
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    contact_id INT REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('pending', 'accepted', 'blocked')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 私聊消息表
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    sender_id INT REFERENCES users(id) ON DELETE CASCADE,
    receiver_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    message_type VARCHAR(20) CHECK (message_type IN ('text', 'image', 'video', 'file')),
    file_url TEXT,
    status VARCHAR(20) CHECK (status IN ('sent', 'delivered', 'read')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 群聊表
CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL,
    creator_id INT REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 群聊成员表
CREATE TABLE group_members (
    id SERIAL PRIMARY KEY,
    group_id INT REFERENCES groups(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(20) CHECK (role IN ('admin', 'member')),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 群聊消息表
CREATE TABLE group_messages (
    id SERIAL PRIMARY KEY,
    group_id INT REFERENCES groups(id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    message_type VARCHAR(20) CHECK (message_type IN ('text', 'image', 'video', 'file')),
    file_url TEXT,
    status VARCHAR(20) CHECK (status IN ('sent', 'delivered', 'read')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 公共聊天室表
CREATE TABLE chatrooms (
    id SERIAL PRIMARY KEY,
    room_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 公共聊天室消息表
CREATE TABLE chatroom_messages (
    id SERIAL PRIMARY KEY,
    room_id INT REFERENCES chatrooms(id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    message_type VARCHAR(20) CHECK (message_type IN ('text', 'image', 'video', 'file')),
    file_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 文件存储表
CREATE TABLE files (
    id SERIAL PRIMARY KEY,
    uploader_id INT REFERENCES users(id) ON DELETE CASCADE,
    file_name TEXT,
    file_url TEXT UNIQUE NOT NULL,
    file_type VARCHAR(20) CHECK (file_type IN ('image', 'video', 'audio', 'document', 'other')),
    file_size INT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
