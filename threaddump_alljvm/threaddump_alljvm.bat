@echo off
setlocal enabledelayedexpansion

REM ####################
REM setting
REM ####################

set jdk_home=C:\Program Files\Java\jdk1.8.0_222
set waits=2
set times=2
REM set pstools_dir=C:\app\PSTools

REM ####################
REM processing
REM ####################

set log_dir=%~dp0\log
mkdir %log_dir% 2>nul
set path=%jdk_home%\bin;%pstools_dir%;%path%

for /l %%n in (1,1,%times%) do (
  set time_tmp=!time: =0!
	set now=!date:/=!!time_tmp:~0,2!!time_tmp:~3,2!!time_tmp:~6,2!
	tasklist /v | findstr java > !log_dir!\!now!.tasklist.log 2>&1
  jps -vlm > !log_dir!\!now!.jps.log 2>&1

	for /f "tokens=2" %%a in ('tasklist ^| findstr java') do (
	set pid=%%a
  set time_tmp=!time: =0!
	set now=!date:/=!!time_tmp:~0,2!!time_tmp:~3,2!!time_tmp:~6,2!
  REM jstack.exe !pid! > !log_dir!\threaddump.pid-!pid!.timestamp-!now!.log 2> !log_dir!\threaddump.pid-!pid!.timestamp-!now!.err.log
  jstack.exe !pid! > !log_dir!\!now!.threaddump.pid-!pid!.log 2> !log_dir!\!now!.threaddump.pid-!pid!.err.log
	)
  timeout !waits!
)

REM exit
