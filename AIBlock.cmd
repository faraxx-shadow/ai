@echo off
setlocal EnableExtensions

title AI Website Blocker - Computer Lab

:: ============================================================
:: AI WEBSITE BLOCKER
:: For computers you administer
:: ============================================================

echo.
echo ================================================
echo       AI WEBSITE BLOCKER - COMPUTER LAB
echo ================================================
echo.

:: Check administrator privileges
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo ERROR: Administrator privileges are required.
    echo.
    echo Right-click AIBlock.cmd and choose:
    echo "Run as administrator"
    echo.
    pause
    exit /b 1
)

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "START=# === AI-LAB-BLOCK-START ==="
set "END=# === AI-LAB-BLOCK-END ==="

echo Updating Windows HOSTS file...
echo.

:: Create temporary PowerShell script
set "PSFILE=%TEMP%\AIBlock_%RANDOM%.ps1"

> "%PSFILE%" echo $hostsFile = "%HOSTS%"
>> "%PSFILE%" echo $startMarker = "# === AI-LAB-BLOCK-START ==="
>> "%PSFILE%" echo $endMarker = "# === AI-LAB-BLOCK-END ==="
>> "%PSFILE%" echo $domains = @(
>> "%PSFILE%" echo "chatgpt.com",
>> "%PSFILE%" echo "www.chatgpt.com",
>> "%PSFILE%" echo "openai.com",
>> "%PSFILE%" echo "www.openai.com",
>> "%PSFILE%" echo "gemini.google.com/app",
>> "%PSFILE%" echo "claude.ai",
>> "%PSFILE%" echo "www.claude.ai",
>> "%PSFILE%" echo "perplexity.ai",
>> "%PSFILE%" echo "www.perplexity.ai",
>> "%PSFILE%" echo "copilot.microsoft.com",
>> "%PSFILE%" echo "poe.com",
>> "%PSFILE%" echo "www.poe.com",
>> "%PSFILE%" echo "character.ai",
>> "%PSFILE%" echo "www.character.ai",
>> "%PSFILE%" echo "you.com",
>> "%PSFILE%" echo "www.you.com",
>> "%PSFILE%" echo "deepseek.com",
>> "%PSFILE%" echo "www.deepseek.com"
>> "%PSFILE%" echo ^)
>> "%PSFILE%" echo $content = Get-Content -Path $hostsFile -Raw
>> "%PSFILE%" echo $pattern = "(?ms)\Q$startMarker\E.*?\Q$endMarker\E\s*"
>> "%PSFILE%" echo $content = [regex]::Replace($content,$pattern,"")
>> "%PSFILE%" echo $block = @("",$startMarker,"# AI websites blocked on this lab computer")
>> "%PSFILE%" echo foreach ($domain in $domains) { $block += "0.0.0.0`t$domain" }
>> "%PSFILE%" echo $block += $endMarker
>> "%PSFILE%" echo Add-Content -Path $hostsFile -Value ($block -join "`r`n") -Encoding ASCII
>> "%PSFILE%" echo ipconfig /flushdns ^| Out-Null

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%"

set "RESULT=%errorlevel%"

del "%PSFILE%" >nul 2>&1

if "%RESULT%"=="0" (
    echo.
    echo ================================================
    echo SUCCESS
    echo AI website blocking has been installed.
    echo ================================================
) else (
    echo.
    echo ================================================
    echo ERROR
    echo The installation failed.
    echo ================================================
)

echo.
pause
