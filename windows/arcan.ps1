# Shell customizations based on https://github.com/arcangelzith/my-setup/

$HOME_REPO = "E:\Repo"

Import-Module Terminal-Icons
Import-Module Oh-My-Posh

function OMP () {
    oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\arcan-ps.omp.json | Invoke-Expression
}

OMP

function Stop-RunningWsl {
    $error.clear()

    wsl --list --running

    if ($?) {
        Write-Host "Apagando ..." -ForegroundColor Cyan

        wsl --shutdown
    }
}

# Repos

function gitlog {
    git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"
}

function Get-GitChildItem ($Path = ".\", $Depth = 1) {
    $Path = Convert-Path $Path

    Write-Output ""
    Write-Output "  Directory: $Path"

    $yellow = "`e[33m"
    $blue   = "`e[34m"
    $reset  = "`e[0m";

    $cwd = Get-Location

    Get-ChildItem -path $Path -Depth $Depth -Hidden -filter .git -Recurse -Directory -ErrorAction SilentlyContinue | 
    Select-Object `
    @{
        Name = "Repository";
        Expression = {
            "$(Convert-Path $_.PSParentPath)".Replace($cwd, ".")
        }
    },
    @{
        Name = "Branch";
        Expression = {
            Push-Location #save current location
            Set-Location -Path (Convert-Path -path ($_.psparentPath)) #change location to the repository

            "$yellow$((git branch).where({$_ -match "\*"}).Substring(2))$reset" #get current branch with out the leading asterisk
        }
    },
    @{
        Name = "LastCommiter";
        Expression = {
            git log --format="%an" -1
        }
    },
    @{
        Name = "LastCommit";
        Expression = {
            git log --format="$blue%ar$reset" -1
        }
    },
    @{
        Name = "Message";
        Expression = {
            git log --format="%s" -1

            Pop-Location #change back to original location
        }
    } | Format-Table
}

# End Repos

# Generic Functions

function Show-Menu ($title, $items) {
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
  
    if (!($choice -eq "" -or $null -eq $choice) ) {
        Invoke-Command -ScriptBlock $commands[$choice]
    }
}

function Beep {
    [console]::beep(1000,400) && [console]::beep(1500,400) && [console]::beep(2000,400)
}

function X {
    exit
}

# End Generic Functions

# Goto

function Set-RepoLocation {
    Set-Location $HOME_REPO
}

function Select-Repo {
    Show-Menu "Repositorios disponibles" @(
        "Privado ($HOME_REPO\prv\)", {
            Set-Location "$HOME_REPO\prv\"
        },
        "Público ($HOME_REPO\pub\)", {
            Set-Location "$HOME_REPO\pub\"
        },
        "Base    ($HOME_REPO\)", {
            Set-Location "$HOME_REPO\"
        }
    )
}

# End Goto

# Aliases

Set-Alias wsloff "Stop-RunningWsl"

Set-Alias repo  "Set-RepoLocation"
Set-Alias repos "Set-RepoLocation"
Set-Alias xrepo "Select-Repo"
Set-Alias frepo "Get-GitChildItem"

Set-Alias ll "ls"
Set-Alias la "ls"
Set-Alias l  "ls"

$private:git_dir = "$((Get-Command git).Source | Split-Path | Split-Path)" 2> $null

if ($git_dir -ne "") {
    $private:git_bash_commands = "grep", "less"

    foreach ($private:git_bash_command in $git_bash_commands) {
        if (Test-Path -Path "$git_dir\usr\bin\$git_bash_command.exe") {
            Set-Alias $git_bash_command "$git_dir\usr\bin\$git_bash_command.exe"
        }
    }

    Remove-Variable git_bash_commands
    Remove-Variable git_bash_command
}

Remove-Variable git_dir

Get-Command docker-compose 2>&1 > $null

if ($?) {
    Set-Alias dc "docker-compose"
}

# End Aliases
