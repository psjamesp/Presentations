$cred = Get-Credential puzzles\marshall
Enter-PSSession -ComputerName NRDC -ConfigurationName demo -Credential $cred



get-command