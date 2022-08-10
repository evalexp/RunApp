function Smart-Match {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "SmartMatch")][string]$ProgramName
    )
    foreach ($AppDir in $BaseDir) {
        foreach ($dir in (Get-ChildItem $AppDir)) {
            if ($dir.Name -like "*$ProgramName*") {
                foreach ($binDir in $BinSearch) {
                    $binPath = "$($dir.FullName)/$binDir/"
                    if (-not (Test-Path $binPath)) {
                        continue
                    }
                    foreach ($ext in $BinExt) {
                        foreach ($file in (Get-ChildItem $binPath)) {
                            if ($file.Name -like "*$ProgramName*.$ext") {
                                $file.FullName
                            }
                        }
                    }
                }
            }
        }
    }
}