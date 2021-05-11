@ECHO OFF

TITLE Start Emacs client

SET HOME=C:\Users\wr

C: CD %HOME%

REM IF EXIST .emacs.d\server\server DEL .emacs.d\server\server

SET PATH=C:\msys64\mingw64\local\bin;C:\msys64\mingw64\bin;C:\msys64\usr\bin;%PATH%

REM C:\msys64\mingw64\bin\emacsclientw.exe -n -a C:\msys64\mingw64\bin\runemacs.exe
C:\msys64\mingw64\bin\emacsclientw.exe -n -c --server-file "C:\Users\wr\.emacs.d\server\server" -a ""