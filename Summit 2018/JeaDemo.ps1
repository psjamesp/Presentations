#First we have to make module called DEMO
New-Item -path 'C:\Program Files\WindowsPowerShell\Modules' -ItemType Directory -Name Demo
New-Item -path 'C:\Program Files\WindowsPowerShell\Modules\Demo' -ItemType Directory -Name RoleCapabilities
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Demo' -ItemType File -Name Demo.psm1
New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\demo\demo.psd1' `
-RootModule 'C:\Program Files\WindowsPowerShell\Modules\demo\demo.psm1'

gci 'C:\Program Files\WindowsPowerShell\Modules\demo'

#Make JeaConfiguration folder in ProgramData
if ((Test-Path "$env:ProgramData\JEAConfiguration") -eq $false){New-Item -ItemType Directory `
-path $env:ProgramData -Name JEAConfiguration}


#who can do what
$ConfFileData = @{
    SessionType = "RestrictedRemoteServer"
    TranscriptDirectory = "C:\ProgramData\JEATranscripts"
    RunAsVirtualAccount = $true
    RoleDefinitions = @{'Puzzles\Marshall'= @{ RoleCapabilities = 'Demo' }}
    Path = "$env:ProgramData\JEAConfiguration\Demo.pssc"
}
New-PSSessionConfigurationFile @ConfFileData

cd C:\ProgramData\JEAConfiguration
psedit .\Demo.pssc








#Make a new Role Capability File
#What can the uesr do
New-PSRoleCapabilityFile -Path 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'
psedit 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'

#Just Cmdlests
$CapabilityFile = @{
    Path = 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'
    VisibleCmdlets = "get-process","get-service","restart-computer"
}

New-PSRoleCapabilityFile @CapabilityFile



#Adding functions
$CapabilityFile = @{
    Path = 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'
    VisibleCmdlets = "get-process","get-service","restart-computer"
    VisibleFunctions='Disable-ScheduledTask',
    'Enable-ScheduledTask',
    'Start-ScheduledTask',
    'Stop-ScheduledTask',
    'Where-Object',
    'Select-Object',
    'Get-SmbOpenFile',
    'Close-SmbOpenFile'
}

New-PSRoleCapabilityFile @CapabilityFile


#Add these to .\demo.psrc file on Member Server
#VisibleCmdlets = 'Get-service','get-process'









Register-PSSessionConfiguration -Name Demo -Path "$env:ProgramData\JeaConfiguration\Demo.pssc" 

Enter-PSSession nrdc -ConfigurationName Demo




Install-WindowsFeature web-server
get-command -Module WebAdministration



$CapabilityFile = @{
    Path = 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'
    VisibleCmdlets = "get-process","get-service","restart-computer","web-administration\get*"
    VisibleFunctions='Disable-ScheduledTask',
    'Enable-ScheduledTask',
    'Start-ScheduledTask',
    'Stop-ScheduledTask',
    'Where-Object',
    'Select-Object',
    'Get-SmbOpenFile',
    'Close-SmbOpenFile'
}

New-PSRoleCapabilityFile @CapabilityFile


#who can do what
$ConfFileData = @{
    SessionType = "RestrictedRemoteServer"
    TranscriptDirectory = "C:\ProgramData\JEATranscripts"
    RunAsVirtualAccount = $true
    RoleDefinitions = @{ 'Puzzles\Marshall' = @{ RoleCapabilities = 'Demo' }}
    Path = "$env:ProgramData\JEAConfiguration\Demo.pssc"
}
New-PSSessionConfigurationFile @ConfFileData

#IIS
$CapabilityFile = @{
    Path = 'C:\Program Files\WindowsPowerShell\Modules\Demo\RoleCapabilities\demo.psrc'
    VisibleCmdlets = "web-administration\get*"
}
New-PSSessionConfigurationFile @ConfFileData
