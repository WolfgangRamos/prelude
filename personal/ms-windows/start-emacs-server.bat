@ECHO OFF

IF EXIST .emacs.d\server\server DEL .emacs.d\server\server

SET PATH=C:\msys64\mingw64\bin;C:\msys64\usr\bin;C:\msys64\mingw64\local\bin;%PATH%

C:\msys64\mingw64\bin\runemacs.exe --daemon
