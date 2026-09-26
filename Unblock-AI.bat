@echo off
title AI Website Unblocker

echo ==========================================
echo AI WEBSITE UNBLOCKER - LAB PC
echo ==========================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
echo ERROR: Please run this file as Administrator.
echo.
pause
exit /b 1
)

echo Removing AI website blocking...
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0unblock-AI.ps1"

if %errorlevel% neq 0 (
echo.
echo ==========================================
echo ERROR: Unblocking failed.
echo ==========================================
pause
exit /b 1
)

echo.
echo ==========================================
echo SUCCESS: AI website blocking removed.
echo ==========================================
pause