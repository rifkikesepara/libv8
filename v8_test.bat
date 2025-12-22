@echo off

setlocal

set "dir=%~dp0"

if not exist "%dir%\v8" (
  echo V8 not found
  exit /b 1
)

call cl.exe /clr /std:c++20 /MT /Zc:__cplusplus ^
  /I"%dir%\v8" /I"%dir%\v8\include" ^
  /Fe".\hello-world" "%dir%\v8\samples\hello-world.cc" ^
  /link "%dir%\v8\out\release\obj\v8_monolith.lib" ^
  advapi32.lib dbghelp.lib winmm.lib ws2_32.lib user32.lib ole32.lib shell32.lib version.lib

if errorlevel 1 (
  echo Compilation failed
  exit /b %errorlevel%
)

call .\hello-world.exe

endlocal
