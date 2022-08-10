function Get-RunCommand {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Args")][array]$RunArgs
    )
    # Find shim first
    $Shim = Find-Shim -ProgramName $RunArgs[0]
    if ($Shim) {
        Show-Message -Success -Msg "Shim($Shim) found, run your app using shim."
        Return $Shim
    }
    else {
        Show-Message -Notice -Msg "Shim nout found, scan your app folder to auto run..."
        $MatchList = Smart-Match -ProgramName $RunArgs[0]
        [string]$RunApp = ""
        if ($MatchList) {
            if ($MatchList.Count -gt 1) {
                Show-Message -Notice -Msg "We found more than two binary name like '$($RunArgs[0])', which one you want to run?"
                $Index = 1
                foreach ($App in $MatchList) {
                    Show-Message -Warn -Msg "  $Index`t=> $App" -WithoutDot
                    $Index += 1
                }
                Show-Message -Notice -Msg "  Please input your selection: " -NoNewLine -WithoutDot
                $Selection = Read-Host
                $Selection = $Selection -as [int]
                if ($Selection -and (($Selection -ge 1) -and ($Selection -le $MatchList.Count))) {
                    $RunApp = $MatchList[$Selection - 1]
                }
                else {
                    Show-Message -Err -Msg "Error input."
                    Throw
                }
            }
            else {
                $RunApp = $MatchList
                Show-Message -Notice -Msg "Auto detect $RunApp"
            }
            Show-Message -Notice -Msg "Prepare to create shim for that app."
            Show-Message -Notice -Msg " - Please input the name(Please Input Full Name withou Extension) for this app: " -WithoutDot -NoNewLine
            [string]$ShimName = Read-Host
            if (-not $ShimName) {
                Show-Message -Err -Msg "Shim name is required."
                Throw
            }
            $Splited = $RunApp.Split("\")
            [string]$Path = ""
            [string]$PreArgs = ""
            [string]$CurrentDir = $Splited[0..($Splited.Count - 2)] -join "\"
            $RunAppExt = $RunApp.Split(".")[-1]
            if ($ExtAssociation.Contains($RunAppExt)) {
                $Path = $ExtAssociation[$RunAppExt]
            }
            else {
                $Path = $RunApp
            }
            if ($RunAppExt -eq "jar") {
                $PreArgs = "-jar "
            }
            if (($RunAppExt -ne "exe") -and ($RunAppExt -ne "bat")) {
                $PreArgs += "$RunApp"
            }
            Write-Host $PreArgs
            . $PSScriptRoot/Config-Shim.ps1
            Config-Shim -Path ([ref]$Path) -PreArgs ([ref]$PreArgs) -CurrentDir ([ref]$CurrentDir)
            . $PSScriptRoot/Create-Shim.ps1
            Create-Shim -ShimName $ShimName -Path $Path -PreArgs $PreArgs -CurrentDir $CurrentDir 
            Show-Message -Success -Msg "Shim created, Run-App will be faster if you want to run that app!"
            return Find-Shim -ProgramName $ShimName
        }
        else {
            Show-Message -Err -Msg "Error: Could not find any app name like '$($RunArgs[0])', please ensure your input."
            Throw
        }
    }
}

function Start-AsJob {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Args")][array]$RunArgs
    )
    $Command = Get-RunCommand -RunArgs $RunArgs
    $JobName = $Command.Split(".")[0].Split("\")[-1]
    if ((Get-Job -Name $JobName 2>$null) -and (Get-Job -Name $JobName).State.Contains("Running")) {
        Show-Message -Notice -Msg "Looks like the app has started, still launch? [Y/N(default)]`n " -NoNewLine -WithoutDot
        if ((Read-Host).ToLower() -ne "y") {
            Throw
        }
    }
    else {
        Get-Job -Name $JobName 2>$null | Remove-Job 2>$null
    }
    $ScriptBlock = [scriptblock]::create("$Command $($RunArgs[1..$RunArgs.Count])")
    $job = Start-Job -ScriptBlock $ScriptBlock -Name $Command.Split(".")[0].Split("\")[-1]
    Show-Message -Success -Msg "Job Id is $($job.Id)"
    Show-Message -Success -Msg "You could view it's output via 'Receive-Job $($job.Id)' or 'Receive-Job $JobName'(Single Run)"
    Show-Message -Success -Msg "You could stop it via 'Stop-Job $($job.Id)' or 'Stop-Job $JobName'(Single Run)"
}

function Start-AsProcess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Args")][array]$RunArgs
    )
    $Command = Get-RunCommand -RunArgs $RunArgs
    Start-Process -FilePath $Command -ArgumentList $RunArgs[0..$RunArgs.Count]
    Show-Message -Success -Msg "Process start successful."
    Show-Message -Warn -Msg "The process is out of control, you have to close it yourself."
}

function Start-AsRaw {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Args")][array]$RunArgs
    )
    $Command = Get-RunCommand -RunArgs $RunArgs
    Show-Message -Success -Msg "This would run app in this console."
    Show-Message -Success -Msg "Start it right now."
    [scriptblock]::create("$Command $($RunArgs[1..$RunArgs.Count])") | Invoke-Expression
}