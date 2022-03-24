# Shell customizations based on https://github.com/arcangelzith/my-setup/

Set-Alias ll "ls"
Set-Alias la "ls"
Set-Alias l "ls"

function X () {
    exit
}

Set-Alias grep "C:\Program Files\Git\usr\bin\grep.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"

Import-Module Terminal-Icons
Import-Module Oh-My-Posh

function OMP () {
    oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\arcan-ps.omp.json | Invoke-Expression
}

OMP

function Wsl-Shutdown {
    # TODO: No apagar las distros cuyo nombre contengan la palabra docker

    $error.clear()

    wsl --list --running

    if ($?) {
        Write-Host "Apagando ..." -ForegroundColor Cyan

        wsl --shutdown
    }
}

Set-Alias wsloff "Wsl-Shutdown"

function Goto-Repo {
    cd E:\Repo\
}

Set-Alias repo Goto-Repo
Set-Alias repos Goto-Repo

function XRepo {
    $repoPath = "E:\Repo"
    Option-Menu "Repositorios disponibles" @(
        "Privado ($repoPath\prv\)", {
            cd "$repoPath\prv\"
        },
        "Público ($repoPath\pub\)", {
            cd "$repoPath\pub\"
        },
        "Base    ($repoPath\)", {
            cd "$repoPath\"
        }
    )
}

function Beep () {
    [console]::beep(1000,400) && [console]::beep(1500,400) && [console]::beep(2000,400)
}

function Option-Menu ($title, $items) {
    Write-Host ""
    Write-Host " $title" -ForegroundColor Cyan
    Write-Host ("¯" * ($title.length + 2))
  
    $menuCount = $items.length / 2
  
    $commands = @("")
  
    for ($i = 0; $i -lt $menuCount; $i++) {
        $labelIndex = $i * 2
        $labelText  = $items[$labelIndex]
        $labelId    = $i + 1
        $labelIdPad = "$labelId".PadLeft("$menuCount".length, ' ')

        $commands += $items[$labelIndex + 1]

        Write-Host " [$labelIdPad]" -NoNewline -ForegroundColor Yellow
        Write-Host " $labelText"
    }
  
    Write-Host " [" -NoNewline -ForegroundColor Yellow
    Write-Host "".PadLeft("$menuCount".length, ' ') -NoNewline
    Write-Host "] Salir" -ForegroundColor Yellow
    Write-Host ""
  
    $choice = Read-Host -Prompt " Selección"
  
    if (!($choice -eq "" -or $choice -eq $null) ) {
        Invoke-Command -ScriptBlock $commands[$choice]
    }
}
