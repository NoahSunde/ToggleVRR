# Path to the Registry key
$VRRKey = "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences"
$VRRValueName = "DirectXUserGlobalSettings"

# Get the current value of the DirectXUserGlobalSettings string
$currentValue = Get-ItemProperty -Path $VRRKey -Name $VRRValueName

# Extract the VRROptimizeEnable value
$VRROptimizeEnable = ($currentValue.DirectXUserGlobalSettings -split ';' | Where-Object {$_ -match 'VRROptimizeEnable'}) -split '=' | Select-Object -Index 1

# Toggle the VRROptimizeEnable value
if ($VRROptimizeEnable -eq 0) {
  # Enable VRR
  $newValue = $currentValue.DirectXUserGlobalSettings -replace "VRROptimizeEnable=0", "VRROptimizeEnable=1"
  Set-ItemProperty -Path $VRRKey -Name $VRRValueName -Value $newValue
  Write-Host "VRR is now on!"
} else {
  # Disable VRR
  $newValue = $currentValue.DirectXUserGlobalSettings -replace "VRROptimizeEnable=1", "VRROptimizeEnable=0"
  Set-ItemProperty -Path $VRRKey -Name $VRRValueName -Value $newValue
  Write-Host "VRR is now off!"
}

# Display the message for 3 seconds
Start-Sleep -Seconds 3