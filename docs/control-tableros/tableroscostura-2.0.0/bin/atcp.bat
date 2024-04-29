@echo off

set ARG=%1
shift

:APPEND
set ARG=%ARG% %1
shift
if not "%1"=="" goto :APPEND

@set CLASSPATH=%CLASSPATH%;%ARG%
