function Test-Config {
    if (-not(Test-Path -Path "$ENV:HOMEPATH/Run-App/" -PathType Container)) {
        New-Item -ItemType Directory -Path "$ENV:HOMEPATH/Run-App/" 1>$null
    }
    if (-not(Test-Path -Path "$ENV:HOMEPATH/Run-App/Shims")) {
        New-Item -ItemType Directory -Path "$ENV:HOMEPATH/Run-App/Shims" 1>$null
    }
    if (-not(Test-Path -Path "$ENV:HOMEPATH/Run-App/.run.ps1")) {
        Copy-Item $PSScriptRoot/../ProfileTemplate/.run.ps1 $ENV:HOMEPATH/Run-App/.run.ps1
        Show-Message -Notice -Msg "Profile not detected, create an initial one."
        Show-Message -Notice -Msg "First time? Read the help first, just type `'" -NoNewLine
        Show-Message -Success -Msg "run help" -NoNewLine -WithoutDot
        Show-Message -Notice -Msg "`' to get the help." -WithoutDot
        Throw
    }
}
