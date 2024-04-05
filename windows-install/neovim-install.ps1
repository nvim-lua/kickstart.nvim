# Neovim installation script
$NvimConfigRepo = "https://github.com/kontr0x/my-kickstart.nvim.git"

## Install git and neovim via winget
winget install -e --id Git.Git
winget install -e --id Neovim.Neovim

$NvimConfigPath = (Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim")
New-Item -ItemType Directory -Force -Path $NvimConfigPath

if((Get-ChildItem $NvimConfigPath -force | Select-Object -First 1 | Measure-Object).Count -eq 0){
    Write-Host "Cloning the repo" $NvimConfigRepo "into" $NvimConfigPath "!"
    Start-Process -FilePath "C:\Program Files\Git\bin\git.exe" -ArgumentList "clone $NvimConfigRepo $NvimConfigPath" -Wait -NoNewWindow
}else{
    Write-Host "Directory not empty, assume that the repo is already cloned. Trying to update repo!"
    Start-Process -FilePath "C:\Program Files\Git\bin\git.exe" -ArgumentList "pull" -Wait -NoNewWindow
}

## Adding powershell aliases for nvim
New-Item -ItemType File -Path $profile

$NvimPowershellAliases = @"
`n# NeoVim aliases for powershell
Set-Alias -Name nvim -Value "C:\Program Files\Neovim\bin\nvim.exe"
Set-Alias -Name vim -Value nvim 
Set-Alias -Name vi -Value nvim
"@

$NvimPowershellAliases | Add-Content -Path $profile
