@echo OFF

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT ( 
  echo Sistema Opertaivo de 32bit
  start ./jre-8u144-windows-i586.exe
  start ./CP210x_Windows_Drivers/CP210xVCPInstaller_x86.exe
  pause
)
if %OS%==64BIT ( 
  echo Sistema Opertaivo de 64bit
  start ./jre-8u144-windows-x64.exe
  start ./CP210x_Windows_Drivers/CP210xVCPInstaller_x64.exe
  pause
)

pause