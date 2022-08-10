function Start-App {
    try {
        # Preload
        Set-StrictMode -Off

        . $PSScriptRoot/../Utils/Show-Message.ps1
        . $PSScriptRoot/../Utils/Test-Config.ps1

        # if config is not existed, will create one and exit
        Test-Config

        . $ENV:HOMEPATH/Run-App/.run.ps1
        switch -Wildcard ($Args[0]) {
            { ($PSItem -like 'j*') -or ($PSItem -like 'p*') -or ($PSItem -like 'r*') } {
                $RunArgs = $Args[1..$Args.Count]
                if ($RunArgs.Count -eq 0) {
                    Show-Message -Err -Msg "Please give me the app name!"
                    Throw
                }
                . $PSScriptRoot/Smart-Match.ps1
                . $PSScriptRoot/Find-Shim.ps1
                . $PSScriptRoot/Start-As.ps1
                switch -Wildcard ($Args[0]) {
                    'j*' {
                        Start-AsJob -RunArgs $RunArgs
                    }
                    'p*' {
                        Start-AsProcess -RunArgs $RunArgs
                    }
                    'r*' {
                        Start-AsRaw -RunArgs $RunArgs
                    }
                }
                Break
            }
            's*' {
                switch -Wildcard ($Args[1]) {
                    'l*' {
                        . $PSScriptRoot/../Utils/List-Shim.ps1
                        List-Shim
                    }
                    'r*' {
                        . $PSScriptRoot/../Utils/Remove-Shim.ps1
                        Remove-Shim -ShimName $Args[2]
                    }
                    'cl*' {
                        Show-Message -Warn -Msg "Are you sure remove all shims ? [Y/N(default)]`n " -NoNewLine -WithoutDot
                        if ((Read-Host).ToLower() -eq "y") {
                            Show-Message -Notice -Msg "Clear shims would cause Run-App start your app slowly next time."
                            Remove-Item $ENV:HOMEPATH/Run-App/Shims/*
                            Show-Message -Success -Msg "Clear done."
                        }
                    }
                    'cr*' {
                        . $PSScriptRoot/../Utils/Config-Shim.ps1
                        . $PSScriptRoot/../Utils/Create-Shim.ps1
                        [string]$Path = ""
                        [string]$PreArgs = ""
                        [string]$CurrentDir = ""
                        Show-Message -Notice -Msg "Please input the shim's name: " -NoNewLine -WithoutDot
                        [string]$ShimName = Read-Host
                        Config-Shim -Path ([ref]$Path) -PreArgs ([ref]$PreArgs) -CurrentDir ([ref]$CurrentDir)
                        Create-Shim -ShimName $ShimName -Path $Path -PreArgs $PreArgs -CurrentDir $CurrentDir 
                        Show-Message -Success -Msg "Shim created, Run-App will be faster if you want to run that app!"
                    }
                    Default {
                        Show-Message -Err -Msg "Could not determine the shim operation, please give me the correct order."
                    }
                }
                Break
            }
            'h*' {
                . $PSScriptRoot/../Utils/Show-Help.ps1
                Show-Help
                Break
            }
            default {
                Show-Message -Err -Msg "Could not determine the running type, please give me the correct order."
                Show-Message -Notice -Msg "For Help, Just type 'run h[elp]'"
            }
        }

    }
    catch {
    }
}

function Start-AppAsJob {
    "run j $Args" | Invoke-Expression
}

function Start-AppAsProcess {
    "run p $Args" | Invoke-Expression
}

function Start-AppAsRaw {
    "run r $Args" | Invoke-Expression
}