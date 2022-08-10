#Requires -Version 5

Import-Module $PSScriptRoot/Utils/Start-App.ps1

New-Alias -Name run -Value Start-App

New-Alias -Name runj -Value Start-AppAsJob

New-Alias -Name runp -Value Start-AppAsProcess

New-Alias -Name runr -Value Start-AppAsRaw
