# Descargar el archivo arcan.ps1 en $PROFILE
# Instalar WSL y la distro predeterminada

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/arcangelzith/my-setup/main/windows/arcan.ps1?t=$((Get-Date).Ticks)" -OutFile "$(Split-Path $PROFILE)\arcan.ps1"