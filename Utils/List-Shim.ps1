function List-Shim {
    $Shims = Get-ChildItem $ENV:HOMEPATH/Run-App/Shims/ -Filter *.exe
    foreach($Shim in $Shims) {
        Add-Member -InputObject $Shim -MemberType NoteProperty -Name "ShimName" -Value $Shim.Name.Replace(".exe", "")
    }
    if($Shims){
        $Shims | Format-Table -AutoSize -Property ShimName, LastWriteTime, LastAccessTime
    }else{
        Show-Message -Notice -Msg "There's no shim."
    }
}