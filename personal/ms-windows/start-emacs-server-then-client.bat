@ECHO OFF

IF EXIST %HOME%\.emacs.d\server\server DEL %HOME%\emacs.d\server\server

SET PATH=C:\msys64\mingw64\bin;C:\msys64\usr\bin;C:\msys64\mingw64\local\bin;%PATH%

C:\msys64\mingw64\bin\emacsclientw.exe --no-wait --create-frame --alternate-editor "" %1



