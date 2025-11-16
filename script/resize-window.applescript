#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Resize Front Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.argument1 { "type": "text", "placeholder": "width (1920)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "height (1080)", "optional": true }
# @raycast.argument3 { "type": "dropdown", "placeholder": "position (CENTER)", "optional": true, "data":[ {"title": "Center", "value": "C"}, {"title": "Top Left", "value": "TL"}, {"title": "Top Right", "value": "TR"}, {"title": "Bottom Left", "value": "BL"}, {"title": "Bottom Right", "value": "BR"} ] }
# @raycast.packageName Window

# Documentation:
# @raycast.description 调整最前方窗口的大小和位置
# @raycast.author zrong
# @raycast.authorURL https://zengrong.net

use framework "AppKit"
use scripting additions

on run argv
	
	-- 解析可选参数 (带默认值)
	set reqW to 1920
	set reqH to 1080
	set reqPos to "CENTER"
	
	if (count of argv) ≥ 1 then
		try
			if item 1 of argv is not "" then
				set reqW to item 1 of argv as integer
			end if
		on error
			set reqW to 1920
		end try
	end if
	
	if (count of argv) ≥ 2 then
		try
			if item 2 of argv is not "" then
				set reqH to item 2 of argv as integer
			end if
		on error
			set reqH to 1080
		end try
	end if
	
	if (count of argv) ≥ 3 then
		try
			if item 3 of argv is not "" then
				set reqPos to item 3 of argv as string
			end if
		on error
			set reqPos to "C"
		end try
	end if
	
	-- 获取屏幕尺寸
	try
		set screenFrame to current application's NSScreen's mainScreen()'s frame()
		set usableFrame to current application's NSScreen's mainScreen()'s visibleFrame()
		
		set usableX to item 1 of (item 1 of usableFrame)
		set usableY to item 2 of (item 1 of usableFrame)
		set usableW to item 1 of (item 2 of usableFrame)
		set usableH to item 2 of (item 2 of usableFrame)
	on error errMsg
		display dialog "无法获取屏幕尺寸。" & return & "错误: " & errMsg with title "脚本错误" with icon stop
		return
	end try
	
	-- 验证尺寸
	if reqW > usableW or reqH > usableH then
		display dialog "尺寸错误：请求的窗口大小 (" & reqW & "x" & reqH & ") 超出了可用的屏幕空间 (" & (round usableW) & "x" & (round usableH) & ")。" with title "窗口大小错误" with icon stop buttons {"好的"}
		return
	end if
	
	-- 计算坐标
	set x1 to 0
	set y1 to 0
	
	if reqPos is "BL" then -- Bottom Left
		set x1 to usableX
		set y1 to usableY + usableH - reqH
		
	else if reqPos is "BR" then -- Bottom Right
		set x1 to usableX + usableW - reqW
		set y1 to usableY + usableH - reqH
		
	else if reqPos is "TL" then -- Top Left
		set x1 to usableX
		set y1 to usableY
		
	else if reqPos is "TR" then -- Top Right
		set x1 to usableX + usableW - reqW
		set y1 to usableY
		
	else if reqPos is "C" then -- Center
		set x1 to usableX + ((usableW - reqW) / 2)
		set y1 to usableY + ((usableH - reqH) / 2)
		
	else
		display dialog "无效的位置参数 '" & reqPos & "'。" with title "位置错误" with icon stop
		return
	end if
	
	-- 设置前台应用的窗口
    try
        tell application "System Events"
            set frontApp to first application process whose frontmost is true
            set frontAppName to name of frontApp
            
            -- 获取所有窗口
            set appWindows to windows of frontApp
            if (count of appWindows) = 0 then
                error "前台应用 '" & frontAppName & "' 没有窗口。"
            end if
            
            -- 遍历窗口，找到可操作的窗口
            set targetWindow to missing value
            repeat with i from 1 to (count of appWindows)
                try
                    set testWindow to window i of frontApp
                    -- 尝试读取窗口名称以确认可访问
                    set winName to name of testWindow
                    set targetWindow to testWindow
                    exit repeat
                on error
                    -- 尝试下一个窗口
                end try
            end repeat
            
            if targetWindow is missing value then
                error "无法访问任何窗口。"
            end if
            
            -- 设置窗口位置和大小
            set position of targetWindow to {x1, y1}
            set size of targetWindow to {reqW, reqH}
        end tell
        
        display notification "窗口尺寸设置完成: " & reqW & "x" & reqH & " 位置: " & reqPos with title "操作成功"
        
    on error secondErrMsg
        display dialog "无法设置窗口大小。" & return & "请确保当前应用有可见窗口，并已授予辅助功能权限。" & return & return & "错误: " & secondErrMsg with title "应用错误" with icon stop
    end try
	
end run

