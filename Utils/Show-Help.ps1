function Show-Help {
    Show-Message -Notice -Msg "Usage: " -WithoutDot
    Show-Message -Notice -Msg "  job" -WithoutDot -NoNewLine
    Show-Message -Warn -Msg "`t`twhich could start your app as powershell job(output capture supproted, but would die if powershell exit)" -WithoutDot
    Show-Message -Notice -Msg "  process" -WithoutDot -NoNewLine 
    Show-Message -Warn -Msg "`twhich could start your app as a new process(process would be out of control, recommand for GUI apps)" -WithoutDot
    Show-Message -Notice -Msg "  raw" -WithoutDot -NoNewLine
    Show-Message -Warn -Msg "`t`twhich could start your app in this console(can use 'Ctrl+C' to exit it, recommand for commandline apps)" -WithoutDot
    Show-Message -Notice -Msg "  shim" -WithoutDot -NoNewLine
    Show-Message -Warn -Msg "`twhich could control your shims." -WithoutDot
    Show-Message -Notice -Msg "Usage Example:" -WithoutDot
    Show-Message -Notice -Msg "  - 'run job winhex' or use abbreviations like 'run j hex'" -WithoutDot 
    Show-Message -Notice -Msg "  - 'run process winhex' or use abbreviations like 'run p winh'" -WithoutDot
    Show-Message -Notice -Msg "  if use abbreviations, Run-App would like to find the program smartly." -WithoutDot
    Show-Message -Notice -Msg "  for example, winh would like to start WinHex, or WinHpp and so on; hex would like to start HexEditor or HexViewer and so on." -WithoutDot
    Show-Message -Notice -Msg "  To avoid ambiguity, use the unique pattern to smartly match!" -WithoutDot
    Show-Message -Notice -Msg "  - 'run shim list' would display all the shims you create" -WithoutDot
    Show-Message -Notice -Msg "  - 'run shim rm [ShimName]' would delete the shim, ShimName must be full name" -WithoutDot
    Show-Message -Notice -Msg "  - 'run shim clear' would delete all the shims you create" -WithoutDot
    Show-Message -Notice -Msg "  - 'run shim create' would start a shim creation" -WithoutDot
    Show-Message -Notice -Msg "Configuration: " -WithoutDot
    Show-Message -Notice -Msg "  Your configuration storage folder is $($ENV:HOMEPATH)\Run-App\" -WithoutDot
    Show-Message -Notice -Msg "  - [File].run.ps1`t`t`t`t => your Run-App configuration" -WithoutDot
    Show-Message -Notice -Msg '  |-- [PowerShell.Array]`$BaseDir`t`t => Your Apps Base Dir' -WithoutDot
    Show-Message -Notice -Msg '  |-- [PowerShell.Array]`$BinSearch`t`t => Search binary in these folder' -WithoutDot
    Show-Message -Notice -Msg '  |-- [PowerShell.Array]`$BinExt`t`t => Recognize these extension file as binary' -WithoutDot
    Show-Message -Notice -Msg '  |-- [PowerShell.Hashtable]`$ExtAssociation`t => Definde which program to run the binary with the specified ext' -WithoutDot
    Show-Message -Notice -Msg "  - [Folder]Shims`t`t`t`t => The apps' shims here, you could edit the *.shim file to custom app running environment." -WithoutDot
    Show-Message -Notice -Msg "  |-- [ShimConfig]path`t`t`t => App's binary path" -WithoutDot
    Show-Message -Notice -Msg "  |-- [ShimConfig]args`t`t`t => Commandline args" -WithoutDot
    Show-Message -Notice -Msg "  |-- [ShimConfig]dir`t`t`t => Current directory" -WithoutDot
    Show-Message -Warn -Msg   "  - Shims Configuration Notice:" -WithoutDot
    Show-Message -Warn -Msg   "    - Config must be 'key = value', all value needn't double quote, just use raw string!" -WithoutDot
}
