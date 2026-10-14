@echo off
REM ============================================================
REM  Doc2MD - Installer / Updater
REM ============================================================
chcp 65001 >nul
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

echo.
echo  ========================================================
echo                   Doc2MD  -  Install Prerequisites
echo  ========================================================
echo.

REM Make sure Python is present
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] Python is not installed or not in PATH.
    echo          Download Python 3.10+ from https://www.python.org/downloads/
    echo          IMPORTANT: check "Add Python to PATH" during installation.
    echo.
    echo  Press any key to exit...
    pause >nul
    exit /b 1
)

echo  [INFO] Upgrading pip...
python -m pip install --upgrade pip
if %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] Failed to upgrade pip.
    echo          Try running this script as Administrator, or use:
    echo          python -m pip install --user --upgrade pip
    echo.
    echo  Press any key to exit...
    pause >nul
    exit /b 1
)

echo.
echo  [INFO] Installing markitdown with Office + PDF extras...
python -m pip install --upgrade "markitdown[docx,pptx,xlsx,pdf]"
if %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] Failed to install markitdown.
    echo          Common causes: no internet, proxy, or permission denied.
    echo          Try: python -m pip install --user "markitdown[docx,pptx,xlsx,pdf]"
    echo.
    echo  Press any key to exit...
    pause >nul
    exit /b 1
)

echo.
echo  [INFO] Installing undoc (for image extraction)...
python -m pip install --upgrade undoc
if %ERRORLEVEL% NEQ 0 (
    echo  [WARNING] Failed to install undoc.
    echo            Text conversion will still work, but images will not be embedded.
) else (
    echo  [OK] undoc installed successfully.
)

echo.
echo  [INFO] Installing PyMuPDF + python-bidi (better Persian/Arabic PDF support)...
python -m pip install --upgrade pymupdf python-bidi
if %ERRORLEVEL% NEQ 0 (
    echo  [WARNING] Failed to install pymupdf / python-bidi.
    echo            Persian PDFs may still have character-order issues.
) else (
    echo  [OK] pymupdf and python-bidi installed successfully.
)

echo.
echo  ========================================================
echo  [SUCCESS] Installation finished!
echo  You can now use option [1] or [2] in the main menu.
echo  ========================================================
echo.
echo  Press any key to return to the menu...
pause >nul
endlocal
exit /b 0
