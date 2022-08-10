function Config-Shim {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory, ParameterSetName = "ShimInfo")][ref]$Path,

        [Parameter(Mandatory, ParameterSetName = "ShimInfo")][ref]$PreArgs,

        [Parameter(Mandatory, ParameterSetName = "ShimInfo")][ref]$CurrentDir
    )
    Show-Message -Warn -Msg "------------------------ Shim Configurate ------------------------" -WithoutDot 
    Show-Message -Warn -Msg "Path = $($Path.Value)" -WithoutDot
    Show-Message -Notice -Msg "Just type [Enter] if path is corrrect, or type the correct path here: " -NoNewLine -WithoutDot
    [string]$StringInput = Read-Host
    if ($StringInput) {
        $Path.Value = $StringInput
    }
    if (-not(Get-Command -Name $Path.Value 2>$null)) {
        Show-Message -Err -Msg "It seems that $($Path.Value) is not a executable file, still continue? [Y/N(default)]`n " -WithoutDot -NoNewLine
        if ((Read-Host).ToLower() -eq "y") {
            Show-Message -Warn -Msg "Using a unexecutable file to shim might cause some problems. " -WithoutDot
        }
        else {
            Throw
        }
    }
    Show-Message -Warn -Msg "Args = $($PreArgs.Value)" -WithoutDot
    Show-Message -Notice -Msg "Just type [Enter] if args is corrrect, or type the args path here: " -NoNewLine -WithoutDot
    [string]$StringInput = Read-Host
    if ($StringInput) {
        $PreArgs.Value = $StringInput
    }
    Show-Message -Warn -Msg "CurrentDir = $($CurrentDir.Value)" -WithoutDot
    Show-Message -Notice -Msg "Just type [Enter] if current dir is corrrect, or type the current dir path here: " -NoNewLine -WithoutDot
    [string]$StringInput = Read-Host
    if ($StringInput) {
        $CurrentDir.Value = $StringInput
    }
    Show-Message -Warn -Msg "------------------------  End Configurate ------------------------" -WithoutDot 
}