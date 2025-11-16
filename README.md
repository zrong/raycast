# Raycast 脚本集合

这是一个用于 [Raycast](https://www.raycast.com/) 的自定义脚本集合，包含了一些日常工作中常用的实用工具。

## 📦 脚本列表

### 1. 文档服务器 (open-doc-server.py)

**功能**: 快速启动本地文档 HTTP 服务器并自动打开浏览器

- **图标**: 📚
- **模式**: Compact
- **描述**: 在 `~/study/doc` 目录启动一个 HTTP 服务器（端口 8080），并自动在浏览器中打开
- **技术栈**: Python 3

**使用方法**: 在 Raycast 中输入 "Open Doc Server" 即可启动

### 2. 窗口调整工具 (resize-window.applescript)

**功能**: 调整最前方窗口的大小和位置

- **图标**: 🖥️
- **模式**: Full Output
- **参数**:
  - `width`: 窗口宽度（默认: 1920）
  - `height`: 窗口高度（默认: 1080）
  - `position`: 窗口位置（默认: CENTER）
    - CENTER: 居中
    - TL: 左上角
    - TR: 右上角
    - BL: 左下角
    - BR: 右下角
- **技术栈**: AppleScript

**使用方法**: 在 Raycast 中输入 "Resize Front Window"，可选择性输入宽度、高度和位置参数

**注意**: 需要授予 Raycast 辅助功能权限

### 3. 时间戳转换 (timestamp2date.sh)

**功能**: 将时间戳转换为人类可读的日期时间格式

- **图标**: ⏰
- **模式**: Compact
- **参数**: 
  - `时间戳`: 支持秒（10位）、毫秒（13位）、纳秒（19位）格式
- **技术栈**: Bash

**使用方法**: 在 Raycast 中输入 "timestamp2date"，然后输入时间戳数值

**示例**:
- 输入: `1678886400`
- 输出: `本地时间: 2023-03-15 16:00:00 CST`

### 4. VNC 连接 (vnc-100.sh)

**功能**: 快速连接到指定的 VNC 服务器

- **图标**: 🖥️
- **模式**: Compact
- **目标**: vnc://192.168.16.100
- **技术栈**: Bash

**使用方法**: 在 Raycast 中输入 "VNC 100" 即可连接

## 🚀 安装说明

1. 确保已安装 [Raycast](https://www.raycast.com/)
2. 克隆或下载本仓库到本地
3. 在 Raycast 中打开 **Settings → Extensions → Script Commands**
4. 点击 **Add Directories** 并选择 `script` 目录
5. 脚本将自动加载到 Raycast 中

## 📋 依赖要求

- **macOS**: 所有脚本都是为 macOS 设计的
- **Python 3**: 用于运行 `open-doc-server.py`
- **Bash**: 系统自带
- **AppleScript**: 系统自带

## 🛠️ 自定义配置

### 修改文档服务器路径

编辑 `script/open-doc-server.py`，修改第 20 行：

```python
document_path = os.path.expanduser('~/study/doc')  # 修改为你的文档路径
```

### 修改 VNC 地址

编辑 `script/vnc-100.sh`，修改第 15 行：

```bash
open vnc://192.168.16.100  # 修改为你的 VNC 服务器地址
```

## 📄 许可证

MIT License

## 👤 作者

- **zrong**
- 网站: [https://zengrong.net](https://zengrong.net)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！
