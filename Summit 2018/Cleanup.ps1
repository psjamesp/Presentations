remove-item $env:ProgramData\JEAConfiguration -Recurse
remove-item 'C:\Program Files\WindowsPowerShell\Modules\Demo' -Recurse

Uninstall-WindowsFeature web-server

Unregister-PSSessionConfiguration -name demo