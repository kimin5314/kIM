# kIM

## 1. 项目概述
**项目名称**：kIM

**目标**：构建一个支持 **端到端加密（E2EE）**、**匿名聊天** 和 **公共聊天室** 的安全即时通讯（IM）平台。

**用户群体**：
- 个人用户（希望保护隐私）
- 组织或团队（希望加密通讯）
- 开发者（希望自托管 IM 解决方案）

**核心特性**：
- **端到端加密（E2EE）**（逐步实现）
- **支持私聊 & 群聊**
- **公共聊天室**
- **匿名模式（无需手机号注册）**
- **文件传输 & 加密存储**
- **推送通知（Web & Mobile）**
- **Web 端 & 移动端支持**

---

## 2. 功能需求

### 2.1 用户管理
- [ ] 用户注册 / 登录（匿名 / OIDC 可选）
- [ ] 昵称 / 头像设置
- [ ] 多设备支持（同步密钥）
- [ ] 公钥管理（端到端加密所需）

### 2.2 即时通讯
- [ ] **私聊**（1 对 1 聊天）
- [ ] **群聊**（支持端到端加密群聊）
- [ ] **公共聊天室**（无需登录即可加入）
- [ ] **离线消息存储**
- [ ] **消息撤回 & 编辑**
- [ ] **已读 / 未读状态**

### 2.3 加密 & 安全
- [ ] **端到端加密（逐步实现）**
- [ ] **公钥交换 & 信任机制**
- [ ] **密钥轮换 & 前向安全性**
- [ ] **本地消息存储加密（设备端加密）**

### 2.4 文件 & 媒体
- [ ] 发送 **图片 / 视频 / 文件**
- [ ] 服务器存储 **仅存密文**
- [ ] 文件加密（AES-256）

### 2.5 推送通知
- [ ] 消息提醒（移动端 & 桌面端）
- [ ] Web Push / Firebase / APNs

---

## 3. 非功能性需求

### 3.1 性能
- **并发支持**：至少支持 **5000+ 在线用户**
- **消息延迟**：低于 **100ms**
- **存储优化**：数据库 & 缓存策略（Redis / PostgreSQL）

### 3.2 安全性
- **服务器不存储明文消息**
- **防止 MITM 攻击**
- **DDoS & 滥用防护**

### 3.3 可扩展性
- 未来支持 **P2P & 去中心化**
- 支持插件扩展（API Hook）

---

## 4. 技术选型

### 4.1 后端
- **语言**：Go / Elixir / Node.js
- **通信协议**：WebSocket + REST API / XMPP / Matrix
- **数据库**：PostgreSQL + Redis
- **文件存储**：MinIO / S3

### 4.2 前端
- **Web 端**：React / Vue
- **移动端**：Flutter / React Native
- **本地加密存储**（IndexedDB / SQLite）

### 4.3 加密方案
- **AES-256 + ECDH（第一阶段）**
- **Signal Protocol（第二阶段）**

---

## 5. API 设计（示例）

### 5.1 用户 API
```http
POST /api/register
Content-Type: application/json
{
  "username": "user123",
  "password": "securepassword"
}
```
```http
POST /api/login
Content-Type: application/json
{
  "username": "user123",
  "password": "securepassword"
}
```

### 5.2 消息 API
```http
POST /api/message/send
Content-Type: application/json
{
  "sender": "user123",
  "receiver": "user456",
  "content": "BASE64_ENCODED_CIPHERTEXT",
  "encrypted": true,
  "encryption_type": "AES-256-GCM"
}
```
```http
GET /api/message/history?user=user456
```

---

## 6. 部署 & 运维

### 6.1 开发环境
- `docker-compose` + `SQLite`
- WebSocket 服务器（Go / Node.js）

### 6.2 生产环境
- Kubernetes 自动伸缩
- WebSocket 负载均衡（Nginx / Traefik）
- **数据库：PostgreSQL + Redis**
- **静态文件托管（Vercel / Netlify）**
- **移动端：App Store / Google Play**

---

## 7. 未来扩展
- [ ] **P2P 模式**（去中心化，减少服务器依赖）
- [ ] **Tor / I2P 支持**（抗审查）
- [ ] **区块链身份验证**（Web3 / DID）

---

## 8. 版本规划
| 版本 | 主要特性 |
|------|------------------------------------|
| v1.0 | 基础 IM 功能（私聊、群聊、公聊） |
| v1.1 | 端到端加密（私聊）                |
| v1.2 | 群聊加密 + 文件加密                |
| v2.0 | P2P 支持 + 完全去中心化            |
