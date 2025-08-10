@echo off
setlocal enabledelayedexpansion
title L2W (Linux to Windows)
color 0A
cls

rem Проверка наличия ASCII-арт и его отрисовка. Если его не будет, получим ошибку
if exist "Art.txt" (
type Art.txt
) else (
echo [Error] File ART.txt not found!
goto loop
) 

rem Список команд (База данных реализована внутри скрипта, так как я не смог разобраться, как искать файлы в .ini)

rem Базовые команды (Работа с файлами)
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


rem Взаимодействие с системой (Прочее)
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

rem Сеть
set "ip=ipconfig"
set "ping=ping"
set "traceroute=tracert"
set "netstat=netstat"
set "route=route"


rem Принимаем данные от пользователя и проверям их присутствие
:loop
set "input="
set /p input=user@linux:~$ 
if "!input!"=="" goto loop
echo %input% >> logfile.txt

rem Команда exit с подтверждением выхода (На всякий)
if /i "!input!"=="exit" (
    set /p exit_confirm=Are you sure? Y/N 
    echo.
    if /i "!exit_confirm!"== "Y" (
        call exit
    ) else (
        goto loop
    )
)

rem История запросов (Через doskey /history невозможен. По крайней мере у меня не получилось)
if /i "!input!"=="history" (
    if exist logfile.txt (
    type logfile.txt
    goto loop
    ) else (
        touch nul >> logfile.txt
        goto loop
    )
)

rem Кастомная команда help 
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

rem Разделение команды и аргументов (PS: Принимает аргументы от Виндовса)
for /f "tokens=1*" %%a in ("%input%") do (
    set "cmd_name=%%a"
    set "cmd_args=%%b"
)

rem Реализация touch (Так как такой команды нет, пришлось её сделать самостоятельно)
if /i "!cmd_name!"=="touch" (
    type nul > "!cmd_args!".txt
    goto loop
)

rem Создание полноценной команды из найденой команды в списке + введённого пользователем аргумента (Флага). Если нет, получим ошибку
set "mapped=!%cmd_name%!"
if defined mapped (
    call !mapped! !cmd_args!
) else (
    echo bash: !cmd_name! command not found
)
goto loop