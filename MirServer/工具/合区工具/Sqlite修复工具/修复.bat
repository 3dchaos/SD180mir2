@echo off
cls
echo.
echo.
echo.
echo ���޸�����ǰ���뽫���ݿ��ļ����뵽��DB���ļ����У�
echo.
echo.
echo.
pause

:menu
cls
echo.
echo ��ѡ��Ҫ�޸������ݿ⣿
echo.
echo ==============================
echo.
echo ����1���޸�RoleData.db
echo.
echo ����2���޸�M2Data.db
echo.
echo ����3���޸�Account.db
echo.
echo ����4���˳�
echo.
echo ==============================
echo.
echo.
set /p user_input=���������֣�
if %user_input% equ 1 goto RoleData_Menu
if %user_input% equ 2 goto M2Data_Menu
if %user_input% equ 3 goto Account_Menu
if %user_input% equ 4 (exit) else (goto menu)
pause

rem =======================================================================================

:RoleData_Repair
cls
echo.
echo �����޸����ݿ⡰DB\RoleData.db������ȴ�......
echo.
if exist RoleData_OK.db (del RoleData_OK.db) 
sqlite3 DB\RoleData.db .dump > DB\RoleData.sql
sqlite3 RoleData_OK.db < DB\RoleData.sql
del DB\RoleData.sql
cls
echo.
echo.
echo ��DB\RoleData.db�����ݿ��޸���ɣ����浽��RoleData_OK.db��
echo.
echo.
pause
goto menu

:RoleData_NoExits
cls
echo.
echo.
echo ��DB\RoleData.db�� �ļ�δ�ҵ�
echo. 
echo �޸���DB\RoleData.db��ʧ��
echo. 
pause
goto menu

:RoleData_Menu
if exist DB\RoleData.db (goto RoleData_Repair)  else (goto RoleData_NoExits)

rem =======================================================================================

:M2Data_Repair
cls
echo.
echo �����޸����ݿ⡰DB\M2Data.db������ȴ�......
echo.
if exist M2Data_OK.db (del M2Data_OK.db) 
sqlite3 DB\M2Data.db .dump > DB\M2Data.sql
sqlite3 M2Data_OK.db < DB\M2Data.sql
del DB\M2Data.sql
cls
echo.
echo.
echo ��DB\M2Data.db�����ݿ��޸���ɣ����浽��M2Data_OK.db��
echo.
echo.
pause
goto menu

:M2Data_NoExits
cls
echo.
echo.
echo ��DB\M2Data.db���ļ�δ�ҵ�
echo. 
echo �޸���DB\M2Data.db��ʧ��
echo. 
pause
goto menu

:M2Data_Menu
if exist DB\M2Data.db (goto M2Data_Repair)  else (goto M2Data_NoExits)

rem =======================================================================================

:Account_Repair
cls
echo.
echo �����޸����ݿ⡰DB\Account.db������ȴ�......
echo.
if exist Account_OK.db (del Account_OK.db) 
sqlite3 DB\Account.db .dump > DB\Account.sql
sqlite3 Account_OK.db < DB\Account.sql
del DB\Account.sql
cls
echo.
echo.
echo ��DB\Account.db�����ݿ��޸���ɣ����浽��Account_OK.db��
echo.
echo.
pause
goto menu

:Account_NoExits
cls
echo.
echo.
echo ��DB\Account.db���ļ�δ�ҵ�
echo. 
echo �޸���DB\Account.db��ʧ��
echo. 
pause
goto menu

:Account_Menu
if exist DB\Account.db (goto Account_Repair)  else (goto Account_NoExits)