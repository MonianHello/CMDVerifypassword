::=================================
:: MonianHello 2020-7-21 23:25:50
::=================================
@echo off
::�رջ���
color 6f
::��ɫ������ɫ����
setlocal enabledelayedexpansion
::���������ӳ���չ
mkdir C:\MonianHelloVerifypassword 
::�����ļ���
del C:\MonianHelloVerifypassword\password.txt 
del C:\MonianHelloVerifypassword\passwordMD5.txt 
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
::ɾ�������µ��ļ�,��ֹ��������

:Verifypassword
cls
::����
echo ����ȷ�Ϲ���Ա���,��������Ա����
set /p password=Password:
::��������,�����ڱ��� password ��
echo %password%>>C:\MonianHelloVerifypassword\password.txt 
::������ password ������ļ� password.txt 
certutil -hashfile C:\MonianHelloVerifypassword\password.txt MD5 >>C:\MonianHelloVerifypassword\passwordMD5.txt
::���� password.txt ��MD5��������ļ� passwordMD5.txt
del C:\MonianHelloVerifypassword\password.txt 
::ɾ�� password.txt (�û����������)
for /f "tokens=1-2 eol=C skip=1 delims=," %%i in (C:\MonianHelloVerifypassword\passwordMD5.txt) do (
set MD5=%%i)
::���� passwordMD5.txt �� �������MD5 ���ؽ����� MD5
::
::(�������ɵ�MD5�й�������:
:: 				 MD5 ��ϣ(�ļ� C:\MonianHelloVerifypassword\password.txt):
::				 cf d8 db 45 b8 de d3 0c 88 7d 15 9d 34 5a c7 0e 
::				 CertUtil: -hashfile ����ɹ���ɡ�
::��һ��ͨ�� skip=1 ����,������ͨ�� eol=C ���� CertUtil: �ʼ�� C
::������ںܴ������,�����������ó���MD5�к���C������������
::[!]������)
del C:\MonianHelloVerifypassword\passwordMD5.txt 
::ɾ�� passwordMD5.txt (ϵͳ���ɵ�MD5) ����Ҫ����MD5�ļ������ڴ���(del)������� pause ֮��ǰ�� C:\MonianHelloVerifypassword �鿴MD5
echo %MD5% >> C:\MonianHelloVerifypassword\passwordMD5.txt
::������ MD5 д�� passwordMD5.txt 
certutil -encode -f C:\MonianHelloVerifypassword\passwordMD5.txt C:\MonianHelloVerifypassword\passwordMD5base64.txt
::���� passwordMD5.txt ��Base64��������ļ� passwordMD5base64.txt
::��������ԭ������Ϊ��cmd��ʹ���������ɵ�MD5ֵ�Ǵ��пո��,����ʱ����ִ���
::��������ʱ����del����� pause ,��¼C:\MonianHelloVerifypassword\passwordMD5base64.txt�ĵڶ�������
rem pause
del C:\MonianHelloVerifypassword\passwordMD5.txt 
::ɾ�� passwordMD5.txt 
for /f "tokens=1,* eol=- delims=," %%i in (C:\MonianHelloVerifypassword\passwordMD5base64.txt) do ( if %%i == Y2YgZDggZGIgNDUgYjggZGUgZDMgMGMgODggN2QgMTUgOWQgMzQgNWEgYzcgMGUg goto pass)
:: ���� passwordMD5base64 
:: 		��Ѱ�ҵ��涨���ַ�������pass��־
:: 		(����ַ����� passwordMD5base64.txt �ĵڶ��У������е����ݲ����д����ԣ�������)
::		��û���ҵ����ַ�����������
goto failed
:failed
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
cls
::����
color 4f
::��ɫ������ɫ����
echo ����Ա�������,ϵͳ��֤ʧ�ܡ�
pause
::��ͣ
exit
::�˳�����
:pass
del C:\MonianHelloVerifypassword\passwordMD5base64.txt
cls
::����
color 2f
::��ɫ������ɫ����
echo �ɹ���½,��ӭ��
pause
exit
