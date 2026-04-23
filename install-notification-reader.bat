@echo off
setlocal

REM === Configurable filenames ===
set CERTFILE=NotificationReader.cer
set APPFILE=NotificationReader_1.0.4.0_x64.msix

echo Checking for certificate in Trusted People store...

REM Query the Trusted People store for the certificate
certutil -store TrustedPeople | findstr /i "%CERTFILE%" >nul
if %errorlevel%==0 (
    echo Certificate already installed.
) else (
    echo Installing certificate...
    certutil -addstore -f "TrustedPeople" "%CERTFILE%"
    if %errorlevel%==0 (
        echo Certificate installed successfully.
    ) else (
        echo Failed to install certificate. Please run as Administrator.
        pause
        exit /b 1
    )
)

echo.
echo Installing MSIX package...
powershell -Command "Add-AppxPackage -Path '%APPFILE%'"

echo.
echo Installation complete.
pause
endlocal
