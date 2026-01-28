# RMM Inventory - Device Full Info
# Silent execution / Output only

try {
    $Computer = Get-CimInstance Win32_ComputerSystem
    $CPU      = Get-CimInstance Win32_Processor
    $OS       = Get-CimInstance Win32_OperatingSystem
    $BIOS     = Get-CimInstance Win32_BIOS

    [PSCustomObject]@{
        DeviceName      = $Computer.Name
        Manufacturer    = $Computer.Manufacturer
        Model           = $Computer.Model
        SerialNumber    = $BIOS.SerialNumber
        Processor       = $CPU.Name
        ProcessorSpeed  = "$($CPU.MaxClockSpeed) MHz"
        InstalledRAMGB  = [Math]::Round($Computer.TotalPhysicalMemory / 1GB, 2)
        SystemType      = $Computer.SystemType
        OSArchitecture  = $OS.OSArchitecture
    }
}
catch {
    Write-Output "ERROR: $($_.Exception.Message)"
}
