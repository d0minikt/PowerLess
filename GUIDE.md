# PowerLess - Guide

A poweruser's guide to powershell.

## Profiles

- [Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-6)

| Name                              | Description                |
| --------------------------------- | -------------------------- |
| `$Profile`                        | Current User, Current Host |
| `$Profile.CurrentUserCurrentHost` | Current User, Current Host |
| `$Profile.CurrentUserAllHosts`    | Current User, All Hosts    |
| `$Profile.AllUsersCurrentHost`    | All Users, Current Host    |
| `$Profile.AllUsersAllHosts`       | All Users, All Hosts       |

Edit a profile:

```powershell
notepad $Profile.CurrentUserAllHosts
```

Reload a profile:

```powershell
. $Profile.CurrentUserAllHosts
```

To run without a profile:

```powershell
powershell -NoProfile
```

## Environmental Variables

- [Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-6)

To display all the local variables:

```powershell
Get-Item -Path Env:*
```

Any of the items can be accessed in your script like so:

```powershell
$Env:<variable-name>
#e.g.
$Env:ComputerName
$Env:WinDir
```

The `Env` is like a C drive, you can even `cd` into it:

```powershell
Set-Location Env:
```

To save changes made to environmental variables, you need to apply the changes in your powershell profile:

```powershell
Add-Content -Path $Profile.CurrentUserAllHosts -Value '$Env:Path = $Env:Path + ";C:\Temp"'
```

If you'd like to see the changes, you need to restart your shell, or run:

```powershell
. $Profile.CurrentUserAllHosts
```

## Automatic Variables

- [Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-6)
  | Name | Description |
  | ------- | ------------------------------------------------------------------------ |
  | `$$` | Last token in the last line received by the session |
  | `$?` | The execution status of the last operation. [boolean]\$Succeded |
  | `$^` | First token in the last line received by the session |
  | `$_` | Same as `$PSItem`. Current object in the pipeline object |
  | `$Args` | Path of the console file (.psc1) that was most recently used |
  | `$ForEach` | Enumerator (not the resulting values) of a ForEach loop |
  | `$Home` | Full path of the user's home directory |
  | `$Host` | Full path of the user's home directory |
  | `PID` | Process identifier (PID) of the process that is hosting the current PowerShell session |
  | `Profile` | Full path of the PowerShell profile for the current user and the current host application|
  | `PSCommandPath` | Full path and file name of the script that is being run |
  | `PSHome` | Full path of the installation directory for PowerShell, typically, `%windir%\System32\PowerShell\v1.0` in Windows systems |
  | `PSScriptRoot` | The directory from which a script is being run |
  | `MyInvocation` | Information about the current command, such as the name, parameters, parameter values, and information about how the command was started, called, or "invoked," such as the name of the script that called the current command. |

## Local Windows Accounts

Requires administrator permisisons.

### Add

```powershell
New-LocalUser "Admin" -Password (ConvertTo-SecureString "Fsociety" -AsPlainText -Force)
Add-LocalGroupMember -Group "Administrators" -Member "Admin"
```

### Remove

```powershell
Remove-LocalUser "Admin"
```
