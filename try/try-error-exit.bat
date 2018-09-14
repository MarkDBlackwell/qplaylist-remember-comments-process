rem Copyright (C) 2018 Mark D. Blackwell.
rem    All rights reserved.
rem    This program is distributed in the hope that it will be useful,
rem    but WITHOUT ANY WARRANTY; without even the implied warranty of
rem    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set drive=%cd:~0,2%
echo %drive%
echo %cd:~0,2%

rem Run the Ruby program:
start /wait %COMSPEC% /C ruby try_error_exit.rb

echo %errorlevel%
rem Quit this script, unless at least one email was sent successfully:
if not %errorlevel% == 0 goto :restore
echo "Before restore"
:restore
echo "After restore"
