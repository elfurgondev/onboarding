Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$global:allowClose = $false

# Obtener datos reales (solo lectura)
$computerName = $env:COMPUTERNAME
$ramGB = [Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        WindowStyle="None"
        WindowState="Maximized"
        ResizeMode="NoResize"
        Background="#0078D7"
        Topmost="True">
    <Grid Margin="120">
        <StackPanel VerticalAlignment="Top">

            <TextBlock Text=":("
                       FontSize="150"
                       Foreground="White"
                       Margin="0,40,0,20"/>

            <TextBlock FontSize="34"
                       Foreground="White"
                       Margin="0,0,0,20">
Automatic Repair is diagnosing your PC
            </TextBlock>

            <TextBlock Name="MachineInfo"
                       FontSize="18"
                       Foreground="White"
                       Margin="0,0,0,10"/>

            <TextBlock Name="ProgressText"
                       FontSize="22"
                       Foreground="White"
                       Margin="0,20,0,10"/>

            <!-- Barra blanca pequeña -->
            <Border Background="White"
                    Height="8"
                    Width="400"
                    CornerRadius="4"
                    Margin="0,10,0,20">
                <Border Name="ProgressBarFill"
                        Background="#CFE8FF"
                        Width="0"
                        CornerRadius="4"/>
            </Border>

            <TextBlock Name="PercentText"
                       FontSize="20"
                       Foreground="White"
                       Margin="0,0,0,30"/>

            <TextBlock Name="DiskScan"
                       FontSize="18"
                       Foreground="White"
                       Margin="0,10,0,20"/>

            <!-- Consola blanca pequeña -->
            <Border Background="White"
                    Padding="6"
                    Width="300"
                    CornerRadius="4">
                <TextBox Name="InputBox"
                         BorderThickness="0"
                         FontSize="14"
                         Background="White"
                         Foreground="Black"/>
            </Border>

        </StackPanel>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$machineInfo = $window.FindName("MachineInfo")
$progressText = $window.FindName("ProgressText")
$percentText = $window.FindName("PercentText")
$progressFill = $window.FindName("ProgressBarFill")
$diskScan = $window.FindName("DiskScan")
$inputBox = $window.FindName("InputBox")

$machineInfo.Text = "Machine: $computerName | Installed RAM: $ramGB GB"

$messages = @(
    "Scanning system files...",
    "Validating system integrity...",
    "Checking disk for errors...",
    "Repairing corrupted sectors...",
    "Rebuilding boot configuration data..."
)

# --- LÓGICA DE PROGRESO EXTREMADAMENTE LENTO ---
$startTime = Get-Date

$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(1)

$timer.Add_Tick({

    $elapsedSeconds = (New-TimeSpan -Start $startTime -End (Get-Date)).TotalSeconds

    # 1800 segundos = 1% (30 minutos por porcentaje)
    $percent = [Math]::Floor($elapsedSeconds / 1800)

    if ($percent -gt 100) {
        $percent = 0
        $startTime = Get-Date
    }

    $percentText.Text = "$percent% complete"
    $progressFill.Width = 4 * $percent

    # Cambiar mensaje cada 5%
    if ($percent % 5 -eq 0) {
        $progressText.Text = $messages[(Get-Random -Minimum 0 -Maximum $messages.Count)]
    }

    # Simulación de análisis de disco
    $sector = Get-Random -Minimum 10000 -Maximum 900000
    $diskScan.Text = "Analyzing disk sector: $sector"
})

$timer.Start()

# Control de cierre
$window.Add_Closing({
    if (-not $global:allowClose) {
        $_.Cancel = $true
    }
})

# Safe exit
$inputBox.Add_KeyDown({
    if ($_.Key -eq "Return") {
        if ($inputBox.Text -eq "exittt") {
            $global:allowClose = $true
            $timer.Stop()
            $window.Close()
        } else {
            $inputBox.Clear()
        }
    }
})

$window.ShowDialog()