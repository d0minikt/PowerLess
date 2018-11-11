# Get the path to add to the list of Powershell module paths
$Parent = (Get-Item $PSScriptRoot).Parent.FullName
Write-Output $Parent

# Add to modules and import whenever a new powershell session is started
Add-Content -Path $Profile.CurrentUserAllHosts -Value ('$Env:PSModulePath = $Env:PSModulePath+";'+$Parent+'";')
Add-Content -Path $Profile.CurrentUserAllHosts -Value "Import-Module PowerLess;"

# Refresh the path so the user doesn't have to restart the session
$ENV:PSModulePath = ($ENV:PSModulePath+";"+$Parent)

try {
  Import-Module PowerLess
  Write-Host "Successfully installed PowerLess script" -f Blue
} finally {
  Write-Error "Couldn't import module. Try following the installation instructions again"
}
