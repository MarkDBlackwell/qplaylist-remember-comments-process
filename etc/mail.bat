rem For Qplaylist Remember Songs Comments Process

rem Author: Mark D. Blackwell (google me)
rem mdb March 20, 2018 - created

rem #--------------
rem Don't greet.

rem To make Windows Task Scheduler think the task is completed,
rem   don't say "/wait" here:
start %ComSpec% /D /E:off /Q /C ruby mail.rb
