# RunApp

## What is this 

This is a Fast, powerful, smart, and highly customizable terminal app launcher.

## How to use

### Install

You can install it via Powershell `Install-Module`: 

```powershell
PS> Install-Module -Name RunApp
```

Then add `Import-Module RunApp` to your Powershell profile.

Or you could download this source, and import module:

```powershell
PS> Import-Module RunApp.psd1
```

### Usage

#### Profile

You need to edit your profile first, the template profile is :

```powershel
$BaseDir = ,'C:\tools'
$BinSearch = ,'.','bin'
$BinExt = ,'exe','bat','jar','py'
$ExtAssociation = @{
    'jar' = 'java.exe';
    'py' = 'python.exe';
}
```

Type `run help` or `run h` to view the help document.

#### Run As Job

which could start your app as powershell job(output capture supproted, but would die if powershell exit)

Example:

```powershell
PS> run job burp
PS> run j burp
PS> runj burp
```

#### Run as New Process

which could start your app as a new process(process would be out of control, recommand for GUI apps)

Example:

```powershell
PS> run process burp
PS> run p burp
PS> runp burp
```

#### Run as Commandline

which could start your app in this console(can use 'Ctrl+C' to exit it, recommand for commandline apps)

Example:

```powershell
PS> run raw burp
PS> run r burp
PS> runr burp
```

#### Shims

RunApp use shim to control the app, shim support var:

```conf
path = {0}
args = {1}
dir = {2}
```

For example, you if want to create a shim of `java -jar $Args`, which start at `C:\Java`, the shim conf is :

```conf
path = java
args = -jar
dir = C:\Java
```

You could use `run shim list` to list the shim creation.

You could use `run shim rm ShimName` to remove a shim.

You could use `run shim clear` to remove all shim.

You could use `run shim create` to create a self-config shim.

View help document to see detail.

### Abbreviations

Yes, RunApp support abbreviations anywhere, for example, `run help` could view the help document, but you could use `run h`, `run he` or `run hel`, it's same as `run help`.

For app, `runr ja` could instead of `runr java`.

To avoid ambiguity, you need type more character, for example, `run shim clear` and `run shim create`, if you type `run s c`, it could not detect which operation is correct, so add a character here, type `run s cl` or `run s cr`.