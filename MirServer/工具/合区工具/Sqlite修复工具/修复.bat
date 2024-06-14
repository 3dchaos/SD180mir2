@echo off
cls
echo.
echo.
echo.
echo 在修复运行前，请将数据库文件放入到“DB”文件夹中！
echo.
echo.
echo.
pause

:menu
cls
echo.
echo 请选择要修复的数据库？
echo.
echo ==============================
echo.
echo 输入1：修复RoleData.db
echo.
echo 输入2：修复M2Data.db
echo.
echo 输入3：修复Account.db
echo.
echo 输入4：退出
echo.
echo ==============================
echo.
echo.
set /p user_input=请输入数字：
if %user_input% equ 1 goto RoleData_Menu
if %user_input% equ 2 goto M2Data_Menu
if %user_input% equ 3 goto Account_Menu
if %user_input% equ 4 (exit) else (goto menu)
pause

rem =======================================================================================

:RoleData_Repair
cls
echo.
echo 正在修复数据库“DB\RoleData.db”，请等待......
echo.
if exist RoleData_OK.db (del RoleData_OK.db) 
sqlite3 DB\RoleData.db .dump > DB\RoleData.sql
sqlite3 RoleData_OK.db < DB\RoleData.sql
del DB\RoleData.sql
cls
echo.
echo.
echo “DB\RoleData.db”数据库修复完成，保存到“RoleData_OK.db”
echo.
echo.
pause
goto menu

:RoleData_NoExits
cls
echo.
echo.
echo “DB\RoleData.db” 文件未找到
echo. 
echo 修复“DB\RoleData.db”失败
echo. 
pause
goto menu

:RoleData_Menu
if exist DB\RoleData.db (goto RoleData_Repair)  else (goto RoleData_NoExits)

rem =======================================================================================

:M2Data_Repair
cls
echo.
echo 正在修复数据库“DB\M2Data.db”，请等待......
echo.
if exist M2Data_OK.db (del M2Data_OK.db) 
sqlite3 DB\M2Data.db .dump > DB\M2Data.sql
sqlite3 M2Data_OK.db < DB\M2Data.sql
del DB\M2Data.sql
cls
echo.
echo.
echo “DB\M2Data.db”数据库修复完成，保存到“M2Data_OK.db”
echo.
echo.
pause
goto menu

:M2Data_NoExits
cls
echo.
echo.
echo “DB\M2Data.db”文件未找到
echo. 
echo 修复“DB\M2Data.db”失败
echo. 
pause
goto menu

:M2Data_Menu
if exist DB\M2Data.db (goto M2Data_Repair)  else (goto M2Data_NoExits)

rem =======================================================================================

:Account_Repair
cls
echo.
echo 正在修复数据库“DB\Account.db”，请等待......
echo.
if exist Account_OK.db (del Account_OK.db) 
sqlite3 DB\Account.db .dump > DB\Account.sql
sqlite3 Account_OK.db < DB\Account.sql
del DB\Account.sql
cls
echo.
echo.
echo “DB\Account.db”数据库修复完成，保存到“Account_OK.db”
echo.
echo.
pause
goto menu

:Account_NoExits
cls
echo.
echo.
echo “DB\Account.db”文件未找到
echo. 
echo 修复“DB\Account.db”失败
echo. 
pause
goto menu

:Account_Menu
if exist DB\Account.db (goto Account_Repair)  else (goto Account_NoExits)