SET PATH=C:\msys64\mingw64\bin;C:\msys64\usr\bin;C:\msys64\mingw64\local\bin;%PATH%
SET EWWEXPRESSION="(eww """%1""")"
C:\msys64\mingw64\bin\emacsclientw.exe --no-wait --eval %EWWEXPRESSION%
