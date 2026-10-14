@echo off
REM ============================================================
REM  Doc2MD - Interactive CLI Menu
REM  Double-click this file to start.
REM ============================================================
chcp 65001 >nul 2>&1
setlocal EnableExtensions EnableDelayedExpansion

REM Force UTF-8 for Python
set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"

REM Always run from the folder where this script lives
cd /d "%~dp0"

:MENU
cls
echo.
echo  ========================================================
echo                   Doc2MD  -  Document to Markdown
echo  ========================================================
echo.
echo     [1] Convert a single file to Markdown
echo     [2] Convert a whole folder
echo     [3] Check prerequisites
echo     [4] Install / Update prerequisites
echo     [5] Exit
echo.
echo  --------------------------------------------------------
set "CHOICE="
set /p "CHOICE=  Enter your choice (1-5): "

if "!CHOICE!"=="1" goto CONVERT_FILE
if "!CHOICE!"=="2" goto CONVERT_FOLDER
if "!CHOICE!"=="3" goto CHECK
if "!CHOICE!"=="4" goto INSTALL
if "!CHOICE!"=="5" goto EXIT

echo.
echo  [ERROR] Invalid choice. Please enter 1, 2, 3, 4 or 5.
timeout /t 2 >nul
goto MENU

:CONVERT_FILE
echo.
echo  --------------------------------------------------------
echo   Convert a single file
echo  --------------------------------------------------------
echo.
echo  Tip: Drag-and-drop the file or paste the full path.
echo.
set "FILEPATH="
set /p "FILEPATH=  Full path to file: "

set "FILEPATH=!FILEPATH:"=!"
set "FILEPATH=!FILEPATH:'=!"

if "!FILEPATH!"=="" (
    echo.
    echo  [ERROR] No path entered.
    goto WAIT_AND_MENU
)

echo.
echo  [INFO] Starting conversion...
echo.
python "%~dp0converter.py" "!FILEPATH!"
echo.
if errorlevel 1 (
    echo  [ERROR] Conversion failed.
) else (
    echo  [SUCCESS] Done.
)
goto WAIT_AND_MENU

:CONVERT_FOLDER
echo.
echo  --------------------------------------------------------
echo   Convert a whole folder
echo  --------------------------------------------------------
echo.
echo  Tip: Drag-and-drop the folder or paste the full path.
echo.
set "FOLDERPATH="
set /p "FOLDERPATH=  Full path to folder: "

set "FOLDERPATH=!FOLDERPATH:"=!"
set "FOLDERPATH=!FOLDERPATH:'=!"

if "!FOLDERPATH!"=="" (
    echo.
    echo  [ERROR] No path entered.
    goto WAIT_AND_MENU
)

echo.
echo  Which files should be converted?
echo.
echo     [A] All supported formats
echo     [D] Only Word (.docx)
echo     [P] Only PowerPoint (.pptx)
echo     [E] Only Excel (.xlsx / .xls)
echo     [F] Only PDF (.pdf)
echo     [M] Mix - type extensions yourself (e.g. docx,pdf,pptx)
echo.
set "FMTCHOICE="
set /p "FMTCHOICE=  Enter your choice (A/D/P/E/F/M): "

set "EXTLIST="
if /i "!FMTCHOICE!"=="A" set "EXTLIST=all"
if /i "!FMTCHOICE!"=="D" set "EXTLIST=docx"
if /i "!FMTCHOICE!"=="P" set "EXTLIST=pptx"
if /i "!FMTCHOICE!"=="E" set "EXTLIST=xlsx,xls"
if /i "!FMTCHOICE!"=="F" set "EXTLIST=pdf"
if /i "!FMTCHOICE!"=="M" (
    echo.
    set /p "EXTLIST=  Type extensions separated by comma (e.g. docx,pdf): "
)

if "!EXTLIST!"=="" (
    echo.
    echo  [ERROR] No format selected. Using ALL supported formats.
    set "EXTLIST=all"
)

echo.
echo  [INFO] Starting folder conversion...
echo.
if /i "!EXTLIST!"=="all" (
    python "%~dp0converter.py" --folder "!FOLDERPATH!"
) else (
    python "%~dp0converter.py" --folder "!FOLDERPATH!" --ext "!EXTLIST!"
)
echo.
if errorlevel 1 (
    echo  [ERROR] Some files may have failed.
) else (
    echo  [SUCCESS] Folder conversion finished.
)
goto WAIT_AND_MENU

:CHECK
echo.
call "%~dp0check.bat"
goto MENU

:INSTALL
echo.
call "%~dp0install.bat"
goto MENU

:WAIT_AND_MENU
echo.
echo  --------------------------------------------------------
echo  Press any key to return to the menu...
pause >nul
goto MENU

:EXIT
echo.
echo  Goodbye!
timeout /t 1 >nul
endlocal
exit /b 0
