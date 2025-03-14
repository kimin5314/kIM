# 用户管理前后端交互设计(主要后端)

## Users Table (用户表)

| Column        | Type         | Constraints               | Description (说明) |
|---------------|--------------|---------------------------|------------------|
| id            | SERIAL       | PRIMARY KEY               | 用户ID (唯一标识)      |
| username      | VARCHAR(50)  | UNIQUE, NOT NULL          | 用户名 (唯一)         |
| password_hash | TEXT         | NOT NULL                  | 加密后的密码           |
| display_name  | VARCHAR(100) |                           | 昵称               |
| avatar_url    | TEXT         |                           | 头像URL            |
| created_at    | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP | 账户创建时间           |

---

## User Tokens Table (用户Token表)

| Column     | Type      | Constraints                                     | Description (说明) |
|------------|-----------|-------------------------------------------------|------------------|
| id         | SERIAL    | PRIMARY KEY                                     | Token ID (唯一标识)  |
| user_id    | INT       | REFERENCES users(id) ON DELETE CASCADE          | 关联的用户ID          |
| token      | TEXT      | UNIQUE, NOT NULL                                | 认证Token (唯一)     |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                       | Token创建时间        |
| expires_at | TIMESTAMP | DEFAULT (CURRENT_TIMESTAMP + INTERVAL '1 hour') | Token过期时间        |

---

## Contacts Table (好友表)

| Column     | Type        | Constraints                                          | Description (说明)     |
|------------|-------------|------------------------------------------------------|----------------------|
| id         | SERIAL      | PRIMARY KEY                                          | 记录ID (唯一标识)          |
| user_id    | INT         | REFERENCES users(id) ON DELETE CASCADE               | 用户ID                 |
| contact_id | INT         | REFERENCES users(id) ON DELETE CASCADE               | 好友ID                 |
| status     | VARCHAR(20) | CHECK (status IN ('pending', 'accepted', 'blocked')) | 好友状态 (待确认, 已接受, 已拉黑) |
| created_at | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                            | 好友关系创建时间             |

## 用户注册

### 后端

处理用户注册请求, 将用户信息存入数据库, 接受参数为用户名, 密码, 昵称, 需查询用户名是否有重复.

- API: /api/user/register
- Method: POST
- Request:
    - Body:
        - username: string
        - password: string
        - display_name: string
- Response:
    - Body:
        - code: int
        - message: string

### 前端

表单输入用户名和密码, 密码需要二次确认, 不一致时有ui提醒, 对密码加密. 点击注册按钮, 向后端发送请求,
根据返回值提示注册成功或失败并给出解释(如用户名重复).

## 用户登录

### 后端

处理用户登录请求, 验证用户名和密码是否匹配, 返回登录成功或失败的信息, 成功时生成token, 存入数据库后返回给前端用于后续认证.

- API: /api/user/login
- Method: POST
- Request:
    - Body:
        - username: string
        - password: string
- Response:
    - Body:
        - code: int
        - message: string
        - token: string

### 前端

表单输入用户名和密码, 对密码加密, 点击登录按钮, 向后端发送请求, 根据返回值提示登录成功或失败并给出解释(如用户名不存在).
登录成功后将token存入cookies, 并跳转到主页.

## 用户信息获取

### 后端

处理用户信息获取请求, 验证token, 验证成功后查询数据库获取用户信息.

- API: /api/user/profile
- Method: POST
- Authorization: Bearer token
- Request:
- Response:
    - Body:
        - code: int
        - message: string
        - user: object

## 用户信息修改

### 后端

处理用户信息修改请求, 接受修改的数据(目前只有昵称), 需验证token, 验证成功后更新数据库用户信息.

- API: /api/user/update
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - display_name: string
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在个人信息页面修改昵称, 点击保存按钮, 向后端发送请求, 根据返回值提示修改成功或失败并给出解释(如token验证失败).

## 用户密码修改

### 后端

处理用户密码修改请求, 验证token, 验证成功后更新数据库用户密码.

- API: /api/user/password
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - old_password: string
        - new_password: string
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在个人信息页面修改密码, 输入旧密码和新密码, 点击保存按钮, 密码需加密, 向后端发送请求,
根据返回值提示修改成功或失败并给出解释(如旧密码错误).

## 用户注销

### 后端

处理用户注销请求, 验证token, 验证成功后删除数据库用户token.

- API: /api/user/logout
- Method: POST
- Authorization: Bearer token
- Request:
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在个人信息页面点击退出登录或关闭页面时, 向后端发送请求, 根据返回值提示注销成功或失败并给出解释(如token验证失败).

## 好友添加

### 后端

处理好友添加请求, 验证token, 验证成功后将好友关系存入数据库, 好友状态为待确认.

- API: /api/user/add_contact
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - contact_id: int
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在好友列表中点击添加好友按钮, 输入好友ID或用户名, 点击确认按钮, 向后端发送请求,
根据返回值提示添加成功或失败并给出解释(如好友ID不存在).

## 好友删除

### 后端

处理好友删除请求, 验证token, 验证成功后将好友表中数据删除.

- API: /api/user/delete_contact
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - contact_id: int
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在好友列表中右键点击好友, 在对应位置弹窗, 选择删除好友, 向后端发送请求, 根据返回值提示删除成功或失败并给出解释(如token验证失败).

## 接受好友请求

### 后端

处理接受好友请求, 验证token, 验证成功后将好友状态改为已接受.

- API: /api/user/accept_contact
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - contact_id: int
- Response:
    - Body:
        - code: int
        - message: string

### 前端

用户在好友请求列表中点击接受按钮, 向后端发送请求, 根据返回值提示接受成功或失败并给出解释(如token验证失败).

## 拒绝好友请求

### 后端

处理拒绝好友请求, 验证token, 验证成功后将好友状态改为已拉黑.

- API: /api/user/reject_contact
- Method: POST
- Authorization: Bearer token
- Request:
    - Body:
        - contact_id: int
- Response:
    - Body:
        - code: int
        - message: string

## 获取好友列表

### 后端

处理获取好友列表请求, 验证token, 验证成功后查询数据库获取好友列表.

- API: /api/user/contacts
- Method: POST
- Authorization: Bearer token
- Request:
- Response:
    - Body:
        - code: int
        - message: string
        - contacts: array