@ECHO OFF

TITLE Start Emacs deamon

SET HOME=%userprofile%

C: CD %HOME%

SET PATH=C:\msys64\mingw64\local\bin;C:\msys64\mingw64\bin;C:\msys64\usr\bin;%PATH%

C:\msys64\mingw64\bin\runemacs.exe --daemon