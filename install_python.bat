@echo off
:: Hide command window
title Installing Python & Dependencies
echo Checking for Python installation...

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Downloading and installing...
    curl -o python-installer.exe https://www.python.org/ftp/python/3.12.1/python-3.12.1.exe
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    echo Python installed successfully.
) else (
    echo Python is already installed.
)

:: Ensure pip is installed
python -m ensurepip --default-pip
python -m pip install --upgrade pip

:: Install missing dependencies
for %%i in (pywin32 pycryptodome requests) do (
    python -c "import %%i" 2>nul || python -m pip install %%i
)

echo All dependencies installed.
