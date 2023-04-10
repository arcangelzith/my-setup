# Instalar WSL y la distro predeterminada

# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Usar el nombre de la carpeta actual del usuario como el nombre del perdil .ps1

$myrepo="https://raw.githubusercontent.com/arcangelzith/my-setup/main"
$user_pwsh_dir="$(Split-Path $PROFILE)"

Invoke-WebRequest -Uri "$myrepo/windows/arcan.ps1?t=$((Get-Date).Ticks)" -OutFile "$user_pwsh_dir\arcan.ps1"

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

Import-Module Oh-My-Posh

Invoke-WebRequest -Uri "$myrepo/Oh-My-Posh/arcan-ps.omp.json?t=$((Get-Date).Ticks)" -OutFile "$env:POSH_THEMES_PATH\arcan-ps.omp.json"
Invoke-WebRequest -Uri "$myrepo/Oh-My-Posh/arcan-sh.omp.json?t=$((Get-Date).Ticks)" -OutFile "$env:POSH_THEMES_PATH\arcan-sh.omp.json"

Remove-Variable myrepo
Remove-Variable user_pwsh_dir
Remove-Variable userps1Imports
