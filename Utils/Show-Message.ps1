function Show-Message {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory, ParameterSetName="Success")][switch]$Success,

        [Parameter(Mandatory, ParameterSetName="Notice")][switch]$Notice,
        
        [Parameter(Mandatory, ParameterSetName="Error")][switch]$Err,

        [Parameter(Mandatory, ParameterSetName="Warn")][switch]$Warn,

        [Parameter(Mandatory)][string]$Msg,

        [Parameter()][switch]$NoNewLine,

        [Parameter()][switch]$WithoutDot
        
    )

    $RunScript = "Write-Host "
    if(-not $WithoutDot){
        $RunScript += "[*]"
    }
    $RunScript += "`" $Msg`""
    if($NoNewLine){
        $RunScript += " -NoNewLine"
    }
    if($Success){
        $RunScript += " -ForegroundColor Green"
    }elseif($Notice){
        $RunScript += " -ForegroundColor Blue"
    }elseif($Warn){
        $RunScript += " -ForegroundColor Yellow"
    }elseif($Err){
        $RunScript += " -ForegroundColor Red"
    }
    $RunScript | Invoke-Expression
}