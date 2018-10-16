rem Copyright (C) 2018 Mark D. Blackwell.
rem    All rights reserved.
rem    This program is distributed in the hope that it will be useful,
rem    but WITHOUT ANY WARRANTY; without even the implied warranty of
rem    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rem For Qplaylist Remember Songs Comments Process

rem #--------------
rem Don't greet.

rem To make Windows Task Scheduler think the task is completed,
rem   don't say "/wait" here:
start %ComSpec% /D /E:off /Q /C ruby mail.rb
