function reset-workspace{
    cd C:\Scripts\SOCALPSUG
    Get-ChildItem -Exclude demo,SoCalPresentation.ps1 | remove-item -Recurse -Force
}

#Let's search the PSGallery for plaster
Find-Module -Repository PSGallery plaster

#I have alredy done this but you may need to
import-module Plaster

#Show the Plater Commands
get-command -Module plaster

$default = Get-PlasterTemplate | Where-Object -FilterScript {$PSitem.Title -eq 'New PowerShell Manifest Module'}
$demo = 'C:\Scripts\SOCALPSUG\Demo\'

#Make sure to call it PlasterDemo1 
Invoke-Plaster -TemplatePath $default.TemplatePath -DestinationPath .\PlasterDemo1

cd C:\scripts\SOCALPSUG\PlasterDemo1

code .\PlasterDemo1.psd1
code .\PlasterDemo1.psm1

cd C:\Scripts\SOCALPSUG

Clear-Host

get-help New-PlasterManifest -ShowWindow

mkdir socal2
$outputdir = 'C:\Scripts\SOCALPSUG'
$ManifestProperties =@{
    Path = "$outputdir\plasterManifest.xml"
    Title = "Working with Plaster" 
    Templatename = "Demo1"
    TemplateVersion = "0.0.1"
    Author = "James Petty"
    Description = "Demo for SoCal PSUG for Plaster"
    TemplateType = "Project"
    Verbose = $true
}
New-PlasterManifest @ManifestProperties
#Lets run and see what it does
Invoke-Plaster -TemplatePath $demo\basic -DestinationPath $outputdir\PlasterDemo




#Text paramaters
<parameter prompt="Name of your module" type="text" name="ModuleName"/>
<parameter prompt="Brief Description of your module" type="text" name="ModuleDesc"/>
<parameter prompt="Version Number" type="text" name="ModuleVersion" default="0.0.1"/>

Invoke-Plaster -TemplatePath $demo\basic -DestinationPath $outputdir\PlasterDemo

<parameter prompt="Author" type="user-fullname" name="ModuleAuthor"/>

#Choice Parameter
<parameter name='License' type='choice' default='2' store='text' prompt='Select a license for your module'>
      <choice label='&amp;Apache' help="Adds an Apache license file." value="Apache"/>
      <choice label='&amp;MIT' help="Adds an MIT license file." value="MIT"/>
      <choice label='&amp;None' help="No license specified." value="None"/>
</parameter>

Invoke-Plaster -TemplatePath $demo\basic -DestinationPath $outputdir\PlasterDemo

#Multi-Choice Paramater (Creates array)

c

Invoke-Plaster -TemplatePath $demo\basic -DestinationPath $outputdir\PlasterDemo -Verbose


<newModuleManifest destination='${PLASTER_PARAM_ModuleName}.psd1' 
        moduleVersion='$PLASTER_PARAM_ModuleVersion' 
        rootModule='${PLASTER_PARAM_ModuleName}.psm1' 
        author='$PLASTER_PARAM_ModuleAuthor'
        description='$PLASTER_PARAM_ModuleDesc'/>
<file source='template.psm1' destination='${PLASTER_PARAM_ModuleName}.psm1'/>

<templateFile condition="$PLASTER_PARAM_License -eq 'MIT'" source='Licenses\MIT.md' destination='License.md' />
<templateFile condition="$PLASTER_PARAM_License -eq 'Apache'" source='Licenses\Apache.md' destination='License.md' />

<message>Creating you folders for module: </message>
<file source='' destination='${PLASTER_PARAM_ModuleName}\Public\' condition='$PLASTER_PARAM_FunctionFolders -contains "Public"' />
<file source='' destination='${PLASTER_PARAM_ModuleName}\Private\' condition='$PLASTER_PARAM_FunctionFolders -contains "Private"' />
<file source='' destination='${PLASTER_PARAM_ModuleName}\Docs\' condition='$PLASTER_PARAM_FunctionFolders -contains "Docs"' />
<file source='' destination='${PLASTER_PARAM_ModuleName}\DSCResources\' condition='$PLASTER_PARAM_FunctionFolders -contains "DSCResources"' />




Invoke-Plaster -TemplatePath $demo\basic -DestinationPath $outputdir\PlasterDemo -Verbose

