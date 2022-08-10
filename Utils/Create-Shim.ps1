function Create-Shim {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "ShimInfo")][string]$ShimName,

        [Parameter(Mandatory, ParameterSetName = "ShimInfo")][string]$Path,
        
        [Parameter(ParameterSetName = "ShimInfo")][string]$PreArgs,

        [Parameter(ParameterSetName = "ShimInfo")][string]$CurrentDir
    )
    if ($ShimName.ToLower() -eq $Path.Replace(".exe", "").ToLower()) {
        Show-Message -Err -Msg "Shim name and Path could not be same, or it will cause self-call bug."
        Throw
    }
    Copy-Item $PSScriptRoot/../bin/shim.exe $ENV:HOMEPATH/Run-App/Shims/$ShimName.exe
    $ShimConfig = Get-Content $PSScriptRoot/../bin/shim.shim
    $ShimConfig = $ShimConfig.Replace("{0}", $Path).Replace("{1}", $PreArgs).Replace("{2}", $CurrentDir)
    Out-File -FilePath $ENV:HOMEPATH/Run-App/Shims/$ShimName.shim -Encoding utf8 -InputObject $ShimConfig
}