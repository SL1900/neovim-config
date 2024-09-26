@ECHO OFF

set COMMAND="setx XDG_CONFIG_HOME """%USERPROFILE%\.config""""
runas /noprofile /user:%COMPUTERNAME%\%USERNAME% "cmd /k ""%COMMAND%"" && pause && exit"
