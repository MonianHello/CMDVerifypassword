::=================================
:: MonianHello 2020-7-21 23:25:50
::=================================
@echo off
::关闭回显
color 6f
::绿色背景白色字体
setlocal enabledelayedexpansion
::环境变量延迟扩展
mkdir C:\MonianHelloVerifypassword 
::创建文件夹
del C:\MonianHelloVerifypassword\password.txt 
del C:\MonianHelloVerifypassword\passwordMD5.txt 
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
::删除遗留下的文件,防止爆破密码

:Verifypassword
cls
::清屏
echo 正在确认管理员身份,请键入管理员密码
set /p password=Password:
::输入密码,储存在变量 password 中
echo %password%>>C:\MonianHelloVerifypassword\password.txt 
::将变量 password 输出到文件 password.txt 
certutil -hashfile C:\MonianHelloVerifypassword\password.txt MD5 >>C:\MonianHelloVerifypassword\passwordMD5.txt
::计算 password.txt 的MD5并输出到文件 passwordMD5.txt
del C:\MonianHelloVerifypassword\password.txt 
::删除 password.txt (用户输入的密码)
for /f "tokens=1-2 eol=C skip=1 delims=," %%i in (C:\MonianHelloVerifypassword\passwordMD5.txt) do (
set MD5=%%i)
::遍历 passwordMD5.txt 将 计算出的MD5 加载进变量 MD5
::
::(由于生成的MD5中共有三行:
:: 				 MD5 哈希(文件 C:\MonianHelloVerifypassword\password.txt):
::				 cf d8 db 45 b8 de d3 0c 88 7d 15 9d 34 5a c7 0e 
::				 CertUtil: -hashfile 命令成功完成。
::第一行通过 skip=1 跳过,第三行通过 eol=C 跳过 CertUtil: 最开始的 C
::这里存在很大的问题,如果计算密码得出的MD5中含有C程序会产生错误
::[!]急需解决)
del C:\MonianHelloVerifypassword\passwordMD5.txt 
::删除 passwordMD5.txt (系统生成的MD5) 若需要保存MD5文件可以在此行(del)上面加上 pause 之后前往 C:\MonianHelloVerifypassword 查看MD5
echo %MD5% >> C:\MonianHelloVerifypassword\passwordMD5.txt
::将变量 MD5 写入 passwordMD5.txt 
certutil -encode -f C:\MonianHelloVerifypassword\passwordMD5.txt C:\MonianHelloVerifypassword\passwordMD5base64.txt
::计算 passwordMD5.txt 的Base64并输出到文件 passwordMD5base64.txt
::这样做的原因是因为在cmd中使用命令生成的MD5值是带有空格的,处理时会出现错误
::设置密码时请在del后加上 pause ,记录C:\MonianHelloVerifypassword\passwordMD5base64.txt的第二行数据
rem pause
del C:\MonianHelloVerifypassword\passwordMD5.txt 
::删除 passwordMD5.txt 
for /f "tokens=1,* eol=- delims=," %%i in (C:\MonianHelloVerifypassword\passwordMD5base64.txt) do ( if %%i == Y2YgZDggZGIgNDUgYjggZGUgZDMgMGMgODggN2QgMTUgOWQgMzQgNWEgYzcgMGUg goto pass)
:: 遍历 passwordMD5base64 
:: 		若寻找到规定的字符串进入pass标志
:: 		(这个字符串是 passwordMD5base64.txt 的第二行，第三行的数据不具有代表性，故舍弃)
::		若没有找到此字符串继续运行
goto failed
:failed
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
cls
::清屏
color 4f
::红色背景白色字体
echo 管理员密码错误,系统认证失败。
pause
::暂停
exit
::退出程序
:pass
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
cls
::清屏
color 2f
::绿色背景白色字体
echo 成功登陆,欢迎！
pause
exit
