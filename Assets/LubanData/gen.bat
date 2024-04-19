set WORKSPACE=..
set LUBAN_DLL=%WORKSPACE%\..\Luban\Luban.dll
set CONF_ROOT=.

dotnet %LUBAN_DLL% ^
    -t all ^
    -c lua-bin ^
    -d bin ^
    --conf %CONF_ROOT%\luban.conf ^
    -x outputCodeDir=..\Lua\Gen ^
    -x outputDataDir=..\GenerateDatas

pause