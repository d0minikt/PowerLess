# PowerLess - Guide

A poweruser's guide to powershell.

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
