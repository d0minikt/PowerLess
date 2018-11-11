function Get-WiFiPasswords() {
  $WirelessSSIDs = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"
  $WifiInfo = foreach ($SSID in $WirelessSSIDs) {
    $Password = (netsh wlan show profiles name=$SSID key=clear | Select-String 'Key Content') -replace ".*:\s+"
    if (-not($Password)) {
      $Password = ""
    }
    New-Object -TypeName psobject -Property @{"SSID" = $SSID; "Password" = $Password}
  }
  return $WifiInfo
}