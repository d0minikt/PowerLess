# PowerLess - Guide

A poweruser's guide to powershell.

## Local Windows Accounts

Requires administrator permisisons.

### Add

To add a new admin windows account:

```powershell
New-LocalUser "Admin" -Password (ConvertTo-SecureString "Fsociety" -AsPlainText -Force)
Add-LocalGroupMember -Group "Administrators" -Member "Admin"
```

### Remove

To remove a local windows account, simply:

```powershell
Remove-LocalUser "Admin"
```
