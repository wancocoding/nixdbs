# install vim
param(
    [string]$vimHome,
    [string]$softsHome,
    [string]$vimDownloadUrl
)

Write-Host "=============== Install Vim Start ==============="

# Write-Host "Download vim..."

# Invoke-WebRequest -Uri $vimDownloadUrl -OutFile vimtemp.zip

# Write-Host "Extract vim..."
# Expand-Archive -Path vimtemp.zip -DestinationPath $softsHome -Force
# Remove-Item -Path vimtemp.zip


# # ============ Make link of vimrc and vimfiles ============
# Write-Host "Delete old vimrc and vimfiles..."
# # remove default vimrc if install from scoop
# if (Test-Path -path "$scoopUserPath\vim\current\_gvimrc") {
#     Remove-Item -Path "$scoopUserPath\vim\current\_gvimrc" -Force
# }
# if (Test-Path -path "$scoopUserPath\vim\current\_vimrc") {
#     Remove-Item -Path "$scoopUserPath\vim\current\_gvimrc" -Force
# }
# if (Test-Path -path "$scoopUserPath\vim\current\gvimrc") {
#     Remove-Item -Path "$scoopUserPath\vim\current\_gvimrc" -Force
# }
# if (Test-Path -path "$scoopUserPath\vim\current\vimrc") {
#     Remove-Item -Path "$scoopUserPath\vim\current\_gvimrc" -Force
# }

Write-Host "Link vimfiles and vimrc"
# ------ vimrc
$vimrcFilePath = "$HOME\_vimrc"
if (Test-Path -path $vimrcFilePath) {
    Remove-Item -Path $vimrcFilePath -Recurse
}
# mklink $vimrcFilePath .\_vimrc.symlink
New-Item -Path $vimrcFilePath -ItemType SymbolicLink -Value .\_vimrc.symlink

# ------ vimfiles
$vimfilesPath = "$HOME\vimfiles"
if (Test-Path -path $vimfilesPath) {
    # Remove-Item -Recurse -Force $vimfilesPath  # not work
    cmd /c "rmdir $HOME\vimfiles"
}
# mklink /d $vimfilesPath .\vimfiles.symlink
New-Item -Path $vimfilesPath -ItemType SymbolicLink -Value .\vimfiles.symlink

Write-Host "Update envrionment..."
# Path
$oldUserPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newUserPath = $oldUserPath + ";$vimHome"
[Environment]::SetEnvironmentVariable("Path", $newUserPath, 'User')


Write-Host "=============== Install Vim Finish ==============="