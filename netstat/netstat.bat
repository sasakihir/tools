@echo off
setlocal enabledelayedexpansion

REM ####################
REM setting
REM ####################

set waits=2
set times=2

REM ####################
REM processing
REM ####################

set log_dir=%~dp0\log
mkdir %log_dir% 2>nul

set cmd1=netstat -an
set loglabel1=netstat-an

set cmd2=netstat -es
set loglabel2=netstat-es

set cmd3=netstat -anbo
set loglabel3=netstat-anbo

for /l %%n in (1,1,%times%) do (
  set time_tmp=!time: =0!
	set now=!date:/=!!time_tmp:~0,2!!time_tmp:~3,2!!time_tmp:~6,2!
	!cmd1! > !log_dir!\!loglabel1!.!now!.log
	!cmd2! > !log_dir!\!loglabel2!.!now!.log
	!cmd3! > !log_dir!\!loglabel3!.!now!.log
  timeout !waits!
)

exit
