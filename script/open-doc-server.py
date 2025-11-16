#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Doc Server
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📚

# Documentation:
# @raycast.description 打开文档服务器
# @raycast.author zrong

import os
import webbrowser
from http.server import HTTPServer, SimpleHTTPRequestHandler
from functools import partial

document_path = os.path.expanduser('~/study/doc')

print(f"启动文档服务器，目录: {document_path}")
print("服务器地址: http://localhost:8080")

def main():
    # 切换到文档目录
    os.chdir(document_path)
    
    # 创建HTTP服务器处理器，指定目录
    handler = partial(SimpleHTTPRequestHandler, directory=document_path)
    
    # 启动服务器
    httpd = HTTPServer(('localhost', 8080), handler)
    
    # 自动打开浏览器
    webbrowser.open('http://localhost:8080')
    
    print("服务器已启动，按 Ctrl+C 停止服务器")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n服务器已停止")
        httpd.shutdown()

if __name__ == '__main__':
    main()
