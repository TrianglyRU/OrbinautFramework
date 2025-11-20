@echo off
setlocal

REM Script directory
set "SCRIPT_DIR=%~dp0"

REM Source directory
set "SOURCE_DIR=%SCRIPT_DIR%io.gamemaker.gm_orbinaut_filter_distortion-1.0.0"

REM Destination directory
set "DEST_DIR=C:\ProgramData\GameMakerStudio2\Prefabs"

REM Check if source exists
if not exist "%SOURCE_DIR%" (
    echo Source folder not found: "%SOURCE_DIR%"
    pause
    exit /b 1
)

REM Ensure destination exists
if not exist "%DEST_DIR%" (
    echo Destination folder not found: "%DEST_DIR%"
    pause
    exit /b 1
)

REM Remove old copy if exists
if exist "%DEST_DIR%\io.gamemaker.gm_orbinaut_filter_distortion-1.0.0" (
    echo Removing existing folder...
    rmdir /s /q "%DEST_DIR%\io.gamemaker.gm_orbinaut_filter_distortion-1.0.0"
)

REM Copy folder
echo Copying...
xcopy /e /i /y "%SOURCE_DIR%" "%DEST_DIR%\io.gamemaker.gm_orbinaut_filter_distortion-1.0.0" >nul

if %errorlevel% equ 0 (
    echo Installed successfully.
) else (
    echo Installation error.
)

pause
exit /b