$emacsDotDir="${env:userprofile}\.emacs.d"

# add  user environment variable `HOME`
[Environment]::SetEnvironmentVariable("HOME", "$env:userprofile", "User")

# create Emacs shortcut in autostart location to make Emacs server
# start on user logon
$startupPath=[Environment]::GetFolderPath('Startup')
$WshShell = New-Object -ComObject WScript.Shell
$AutostartShortcut = $WshShell.CreateShortcut("$startupPath\Emacs-Server.lnk")
$AutostartShortcut.TargetPath = "$emacsDotDir\personal\ms-windows\start-emacs-server-then-client.bat"
$AutostartShortcut.WorkingDirectory = "${env:userprofile}"
$AutostartShortcut.IconLocation = "${env:SystemDrive}\msys64\mingw64\share\icons\hicolor\scalable\apps\emacs.ico"
$AutostartShortcut.Save()

# create Emacs shortcut on desktop
$desktopPath = [Environment]::GetFolderPath("Desktop")
$WshShell = New-Object -ComObject WScript.Shell
$DesktopShortcut = $WshShell.CreateShortcut("${desktopPath}\Emacs.lnk")
$DesktopShortcut.TargetPath = "$emacsDotDir\personal\ms-windows\start-emacs-client.bat"
$DesktopShortcut.WorkingDirectory = "${env:userprofile}"
$DesktopShortcut.IconLocation = "${env:SystemDrive}\msys64\mingw64\share\icons\hicolor\scalable\apps\emacs.ico"
$DesktopShortcut.Save()

## Create windows explorer context menu entries for Emacs
# Open with Emacs commands
$emacsclientOpenFileNewFrame="${env:userprofile}\.emacs.d\personal\ms-windows\start-emacs-client.bat ""`%1"""
$emacsclientOpenFileSameFrame="${env:userprofile}\.emacs.d\personal\ms-windows\emacsclient_open_same_frame.bat ""`%1"""
$emacsclientOpenDirectorySameFrame="${env:userprofile}\.emacs.d\personal\ms-windows\emacsclient_open_same_frame.bat ""`%V"""

# Open file in same frame
New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen1sameframe" -Value "&Emacs: Edit in existing window" -Force

New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Classes\*\shell\emacsopen1sameframe" -Name icon -PropertyType String -Value "C:\msys64\mingw64\bin\emacsclientw.exe" -Force

New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen1sameframe\command" -Value "$emacsclientOpenFileSameFrame" -Force

# Open file in new frame
New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe" -Value "&Emacs: Edit in new window" -Force

New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe" -Name icon -PropertyType String -Value "C:\msys64\mingw64\bin\emacsclientw.exe" -Force

New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\emacsopen2newframe\command" -Value "$emacsclientOpenFileNewFrame" -Force

# Dired for directory
New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\emacsopensameframe" -Value "&Emacs: Open in dired" -Force

New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Classes\Directory\shell\emacsopensameframe" -Name icon -PropertyType String -Value "C:\msys64\mingw64\bin\emacsclientw.exe" -Force

New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\emacsopensameframe\command" -Value "$emacsclientOpenDirectorySameFrame" -Force

# Dired for directory background
New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\emacsopensameframe" -Value "&Emacs: Open in dired" -Force

New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Classes\Directory\Background\shell\emacsopensameframe" -Name icon -PropertyType String -Value "C:\msys64\mingw64\bin\emacsclientw.exe" -Force

New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\emacsopensameframe\command" -Value "$emacsclientOpenDirectorySameFrame" -Force

