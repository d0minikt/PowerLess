function Test-Admin() {
  $User = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
  return $User.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-AsAdmin() {
  Param(
    [Parameter(Mandatory = $true, ParameterSetName = "File")]
    [String]
    $File,
    [Parameter(Mandatory = $false, Position = 0, ParameterSetName = "Script")]
    [String]
    $Script
  )

  if (!(Test-Admin)) {
    if ($File) {
      Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$File`"" -Verb RunAs
    }
    elseif ($Script) {
      Start-Process powershell $Script -Verb RunAs
    }
    else {
      Start-Process powershell powershell -Verb RunAs
    }
  }
}

Set-Alias sudo Invoke-AsAdmin

Export-ModuleMember -Function * -Alias *