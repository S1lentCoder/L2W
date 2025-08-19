@echo off
setlocal enabledelayedexpansion
title L2W (Linux to Windows)
color 0A
cls

rem ASCII art
if exist "Art.txt" (
type Art.txt
) else (
echo [Error] File ART.txt not found!
goto loop
) 


rem List of commands
set "ls=dir"
set "pwd=cd"
set "cd=cd"
set "clear=cls"
set "cat=type"
set "mkdir=mkdir"
set "rmdir=rmdir"
set "rm=del"
set "mv=move"
set "cp=copy"
set "tree=tree"
set "stat=dir /q"
set "find=find"
set "findstr=findstr"
set "echo=echo"
set "whoami=echo %USERNAME%"
set "hostname=echo %COMPUTERNAME%"
set "ver=ver"
set "date=date"
set "time=time"
set "shutdown=shutdown"
set "logout=logoff"
set "tasklist=wmic process get description,processid"
set "taskkill=taskkill"
set "chdir=chdir"
set "attrib=attrib"
set "fc=fc"
set "comp=comp"
set "type=type"
set "more=more"
set "pause=pause"
set "set=set"
set "systeminfo=systeminfo"
set "sc=sc"
set "sfc=sfc"
set "chkntfs=chkntfs"
set "chkdsk=chkdsk"
set "diskpart=diskpart"
set "label=label"
set "path=echo %PATH%"
set "prompt=prompt"
set "title=title"
set "help=help"
set "icacls=icacls"
set "cacls=cacls"
set "ip=ipconfig"
set "ping=ping"
set "traceroute=tracert"
set "netstat=netstat"
set "route=route"


rem history
:loop
set "input="
set /p input=user@linux:~$ 
if "!input!"=="" goto loop
echo %input% >> logfile.txt

rem call exit
if /i "!input!"=="exit" (
    set /p exit_confirm=Are you sure? Y/N 
    echo.
    if /i "!exit_confirm!"== "Y" (
        call exit
    ) else (
        goto loop
    )
)

rem call history
if /i "!input!"=="history" (
    if exist logfile.txt (
    type logfile.txt
    goto loop
    ) else (
        touch nul >> logfile.txt
        goto loop
    )
)

rem call help 
if /i "!input!"=="help" (
    if exist Help.txt (
        type Help.txt
        echo 
        goto loop
    ) else (
    echo [Error] File Help.txt not found! 
    goto loop
)
)

rem Separation of commands and arguments
for /f "tokens=1*" %%a in ("%input%") do (
    set "cmd_name=%%a"
    set "cmd_args=%%b"
)

rem call touch
if /i "!cmd_name!"=="touch" (
    type nul > "!cmd_args!".txt
    goto loop
)

rem Execution of user request
set "mapped=!%cmd_name%!"
if defined mapped (
    call !mapped! !cmd_args!
) else (
    echo bash: !cmd_name! command not found
)
goto loop