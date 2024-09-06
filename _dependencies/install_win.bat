@echo off
setlocal

REM Script directory
set "SCRIPT_DIR=%~dp0"

REM Source directory
set "SOURCE_DIR=%SCRIPT_DIR%_orbinaut_filter_distortion"

REM Check if source directory exists
if not exist "%SOURCE_DIR%" (
    echo "%SOURCE_DIR% does not exist. Make sure it is located in the same directory as this script."
    pause
    exit /b 1
)

REM Destination base directory
set "DEST_DIR_BASE=C:\ProgramData\GameMakerStudio2\Cache\runtimes"

REM Get latest runtime directory
for /f "delims=" %%i in ('dir /b /ad /o-d "%DEST_DIR_BASE%"') do (
    set "LATEST_DIR=%%i"
    goto found_latest
)

rem Check if destination directory exists
:found_latest
if "%LATEST_DIR%"=="" (
    echo "%LATEST_DIR% runtime does not exist. Make sure GameMaker is installed."
    pause
    exit /b 1
)

REM FiltersAndEffects path
set "DEST_DIR=%DEST_DIR_BASE%\%LATEST_DIR%\bin\FiltersAndEffects"

REM Copy folder
xcopy /e /i /y "%SOURCE_DIR%" "%DEST_DIR%\_orbinaut_filter_distortion"

REM Check if copying was successful
if %errorlevel% equ 0 (
    echo "Effect has been successfully installed for runtime %LATEST_DIR%"
) else (
    echo "An error has occurred while installing the effect..."
)

pause
exit /b 1