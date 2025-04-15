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

