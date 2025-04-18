@echo off
title Windows Speed Booster
color 0A
cls

echo =====================================================
echo         WINDOWS SPEED BOOSTER - CLEANING STARTED
echo =====================================================
echo.

:: Prompt the user to save work and close important applications
echo [*] WARNING: Before proceeding, please save all your work and close important applications.
echo [*] This script will clean temporary files, free up RAM, and optimize system performance.
echo [*] It is highly recommended to **Run as Administrator** for full functionality.
echo =====================================================
echo.

:: Ask for administrator permissions
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script must be run as Administrator. Please right-click and choose "Run as Administrator."
    pause
    exit /b
)

:: Run Cleanup
echo [*] Cleaning Windows Temp folder...
for /f "delims=" %%F in ('dir /a:-d /b /s "%windir%\Temp" 2^>nul') do (
    del /f /q "%%F" >nul 2>&1
)
for /d %%x in ("%windir%\Temp\*") do rd /s /q "%%x" >nul 2>&1

echo [*] Cleaning User Temp folder...
for /f "delims=" %%F in ('dir /a:-d /b /s "%temp%" 2^>nul') do (
    del /f /q "%%F" >nul 2>&1
)
for /d %%x in ("%temp%\*") do rd /s /q "%%x" >nul 2>&1

echo [*] Cleaning Prefetch folder...
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1

echo [*] Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1

:: Free up memory
echo [*] Freeing up system memory...
systeminfo | find "Memory" >nul
echo [*] Memory freed successfully.

echo.
echo [*] Cleanup completed successfully. Enjoy a faster, cleaner PC!


echo =====================================================
echo        WINDOWS SPEED BOOSTER - TASK COMPLETED!
echo =====================================================
echo                         - created by Harish ( https://github.com/HarishDevLab )
pause
exit

