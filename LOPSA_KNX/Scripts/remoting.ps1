# Install the OpenSSH Client and Server
 
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
 
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
 
# Initial Configuration of SSH Server
 
Start-Service sshd
 
Set-Service -Name sshd -StartupType 'Automatic'
 
# Confirm the Firewall rule is configured. It should be created automatically by setup.
 
Get-NetFirewallRule -Name *ssh*
 
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled