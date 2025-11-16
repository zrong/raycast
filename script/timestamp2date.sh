#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title timestamp2date
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⏰
# @raycast.argument1 { "type": "text", "placeholder": "时间戳" }
# @raycast.packageName bin

# Documentation:
# @raycast.description 使用 date 命令转换时间戳到人类阅读日期
# @raycast.author zrong

input_ts="$1"
# 检查输入是否为纯数字
if ! [[ "$input_ts" =~ ^[0-9]+$ ]]; then
    echo "'$input_ts' 不是时间戳。"
    exit 1
fi

# 通过时间戳的长度来判断其单位。
# - 10位: 通常是秒 (例如: 1678886400)
# - 13位: 通常是毫秒 (例如: 1678886400123)
# - 19位: 通常是纳秒 (例如: 1678886400123456789)

len=${#input_ts}
ts_seconds=0

if (( len > 14 )); then
    # 长度大于14，很可能是纳秒
    ts_seconds=$(( input_ts / 1000000000 ))
elif (( len > 10 )); then
    # 长度在11到14之间，很可能是毫秒
    ts_seconds=$(( input_ts / 1000 ))
else
    # 否则，默认为秒
    ts_seconds=$input_ts
fi

echo "本地时间: $(date -r "$ts_seconds" "+%Y-%m-%d %H:%M:%S %Z")"
