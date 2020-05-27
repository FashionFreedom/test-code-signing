Name "Seamly2D installer"

OutFile "seamly2d-installer.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES\Seamly2D

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\NSIS_Seamly2D" "Install_Dir"

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles


Section "Seamly2D"

  SectionIn RO
  
  SetOutPath $INSTDIR

  File /r *
  
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\NSIS_Seamly2D "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Seamly2D" "DisplayName" "Seamly2D"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Seamly2D" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Seamly2D" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Seamly2D" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\Seamly2D"
  CreateShortcut "$SMPROGRAMS\Seamly2D\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\Seamly2D\Seamly2D.lnk" "$INSTDIR\seamly2d.exe" "" "$INSTDIR\seamly2d.exe" 0
  CreateShortcut "$SMPROGRAMS\Seamly2D\SeamlyMe.lnk" "$INSTDIR\seamlyme.exe" "" "$INSTDIR\seamlyme.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Seamly2D"
  DeleteRegKey HKLM SOFTWARE\NSIS_Seamly2D

  ; Remove files and uninstaller
  Delete $INSTDIR\*

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\Seamly2D\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\Seamly2D"
  RMDir "$INSTDIR"

SectionEnd
