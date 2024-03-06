Get-ExecutionPolicy 

.\demo1.ps1

.\demo2.ps1

Get-ChildItem cert:\CurrentUser\my -codesigning

.\SignCode.ps1 -File .\demo2.ps1

code .\demo2.ps1

.\demo2.ps1