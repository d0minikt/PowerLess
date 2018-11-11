# PowerLess - Guide

A poweruser's guide to powershell.

## Profiles

- [Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-6)

|Name |	Description|
|---|---|
|$Profile |	Current User, Current Host|
|$Profile.CurrentUserCurrentHost |	Current User, Current Host|
|$Profile.CurrentUserAllHosts |	Current User, All Hosts|
|$Profile.AllUsersCurrentHost |	All Users, Current Host|
|$Profile.AllUsersAllHosts |	All Users, All Hosts|


Edit a profile:
```powershell
notepad $Profile.CurrentUserAllHosts
```
Reload a profile:
```powershell
. $Profile.CurrentUserAllHosts
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
