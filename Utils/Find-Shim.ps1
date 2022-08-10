function Find-Shim {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "ShimRun")][string]$ProgramName
    )
    Return (Get-ChildItem $ENV:HOMEPATH/Run-App/Shims/ -Filter "*$ProgramName*.exe").FullName
}