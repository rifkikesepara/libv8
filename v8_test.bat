@echo off
setlocal

set "dir=%~dp0"

if not exist "%dir%\v8" (
  echo V8 not found
  exit /b 1
)

rem ---- match V8 build config (pointer compression + sandbox ON) ----
set "V8_DEFS=/D V8_COMPRESS_POINTERS /D V8_31BIT_SMIS_ON_64BIT_ARCH /D V8_ENABLE_SANDBOX"

call cl.exe /nologo /std:c++20 /MT /Zc:__cplusplus ^
  %V8_DEFS% ^
  /I"%dir%\v8" /I"%dir%\v8\include" ^
  /Fe".\hello-world.exe" "%dir%\v8\samples\hello-world.cc" ^
  /link "%dir%\v8\out\release\obj\v8_monolith.lib" ^
  advapi32.lib dbghelp.lib winmm.lib ws2_32.lib user32.lib ole32.lib shell32.lib version.lib

if errorlevel 1 (
  echo Compilation failed
  exit /b %errorlevel%
)

call .\hello-world.exe

endlocal
