@echo off
setlocal

rem -- Check existence of JVM --------------------------------------------------
java -version >nul 2>&1
if errorlevel 1 goto :NO_JAVA

rem -- Prepare CLASSPATH -------------------------------------------------------
call "%~dp0\atcp.bat" %~dp0..\config
for %%1 in ("%~dp0..\lib\*.jar" "%~dp0..\drivers\*.jar") do call "%~dp0\atcp.bat" %%1

rem -- Invocation to client ------------------------------------------------------------
echo.
start javaw -Xms256m -Xmx512m -cp "%CLASSPATH%"; ar.com.controlarg.tableroscostura.App -Dlog4j2.contextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector %*
goto :END

:NO_JAVA
echo Java Virtual Machine not found, please add JRE's bin directory to PATH environment variable
goto :END

:END
endlocal
