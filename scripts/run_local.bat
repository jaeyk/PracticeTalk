@echo off
setlocal

cd /d "%~dp0\.."

set "URL=http://127.0.0.1:8000"
set "VENV_DIR=.venv"
set "PYTHON_EXE="

where py >nul 2>nul
if %ERRORLEVEL%==0 (
  set "PYTHON_EXE=py"
) else (
  where python >nul 2>nul
  if %ERRORLEVEL%==0 (
    set "PYTHON_EXE=python"
  )
)

if "%PYTHON_EXE%"=="" (
  echo Error: Python 3 is not installed. Install Python 3.10+ from https://www.python.org/downloads/
  exit /b 1
)

echo Using Python:
%PYTHON_EXE% --version

if not exist "%VENV_DIR%\Scripts\python.exe" (
  echo Creating virtual environment...
  %PYTHON_EXE% -m venv "%VENV_DIR%"
)

set "VENV_PY=%VENV_DIR%\Scripts\python.exe"
if not exist "%VENV_PY%" (
  echo Error: could not find %VENV_PY%
  exit /b 1
)

echo Installing dependencies...
"%VENV_PY%" -m pip install -r requirements.txt
if not %ERRORLEVEL%==0 exit /b %ERRORLEVEL%

start "" "%URL%"

echo Starting PracticeTalk at %URL%
"%VENV_PY%" -m uvicorn main:app --host 127.0.0.1 --port 8000

endlocal
