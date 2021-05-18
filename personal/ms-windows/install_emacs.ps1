$emacsDotDir="${env:userprofile}\\.emacs.d"

# make Emacs server start on user logon
$emacsServerStartLnk="${emacsDotDir}\\personal\\ms-windows\\Emacs-Server.lnk"
$startupPath=[Environment]::GetFolderPath('Startup')
Copy-Item "$emacsServerStartLnk" -Destination "$startupPath" -Force

# create Emacs shortcut on desktop
$emacsClientStartLnk="${emacsDotDir}\\personal\\ms-windows\\Emacs.lnk"
$desktopPath = [Environment]::GetFolderPath("Desktop")
Copy-Item "$emacsClientStartLnk" -Destination "$desktopPath" -Force

