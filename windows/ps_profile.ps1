Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox


function checkEnv ($tocheck) {
    Get-ChildItem Env:* | Where-Object Name -like "*$tocheck*" | Sort-Object -Property Name
}