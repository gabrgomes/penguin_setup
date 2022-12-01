@echo off

:: Script to automatically disable and re-enable the WSL network adapter when connecting and disconnecting from CheckPoint VPN. 
::
:: IMPORTANT: Must be run as administrator
::
:: @author Thiago Arruda <thiarruda@gmail.com>

:: Path to CheckPoint's CLI client.
:: Example: set checkpoint_cli="C:\Program Files (x86)\CheckPoint\Endpoint Connect\trac.exe"
set checkpoint_cli="C:\Program Files (x86)\CheckPoint\Endpoint Connect\trac.exe"

if not exist %checkpoint_cli% (
  echo ERROR: trac.exe was not found at this location: %checkpoint_cli%
  echo.
  pause
  call :do_exit
)

:: Change these according to your connection needs
:: The script is set to use a certificate, and will prompt you the for password
:: If you are using an username instead, change "-f %cert_path%" to "-u %username%"
set vpn_host="FlexyBB"
set cert_path="C:\Users\F3544855\Downloads\cert_f3544855.p12"
:: set username="<your_username>"
set checkpoint_options=-s %vpn_host% -f %cert_path%

:: Comment this block if you are using username instead of certificate
if not exist %cert_path% (
  echo ERROR: no certificate found at this location: %cert_path%
  echo.
  pause
  call :do_exit
)

:mainloop
call :show_menu

if "%option%" == "1" ( call :do_connect ) else ^
if "%option%" == "2" ( call :do_disconnect ) else ^
if "%option%" == "3" ( call :do_exit ) else ^
call :do_invalid

pause
call :mainloop

:do_connect
if "%status%" == "Connected" (
  echo.
  echo ERROR: You are already connected
  echo.
  exit /B 1
)
call :disable_network
call :connect
call :enable_network
exit /B 0

:do_disconnect
if "%status%" == "Disconnected" (
    echo.
    echo ERROR: You are not connected
    echo.
    exit /B 1
  )
call :disable_network
call :disconnect
call :enable_network
exit /B 0

:do_invalid
echo.
echo ERROR: invalid option: %option%
echo.
exit /B 0

:do_exit
exit 0

:connect 
echo Connecting to the VPN...
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p

IF "%password%"=="" (
  echo.
  echo ERROR: no password provided
  echo.
  exit /B 1
)

%checkpoint_cli% connect %checkpoint_options% -p %password%

call :check_status
if not "%status%" == "Connected" (
  echo.
  echo ERROR: failed to connect to "%vpn_host%". Check the output above.
  echo.
  exit /B 1
)

exit /B 0

:disconnect
echo Disconnecting from VPN...
%checkpoint_cli% disconnect

call :check_status
if not "%status%" == "Disconnected" (
  echo.
  echo ERROR: failed to disconnect. Check the output above.
  echo.
  exit /B 1
)

exit /B 0

:show_menu
set option=""
call :check_status
cls
echo.
echo    :::     ::: :::::::::  ::::    ::: 
echo   :+:     :+: :+:    :+: :+:+:   :+:  
echo  +:+     +:+ +:+    +:+ :+:+:+  +:+   
echo +#+     +:+ +#++:++#+  +#+ +:+ +#+    
echo +#+   +#+  +#+        +#+  +#+#+#     
echo #+#+#+#   #+#        #+#   #+#+#      
echo  ###     ###        ###    ####       
echo.
echo STATUS: %status%
echo.
echo [1] Connect
echo [2] Disconnect
echo [3] Exit
echo.
set /p option="Choose an option: "

exit /B 0

:disable_network
echo.
echo Disabling WSL network...
netsh interface set interface "vEthernet (WSL)" disable
if ERRORLEVEL 1 ( 
  echo.
  echo ERROR: failed to disable the network interface "vEthernet (WSL)" .
  echo.
  exit /B 1
)
exit /B 0

:enable_network
echo.
echo Enabling WSL network...
netsh interface set interface "vEthernet (WSL)" enable
if ERRORLEVEL 1 ( 
  echo.
  echo ERROR: failed to enable the network interface "vEthernet (WSL)".
  echo.
  exit /B 1
)
exit /B 0

:check_status
%checkpoint_cli% info | find /i "status: Connected" >nul 2>&1
if not errorlevel 1 (
   set status=Connected
) else (
   set status=Disconnected
)
exit /B 0