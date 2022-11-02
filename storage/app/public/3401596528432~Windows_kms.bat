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
echo Applying the fix for Windows Activation
C:\windows\system32\cscript.exe c:\windows\system32\slmgr.vbs -skms GADC-
pause
C:\windows\system32\cscript.exe c:\windows\system32\slmgr.vbs -ato
pause
echo Windows should now be activated if you had no errors. Double check to ensure has been activated.
Sleep 5
pause

 

::Batch script between these
  exit /b

 

  :UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

 

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
   exit /B`