# 即时通信前后端交互设计

## 消息表

|Coloum|Type|Constraints|Description|
|---|---|---|---|
|id|SERIAL|PRIMARY KEY|消息ID|
|sender_id|INT|REFERENCES users(id) ON DELETE CASCADE|发送者ID|
|receiver_id|INT|REFERENCES users(id) ON DELETE CASCADE|接收者ID|
|content|TEXT|NOT NULL|消息内容|
|created_at|TIMESTAMP|DEFAULT CURRENT_TIMESTAMP|消息发送时间|
|status|VARCHAR(20)|DEFAULT 'sent'|消息状态（sent, delivered, read）|
|message_type|VARCHAR(20)|DEFAULT 'text'|消息类型（text, image, file,audio,video,system）|
|file_url|VARCHAR(255)|NULL|文件URL（如果消息类型为文件）|
|chat_type|VARCHAR(20)|DEFAULT 'single'|聊天类型（private, room）|

## 聊天室表

|Coloum|Type|Constraints|Description|
|---|---|---|---|
|id|SERIAL|PRIMARY KEY|聊天室ID|
|name|VARCHAR(100)|NOT NULL|聊天室名称|
|description|TEXT|NULL|聊天室描述|
|created_at|TIMESTAMP|DEFAULT CURRENT_TIMESTAMP|聊天室创建时间|

## 消息协议

### 发送消息

```json
{
    "type":"chat",
    "chat_type":"private", // or room
    "reveiver_id":1, // user_id if private chat; room_id if room chat
    "message_type": "text",
    "content": "Hello, how are you?",
    "file_url": null,
}
```

### 接收消息

```json
{
    "message_id": 1,
    "type":"chat",
    "chat_type":"private", // or room
    "sender_id":1,
    "message_type": "text",
    "content": "Hello, how are you?",
    "file_url": null,
    "created_at": "2023-10-01T12:00:00Z",
}
```

## 获取私聊历史消息

### 后端

处理获取私聊历史消息请求, 返回指定用户的聊天记录, 支持分页查询.

- API: /api/chat/history/private
- Method: POST
- Authorization: Bearer token
- Request:
  - Body:
    - user_id: int
    - page: int
    - page_size: int
- Response:
  - Body:
    - code: int
    - message: string
    - data: array
      - id: int
      - sender_id: int
      - receiver_id: int
      - content: string
      - created_at: timestamp
      - status: string
      - message_type: string
      - file_url: string
      - chat_type: string

### 前端

获取用户的聊天记录, 显示在聊天窗口中, 支持分页加载更多消息.

## 获取聊天室历史消息

### 后端

处理获取聊天室历史消息请求, 返回指定聊天室的聊天记录, 支持分页查询.

- API: /api/chat/history/room
- Method: POST
- Authorization: Bearer token
- Request:
  - Body:
    - room_id: int
    - page: int
    - page_size: int
- Response:
  - Body:
    - code: int
    - message: string
    - data: array
      - id: int
      - sender_id: int
      - receiver_id: int
      - content: string
      - created_at: timestamp
      - status: string
      - message_type: string
      - file_url: string
      - chat_type: string

### 前端

获取聊天室的聊天记录, 显示在聊天室窗口中, 支持分页加载更多消息.

## 获取消息状态

### 后端

处理获取消息状态请求, 返回指定消息的状态.

- API: /api/chat/message/status
- Method: POST
- Authorization: Bearer token
- Request:
  - Body:
    - message_id: int
- Response:
  - Body:
    - code: int
    - message: string
    - status: string

### 前端

获取指定消息的状态, 显示在聊天窗口中.

## 发送/接受消息

### 后端

处理发送/接受消息请求, 验证token, 验证成功后将消息存储到数据库中.

- API: /ws/chat
- Method: WebSocket
- Authorization: Bearer token
