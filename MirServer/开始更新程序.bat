@echo off

title GeeM2�������
::����CMD����������ɫΪ0a ��CMD���������� color /? �ɲ鿴��ɫ�б�
color 0B
::����CMD������ʾģʽΪ100�п� 20�и�
MODE con: COLS=120 LINES=30
:main
echo �ڳ����ļ�����ǰ��ȷ����������ֹͣ����
set WSDir=D:\MirServer20240604

echo.
echo  ==========================================
echo.
echo    A: ʹ��32λ��ʽ��M2
echo    B: ʹ��64λ��ʽ��M2��10���Ĭ�ϣ�
echo    C: ʹ��64λȫ����10�û���M2
echo.
echo  ==========================================
echo.

:: /c�����б� /m��ʾ���� /dĬ��ѡ�� /t�ȴ�����   /d ����� /tͬʱ����
choice  /c abc /m "��ѡ��" /d b /t 100

::�û�ѡ��Ľ���ᰴ��Ŀ������֣���1��ʼ��������errorlevel������
if %errorlevel%==1 goto 32M2
if %errorlevel%==2 goto 64M2
if %errorlevel%==3 goto TEST

:32M2
echo ��ǰѡ��[32λ]��ʼ�����ļ���
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\M2Server-x86.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\libmysql-32.dll %WSDir%\Mir200\ /y

goto OtherFile
pause

:64M2
echo ��ǰѡ��[64λ]��ʼ�����ļ���
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\64λ\M2Server-x64.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\64λ\libmysql-64.dll %WSDir%\Mir200\ /y

goto OtherFile
pause

:TEST
echo ��ǰѡ��[�����]��ʼ�����ļ���
if not exist %WSDir%\Mir200 (mkdir %WSDir%\Mir200)

Copy Mir200\�����\M2Server-x64.exe %WSDir%\Mir200\M2Server.exe /y
Copy Mir200\64λ\libmysql-64.dll %WSDir%\Mir200\ /y
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
Copy Mir200\ip������.exe %WSDir%\Mir200\ /y
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

if not exist %WSDir%\��¼�� (mkdir %WSDir%\��¼��\)
Copy ��¼��\MakeGameLogin.exe %WSDir%\��¼��\ /y
Copy ��¼��\�����޸�����.exe %WSDir%\��¼��\ /y
Copy ��¼��\NewopUI.Pak %WSDir%\��¼��\ /y
Copy ��¼��\NewopUI�ļ�˵��.txt %WSDir%\��¼��\ /y
Copy ��¼��\D3DX81ab.dll %WSDir%\��¼��\ /y
Copy ��¼��\GuiEdit.dll %WSDir%\��¼��\ /y

if not exist %WSDir%\���� (mkdir %WSDir%\����)
Copy ����\���ݹ�����\���ݹ�����_x64.exe %WSDir%\����\ /y
Copy ����\���ݹ�����\���ݹ�����_x86.exe %WSDir%\����\ /y
Copy ����\Wzl�༭��.exe %WSDir%\���� /y
Copy ����\��������\��������_x64.exe %WSDir%\����\ /y
Copy ����\��������\��������_x86.exe %WSDir%\����\ /y

Copy GeeM2��������ĵ�.chm %WSDir%\/y
echo �����ļ��Ѹ������. . .
pause
exit