# 文件管理前后端交互设计

## 数据库设计

### 文件存储表

| Column      | Type         | Constraints                                                        | Description (说明)               |
|-------------|--------------|--------------------------------------------------------------------|----------------------------------|
| id          | SERIAL       | PRIMARY KEY                                                        | 文件ID (唯一标识)                |
| uploader_id | INT          | REFERENCES users(id) ON DELETE CASCADE                             | 上传者ID                        |
| file_name   | TEXT         |                                                                    | 文件名                          |
| file_url    | TEXT         | UNIQUE, NOT NULL                                                   | 文件存储地址 (唯一)              |
| file_type   | VARCHAR(20)  | CHECK (file_type IN (image, video, audio, document, other)) | 文件类型                        |
| file_size   | INT          |                                                                    | 文件大小 (单位字节)              |
| uploaded_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                                          | 文件上传时间                   |

### 文件权限表

| Column     | Type         | Constraints                                                           | Description (说明)                      |
|------------|--------------|-----------------------------------------------------------------------|-----------------------------------------|
| id         | SERIAL       | PRIMARY KEY                                                           | 记录ID (唯一标识)                       |
| file_id    | INT          | REFERENCES files(id) ON DELETE CASCADE                                | 关联的文件ID                           |
| user_id    | INT          | REFERENCES users(id) ON DELETE CASCADE                                | 拥有权限的用户ID                       |
| permission | VARCHAR(20)  | CHECK (permission IN (read, write, delete, share))            | 授权权限: 读、写、删除或分享等          |

## 文件上传

### 后端

后端需验证 token 后处理文件存储, 保存文件数据到指定存储位置, 并记录文件信息到数据库的 files 表中, 同时根据业务逻辑判断是否需要自动生成文件名或校验文件类型、大小等。

- API: /api/file/upload  
- Method: POST  
- Authorization: Bearer token  
- Request:
  - Content-Type: multipart/form-data  
  - Body：
    - file: binary
    - file_name: string(若客户端需要自定义文件名, 否则从上传文件获取)
    - file_type: string(文件类型, 如 image, video, audio, document, other)
    - file_size: int(原始未加密文件大小)
- Response:
  - Body:
    - code: int
    - message: string

### 前端

- 加密文件, 通过 POST 请求上传文件。
- 提供拖拽或文件选择上传的 UI 界面。
- 显示上传进度、成功或失败的提示。
- 上传成功后, 可在页面中展示文件缩略图(若为图片)或文件基本信息。

## 文件下载 / 预览

### 后端

根据请求用户的 token 检查是否具有对该文件的 read 权限, 或是否为文件的上传者, 然后返回文件流。

- API: /api/file/download  
- Method: GET
- Authorization: 可选(私有文件需验证 token 及权限)  
- Request:
  - Body:
    - file_id: int
- Response:
  - Body:
    - code: int
    - message: string
    - file: binary

### 前端

- 解密文件流, 展示文件内容或提供下载。
- 在文件列表页中为每个文件提供下载或预览入口。
- 点击下载后, 通过 GET 请求拉取文件流, 或在新窗口打开预览页面。

## 文件列表查询

### 后端

查询返回当前用户上传的文件, 也可扩展查询共享给该用户的文件(权限表中有相应记录)。

- API: /api/file/list  
- Method: GET
- Authorization: Bearer token  
- Request:
- Response:
  - Body:
    - code: int
    - message: string
    - files: array  

### 前端

- 显示文件列表页, 支持文件的分页展示和筛选。
- 对于每个文件, 展示基本信息和操作按钮(下载、预览、删除、共享)。

## 文件删除

### 后端

后端需验证用户 token, 并确认请求用户是否为上传者, 然后执行删除操作, 同时级联删除对应的权限记录。

- API: /api/file/delete  
- Method: DELETE
- Authorization: Bearer token  
- Request:
  - Body:
    - file_id: int
- Response:
  - Body:
    - code: int
    - message: string

### 前端

- 在文件列表中为每个文件提供删除操作入口(如删除按钮或右键菜单)。
- 删除成功后刷新列表, 并显示操作反馈。

## 文件共享(添加权限)

### 后端

- API: /api/file/share  
- Method: POST  
- Authorization: Bearer token  
- Request:
  - Body:
    - file_id: int
    - target_user_id: int
    - permission: string  
      (值限定为 read、write、delete 或 share, 通常文件共享场景下主要是 read 权限)
- Response:
  - Body:
    - code: int
    - message: string

说明: 请求方通常为文件所有者或拥有 share 权限者, 后端需验证权限后, 在 file_permissions 表中添加记录, 授权目标用户对该文件进行相应操作。

## 权限撤销

### 后端

用于撤销某个用户对文件的某项或所有权限, 同样需要权限验证

- API: /api/file/revoke  
- Method: POST
- Authorization: Bearer token  
- Request:
  - Body:
    - file_id: int
    - target_user_id: int
- Response:
  - Body:
    - code: int
    - message: string

### 前端

- 在文件详情或文件列表中提供共享管理功能。
- 展示已共享的用户列表和权限, 支持通过操作按钮撤销共享或修改权限。
