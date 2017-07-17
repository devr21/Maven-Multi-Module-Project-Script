@echo off
setlocal EnableDelayedExpansion
::set me=%~n0
::set log=%temp%\%me%.txt

::if exist "%log%" del /q %log% > NUL

echo "Multi Module Project"
set /p applicationName=ApplicationName:%=%
set /p groupId=groupId:%=%
call :parent %applicationName% %groupId%

cd %applicationName%
::set =This is my string to work with.
set "find=<packaging>jar</packaging>"
set "replace=<packaging>pom</packaging>"
::echo !find!
for /F "tokens=*" %%a in (pom.xml) do (
set "string=%%a"
if !string!==!find! >> newfile.xml echo !replace!
if not !string!==!find! >> newfile.xml echo !string!
)
::call set string=%%string:!find!=!replace!%%
	::>> newfile.xml echo !string!

del pom.xml
ren newfile.xml pom.xml


:while
echo 1.Add new Module
echo 2.Add webapp
echo 3.That's all
set /p choice=Enter your choice:%=%
::echo working till here
	if %choice%==1  call :module 
	
	 if %choice%==2 call :module webapp 
		
		::call :module		
	
	 if %choice%==3 ( call :finish 
		exit /b 0
	 )
goto :while

::echo %parentProjectName%

::call :create %parentProjectName%

::echo %modtype%
goto :eof
::call :create modType
::exit /b 0 

:finish
echo all done

exit /b 0

:parent 
set group=%2
set artifact=%1
echo "starting something"
start /b /wait cmd.exe /c "mvn archetype:generate -DgroupId=%group% -DartifactId=%artifact% -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
exit /b 0

:module

set group=%groupId%
set /p artifact=Module_Name:%=%
echo %artifact% %group%
set webapp=%1
if "%webapp%"=="webapp" start /b /wait cmd.exe /c "mvn archetype:generate -DgroupId=%group% -DartifactId=%artifact% -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false"

if not "%webapp%"=="webapp" start /b /wait cmd.exe /c "mvn archetype:generate -DgroupId=%group% -DartifactId=%artifact% -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"	

set webapp=some
exit /b 0

