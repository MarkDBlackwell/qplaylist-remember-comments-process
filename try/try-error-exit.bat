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
