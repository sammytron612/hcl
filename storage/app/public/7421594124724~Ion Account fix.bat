@echo off
  call :isAdmin

  if %errorlevel% == 0 (
     goto :run
  ) else (
     echo Requesting administrative privileges...
     goto :UACPrompt
  )

  exit /b

  :isAdmin
     fsutil dirty query %systemdrive% >nul
  exit /b

  :run
::Batch script between these
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Failure: Current permissions inadequate.
)
echo adding key for ion accounts
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity" /V  "DisableADALatopWAMOverride" /t REG_DWORD /d 1
echo Key Added - Restart and try adding Ion account
pause

::Batch script between these
  exit /b

  :UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
   exit /B`
