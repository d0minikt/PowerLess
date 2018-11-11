# PowerLess
A set of useful utility scripts & guides that can be used to help penetration testers and windows powerusers.

## Installation
To get started, clone this repo:
```powershell
git clone https://github.com/d0minikt/PowerLess
```
To install the modules globally, simply run the `Install` script:
```powershell
.\PowerLess\Install.ps1
```
All done! Now you can use the modules whenever you open a new powershell terminal.

## Updating
In order to update **PowerLess**, all you need to do is pull the newest version of it 
from GitHub using `git pull` if you're in the project's directory, or `git clone` and `.\Install.ps1`
it again, it will replace the old one with the new one for you.


## [Guide](GUIDE.md)
You can access the powershell guide [here](GUIDE.md).

### Coming soon
 - [ ] Introduction to powershell

## Modules

### `Extract`
The `Extract.ps1` script extracts the data about a particular device. It outputs the result in the drive that contains a file named `data.json` in its root. The extraction process can:
 - [x] Extract wifi passwords
 - [x] Extract device information
 - [x] Extract Chrome bookmarks & history

### `KeyLogger`
This keylogger is very simple yet not detected by Windows 10 real time protection, nor any anti viruses (at least at the time of writing this). It allows you to specify the output path, and if not specified, it saves the output in the window temporary file directory. You can quickly open it from powershell with `explorer $Env:Temp`. The script will run in the background as soon as executed.
To start the keylogger:
```powershell
KeyLogger
# or
log
```
The best way to stop it is to kill all the powershell processes:
```powershell
Stop-Process -Name Powershell
```

### `Invoke-AsAdmin`
Used to elevate the script file, a script, or the powershell terminal to admin permissions. Also has an alias to `sudo`.
#### Usage
File:
```powershell
Invoke-AsAdmin -File ".\Some-Script-That-Requires-Admin-Permisisons.ps1"
```
Inside of a file itself:
```powershell
#Requires -Modules PowerLess

if (!(Test-Admin)) {
  Invoke-AsAdmin -File $PSCommandPath
}
else {
  # Do stuff here
}
```
A script snippet:
```powershell
Invoke-AsAdmin "Test-Admin;Read-Host"
#or
sudo "Test-Admin;Read-Host"
```
An elevated terminal shell:
```powershell
Invoke-AsAdmin
#or
sudo
```

### Coming soon
 - [ ] Add accounts to windows
 - [ ] Gain local offline backdoor to a shell through "ease of access" - including a guide on how to do that with just a windows 10 usb stick installer

