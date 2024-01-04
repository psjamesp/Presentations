## Signs a file
[cmdletbinding()]
param(
    [Parameter(Mandatory=$true)]
    [string] $File
)

$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |
    Select-Object -First 1

Set-AuthenticodeSignature -FilePath $File -Certificate $cert