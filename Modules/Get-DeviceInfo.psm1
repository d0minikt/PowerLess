function Get-DeviceInfo() {
  $SystemInfo = Get-WMIObject -Class Win32_ComputerSystem | Select-Object -Property PSComputerName, Manufacturer, Model, Name
  $NetworkAdaptersInfo = Get-NetAdapter | Select-Object -Property Name, InterfaceDescription, Status, MacAddress
  $ProcessorName = (Get-WMIObject -Class Win32_Processor).Name
  $DrivesInfo = Get-WMIObject -Class Win32_LogicalDisk | Select-Object DeviceID, FileSystem, Size, FreeSpace
  $DriveLabels = Get-WMIObject -Class Win32_DiskDrive | Select-Object Model
  $Memory = Get-WmiObject -Class Win32_PhysicalMemory | Select-Object -Property ConfiguredClockSpeed, DataWidth, Speed, PartNumber, Capacity

  return New-Object -TypeName psobject -Property @{
    Hostname        = @(Hostname)
    Username        = $Env:UserName
    System          = $SystemInfo
    NetworkAdapters = $NetworkAdaptersInfo
    Processor       = $ProcessorName
    Drives          = $DrivesInfo
    WinDrive        = $DriveLabels
    Memory          = $Memory
  }
}