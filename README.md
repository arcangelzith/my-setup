# Setup

## Ubuntu shell customizations

```bash
curl -o- "https://raw.githubusercontent.com/arcangelzith/my-setup/main/ubuntu/install.sh?t=$(date +%s)" | bash
```

## Windows shell customizations

```powershell
(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/arcangelzith/my-setup/main/windows/install.ps1?t=$((Get-Date).Ticks)").Content | Invoke-Expression
```
