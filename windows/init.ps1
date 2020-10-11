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



# ============ PowerShell Basic Setting ============

Set-ExecutionPolicy RemoteSigned

# ============ Install packages ============

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# ============ PowerShell Profile ============

$psLocalPath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if(Test-Path -path $psLocalPath){
	Remove-Item -Path $psLocalPath
}
# mklink /d $vimfilesPath .\vimfiles.symlink
New-Item -Path $psLocalPath -ItemType SymbolicLink -Value .\ps_profile.ps1