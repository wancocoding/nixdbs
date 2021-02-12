# ============ Configuration ============
$enableScoop = 1
$userLocalBin = "d:\develop\env\bin"
$scoopUserPath = "D:\develop\Scoop"
$scoopGlobalPath = "D:\develop\ScoopApps"
# your go custom path for your project
$userGoPath = 'd:\develop\workspace\go'
$softsHome = "d:\softs"


# $vimDownloadUrl = "http://files.static.tiqiua.com/cocoding/dl/windows/gvim_8.2.1838_x64_signed.zip"
# $vimHome = $softsHome + "\vim\vim82"


# ============ PowerShell Basic Setting ============

Set-ExecutionPolicy RemoteSigned

# ============ Install packages ============

# # install oh-my-posh
# Install-Module posh-git -Scope CurrentUser
# Install-Module oh-my-posh -Scope CurrentUser

# Install Chocolatey
function InstallChocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
if ($enableChoco -eq 1) {
	InstallChocolatey
}

# Install Scoop
if ($enableScoop -eq 1) {
	$env:SCOOP = $scoopUserPath
	[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
	$env:SCOOP_GLOBAL = $scoopGlobalPath
	[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
	Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}



# ============ PowerShell Profile ============

# $psLocalPath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
# if (Test-Path -path $psLocalPath) {
# 	Remove-Item -Path $psLocalPath
# }
# # mklink /d $vimfilesPath .\vimfiles.symlink
# New-Item -Path $psLocalPath -ItemType SymbolicLink -Value .\ps_profile.ps1


# ============ Install Applications ============

scoop bucket add java
scoop bucket add versions
scoop bucket add extras

scoop install sudo
sudo scoop install 7zip git vim

scoop install go
[Environment]::SetEnvironmentVariable("GOPATH", $userGoPath, 'User')

scoop install nodejs-lts
# scoop install oraclejdk14

scoop install universal-ctags
# scoop install perl lua

scoop install cmake ninja

# scoop install aria2 curl grep sed less touch
# scoop install python ruby go perl


# python
# winget install python --version $wingetPythonVersion

# WindowsTerminal
winget install --id=Microsoft.WindowsTerminal -e
# scoop install windows-terminal








# ==========================
# $Env:Path += ";c:\temp"
# Set-Item -Path Env:Path -Value ($Env:Path + ";$userLocalBin")
$oldUserPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newUserPath = $oldUserPath + ";$userLocalBin"
[Environment]::SetEnvironmentVariable("Path", $newUserPath, 'User')


# ================================= call vim script

.\scripts\vim.ps1 -vimHome $vimHome -softsHome $softsHome -vimDownloadUrl $vimDownloadUrl