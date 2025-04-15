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

-- 聊天记录表
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    sender_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    chat_type VARCHAR(10) NOT NULL CHECK (chat_type IN ('private', 'room')),
    receiver_id INT NOT NULL,  -- 若为私聊则为用户ID，若为聊天室则为room_id
    message_type VARCHAR(10) NOT NULL CHECK (
        message_type IN ('text', 'image', 'file', 'audio', 'video', 'system')
    ),
    content TEXT,
    file_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 聊天室表
CREATE TABLE chat_rooms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
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

-- 文件权限表
CREATE TABLE file_permissions (
    id SERIAL PRIMARY KEY,
    file_id INT REFERENCES files(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    permission VARCHAR(20) CHECK (permission IN ('read', 'write', 'delete', 'share')),
);