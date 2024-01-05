set EMSDK_ROOT=C:\emsdk
set QMAKE_DIR=C:\Qt\5.15.2\wasm_32\bin
set MINGW_DIR=C:\Qt\Tools\mingw810_64\bin
set WORK_DIR=%cd%
set BUILD_DIR=build-wasm
set THIS_FILE_DIR=%~dp0

echo Executing build_wasm.bat located in %THIS_FILE_DIR%
echo from working dir: %WORK_DIR%

cd %EMSDK_ROOT%
call emsdk activate --embedded 1.39.8
call em++ --version

cd %WORK_DIR%

if not exist %BUILD_DIR% mkdir %BUILD_DIR%
cd %BUILD_DIR%

echo Adding qmake to the PATH
set PATH=%QMAKE_DIR%;%PATH%

echo Printing qmake version
call qmake --version

echo Running qmake
call qmake %THIS_FILE_DIR%/qml-games.pro

set PATH=%MINGW_DIR%;%PATH%

echo Printing mingw32-make version
call mingw32-make --version

echo Executing mingw32-make
call mingw32-make
