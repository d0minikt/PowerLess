# Get the path to add to the list of Powershell module paths
$ThisModule = (Get-Item $PSScriptRoot).FullName
$PSModulePath = ($Env:PSModulePath -split ";")[0]

# Add to modules and import whenever a new powershell session is started
Write-Host "Moving the PowerLess folder to $PSModulePath"
Move-Item $ThisModule $PSModulePath -ErrorAction SilentlyContinue
Add-Content -Path $Profile -Value "Import-Module PowerLess;"

# Import module so the user doesn't have to restart the session
try {
  Import-Module PowerLess
  Write-Host "Successfully installed the PowerLess script" -f Blue
} Catch {
  Write-Error "Couldn't import module. Try following the installation instructions again"
}
