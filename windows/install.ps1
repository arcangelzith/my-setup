# Instalar WSL y la distro predeterminada

# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Usar el nombre de la carpeta actual del usuario como el nombre del perdil .ps1

$user_pwsh_dir="$(Split-Path $PROFILE)"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/arcangelzith/my-setup/main/windows/arcan.ps1?t=$((Get-Date).Ticks)" -OutFile "$user_pwsh_dir\arcan.ps1"

# Agregar importación a arcan.ps1 solo si no está importado antes

$userps1Imports="
if (Test-Path -Path ""$user_pwsh_dir\arcan.ps1"") {
    . ""$user_pwsh_dir\arcan.ps1""
}"

if (Test-Path -Path $PROFILE) {
    if ( -not(Select-String -Path $PROFILE -Pattern "\arcan.ps1" -SimpleMatch -Quiet) ) {
        echo $userps1Imports >> $PROFILE
    }
} else {
    echo $userps1Imports > $PROFILE
}

Remove-Variable user_pwsh_dir
Remove-Variable userps1Imports
