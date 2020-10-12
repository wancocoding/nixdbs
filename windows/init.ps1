# ============ Configuration ============
$enableChoco = 1
$enableScoop = 1



# ============ PowerShell Basic Setting ============

Set-ExecutionPolicy RemoteSigned

# ============ Install packages ============

# install oh-my-posh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# Install Chocolatey
function InstallChocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
if ($enableChoco -eq 1) {
	InstallChocolatey
}

# Install Scoop
if ($enableScoop -eq 1) {
	$env:SCOOP = 'D:\develop\Scoop'
	[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
	$env:SCOOP_GLOBAL = 'D:\develop\ScoopApps'
	[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
	Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}



# ============ PowerShell Profile ============

$psLocalPath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (Test-Path -path $psLocalPath) {
	Remove-Item -Path $psLocalPath
}
# mklink /d $vimfilesPath .\vimfiles.symlink
New-Item -Path $psLocalPath -ItemType SymbolicLink -Value .\ps_profile.ps1


# ============ Install Applications ============

# choco install fluent-terminal


scoop install sudo
# sudo scoop install 7zip git openssh --global
# scoop install aria2 curl grep sed less touch
# scoop install python ruby go perl

winget install --id=Microsoft.WindowsTerminal -e
# scoop install windows-terminal


# ============ Make link of vimrc and vimfiles ============

# ------ vimrc
$vimrcFilePath = "$HOME\_vimrc"
if(Test-Path -path $vimrcFilePath){
	Remove-Item -Path $vimrcFilePath
}
# mklink $vimrcFilePath .\_vimrc.symlink
New-Item -Path $vimrcFilePath -ItemType SymbolicLink -Value .\_vimrc.symlink

# ------ vimfiles
$vimfilesPath = "$HOME\vimfiles"
if(Test-Path -path $vimfilesPath){
	Remove-Item -Path $vimfilesPath
}
# mklink /d $vimfilesPath .\vimfiles.symlink
New-Item -Path $vimfilesPath -ItemType SymbolicLink -Value .\vimfiles.symlink



