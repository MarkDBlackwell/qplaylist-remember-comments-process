@echo off

rem For Qplaylist Remember Songs Comments Process

rem Author: Mark D. Blackwell (google me)
rem November 7, 2017 - created

rem --------------
rem %cd:~0,2% is the current drive:
set original-working-drive=%cd:~0,2%

rem %cd:~2%\ is the path part of the current working directory, with trailing backslash:
set original-working-path=%cd:~2%\

rem --------------
start /wait %COMSPEC% /C etc\dont-hang.bat

rem --------------
rem In the parent console, restore the original working location:
%original-working-drive%
cd %original-working-path%\
