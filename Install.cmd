@echo off
title AI Website Blocker

echo ==========================================
echo AI WEBSITE BLOCKER - LAB PC
echo ==========================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
echo ERROR: Please run this file as Administrator.
echo.
pause
exit /b 1
)

echo Running blocker...
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Block-AI.ps1"

if %errorlevel% neq 0 (
echo.
echo ==========================================
echo ERROR: Installation failed.
echo ==========================================
pause
exit /b 1
)

echo.
echo ==========================================
echo SUCCESS: AI website blocking applied.
echo ==========================================
pause