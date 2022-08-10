function Remove-Shim {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory, ParameterSetName="ShimName")][string]$ShimName
    )
    if(Test-Path "$ENV:HOMEPATH/Run-App/Shims/$ShimName.*"){
        Remove-Item "$ENV:HOMEPATH/Run-App/Shims/$ShimName.*"
        Show-Message -Success -Msg "Shim of $ShimName remove successful."
    }else{
        Show-Message -Err -Msg "Fail to remove shim of $ShimName, since it was not existed."
    }
}