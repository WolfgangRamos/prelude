New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe" -Value "&Emacs: Edit in new window"

New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe" -Name icon -PropertyType String -Value "C:\msys64\mingw64\bin\emacsclientw.exe"
$emacsopen2newframe="${env:userprofile}\.emacs.d\personal\ms-windows\start-emacs-client.bat ""`%1"""
New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe\command" -Value "$emacsopen2newframe"
