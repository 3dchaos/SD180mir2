@echo off

title GeeM2引擎更新
::设置CMD窗口字体颜色为0a 在CMD中输入命令 color /? 可查看颜色列表
color 0B
::设置CMD窗口显示模式为100列宽 20行高
MODE con: COLS=120 LINES=30
:main
echo 在程序文件更新前，确保服务器已停止服务！
set WSDir=D:\MirServer20240604

echo.
echo  ==========================================
echo.
echo    A: 使用32位正式版M2
echo    B: 使用64位正式版M2（10秒后默认）
echo    C: 使用64位全功能10用户版M2
echo.
echo  ==========================================
echo.

:: /c按键列表 /m提示内容 /d默认选择 /t等待秒数   /d 必须和 /t同时出现
choice  /c abc /m "请选择" /d b /t 100

::用户选择的结果会按项目序号数字（从1开始）返回在errorlevel变量中
if %errorlevel%==1 goto 32M2
if %errorlevel%==2 goto 64M2
if %errorlevel%==3 goto TEST

:32M2
echo 当前选择[32位]开始复制文件！
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\M2Server-x86.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\libmysql-32.dll %WSDir%\Mir200\ /y

goto OtherFile
pause

:64M2
echo 当前选择[64位]开始复制文件！
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\64位\M2Server-x64.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\64位\libmysql-64.dll %WSDir%\Mir200\ /y

goto OtherFile
pause

:TEST
echo 当前选择[体验版]开始复制文件！
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\体验版\M2Server-x64.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\64位\libmysql-64.dll %WSDir%\Mir200\ /y
goto OtherFile
pause


:OtherFile
if not exist %WSDir%\DBServer (mkdir %WSDir%\DBServer)
if not exist %WSDir%\LogServer (mkdir %WSDir%\LogServer)
if not exist %WSDir%\LoginGate (mkdir %WSDir%\LoginGate)
if not exist %WSDir%\LoginSrv (mkdir %WSDir%\LoginSrv)
if not exist %WSDir%\RunGate (mkdir %WSDir%\RunGate)
if not exist %WSDir%\SelGate (mkdir %WSDir%\SelGate)

Copy Mir200\Mir.Dat %WSDir%\Mir200\ /y
Copy Mir200\QQWry.Dat %WSDir%\Mir200\ /y
Copy Mir200\ip库升级.exe %WSDir%\Mir200\ /y
Copy DBServer\DBServer.exe %WSDir%\DBServer\ /y
Copy DBServer\libmysql-32.dll %WSDir%\DBServer\ /y
Copy LogServer\LogDataServer.exe %WSDir%\LogServer\ /y
Copy LoginGate\LoginGate.exe %WSDir%\LoginGate\ /y
Copy LoginSrv\LoginSrv.exe %WSDir%\LoginSrv\ /y
Copy LoginSrv\libmysql-32.dll %WSDir%\LoginSrv\ /y
Copy RunGate\RunGate.exe %WSDir%\RunGate\ /y
Copy SelGate\SelGate.exe %WSDir%\SelGate\ /y
Copy GameCenter.exe %WSDir%\GameCenter.exe /y
Copy libmysql-32.dll %WSDir%\libmysql-32.dll /y

if not exist %WSDir%\登录器 (mkdir %WSDir%\登录器\)
Copy 登录器\MakeGameLogin.exe %WSDir%\登录器\ /y
Copy 登录器\白屏修复工具.exe %WSDir%\登录器\ /y
Copy 登录器\NewopUI.Pak %WSDir%\登录器\ /y
Copy 登录器\NewopUI文件说明.txt %WSDir%\登录器\ /y
Copy 登录器\D3DX81ab.dll %WSDir%\登录器\ /y
Copy 登录器\GuiEdit.dll %WSDir%\登录器\ /y

if not exist %WSDir%\工具 (mkdir %WSDir%\工具)
Copy 工具\数据管理工具\数据管理工具_x64.exe %WSDir%\工具\ /y
Copy 工具\数据管理工具\数据管理工具_x86.exe %WSDir%\工具\ /y
Copy 工具\Wzl编辑器.exe %WSDir%\工具 /y
Copy 工具\合区工具\合区工具_x64.exe %WSDir%\工具\ /y
Copy 工具\合区工具\合区工具_x86.exe %WSDir%\工具\ /y

Copy GeeM2引擎帮助文档.chm %WSDir%\/y
echo 程序文件已更新完成. . .
pause
exit