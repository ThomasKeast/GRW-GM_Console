<#
.SYNOPSIS
    Tom Clancy's Ghost Recon Wildlands: Ghost Mode Console
.DESCRIPTION
    Help key: 031_238xvCC2193 (EuXe)
.LINK
    www.github.com/ThomasKeast
#>
Clear-Host


Write-Output "Tom Clancy's Ghost Recon Wildlands: Ghost Mode Console"
Write-Output "Coded by Thomas Keast"
Write-Output "Powered by Team EuXe"
Write-Output ""
Start-Sleep -s 2

$UserCurrent = $env:UserName
$LFullName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$LComputerName = $env:ComputerName

$UplayHome = [System.IO.File]::Exists("$PSScriptRoot/uPlayEnvironment.env")
$path = "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames"

if ($UplayHome -eq 'True') {
    Write-Output "Environment File found!"
    $account_assets = gc "$PSScriptRoot/uPlayEnvironment.env"
    if (!(Test-Path "$PSScriptRoot/GRWGM Backup/")) {
        Write-Output "Backup folder not found, created in root."
        New-Item -ItemType Directory -Force -Path "$PSScriptRoot/GRWGM Backup/"
    } Else {
        $void = 'True'
    }
} Else {
    Write-Output "File not found, please edit the file and follow the following guide:"
    Start-Sleep -s 1
    Write-Output "1) Edit 'uPlayEnvironment.env' (Inside this directory) with notepad..."
    Start-Sleep -s 1
    Write-Output "2) Navigate to your save games folder: C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames"
    Start-Sleep -s 1
    Write-Output "3) Navigate to your account's folder (e.g 00vdj34-0vvv-0ddd-0aaa) and then 3559 (Steam version) or 1771 (uPlay)"
    Start-Sleep -s 1
    Write-Output "4) Copy your account id with your version into 'uPlayEnvironment.env' without the slashes --> copy '00vdj34-0vvv-0ddd-0aaa\3559' into the file (Replacing the example ID with your own)."
    Start-Sleep -s 1
    Write-Output "5) Save the file, open the game, re-open the console.. More information can be found on the GutHub page"
    Write-Output "The file has now been created for you"
    New-Item -Path "$PSScriptRoot/uPlayEnvironment.env" -ItemType File
    Read-Host 'Please press enter to close...'
    exit
}

while($true) {
    $LiveConsole = Read-Host "[GRWGM]$LFullName\admin# "
    if ($LiveConsole -eq 'help' -Or $LiveConsole -eq 'Help') {
        Write-Output "Help manual for GRW Ghost Mode Console: version 0.1"
        Write-Output "This tool was made to automate saving your Ghost Mode progress"
        Write-Output "By Thomas Keast"
        Write-Output "==================================="
        Write-Output "'help' - Show this message"
        Write-Output "'help [command]' - Get more help per command."
        Write-Output "'save' - Save your current Ghost Mode progress."
        Write-Output "'load' - Load your progress from backups."
        Write-Output "'exit' - Self explanatory, just quits this program."
        Write-Output ""
    } if ($LiveConsole -eq 'help save' -Or $LiveConsole -eq 'Help Save') {
        Write-Output "Save your current progress in ghosts mode by backing up externally"
        Write-Output "This command is easy to execute and has no risk of removing your current progress."
        Write-Output "Currently the backup will be stored with your location of this script (Advise you keep it in a folder together)."
        Write-Output "Before saving, you must press Escape (or start if you're using a controller) before saving since the game will autosave."
        Write-Output "The program will wait 5 seconds to ensure the autosaving has been completed" 
    } if ($LiveConsole -eq 'help load' -Or $LiveConsole -eq 'Help Load') {
        Write-Output "Load your pogress back if you die or you lose your data."
        Write-Output "If you die or lose your data:"
        Write-Output "1) Create a new Ghost Mode game, skip though the character creation until you spawn in for the first mission."
        Write-Output "2) Once spawned in, press Escape and then use the 'load' command and go through the prompts."
        Write-Output "3) Once the load has been completed, ALT+F4 (console should do this for you)"
        Write-Output "4) Re-launch the game and your save will be present."
        Write-Output ""
        Write-Output "This command can cause loss of data if used incorrectly so please proceed carefully!"
        Write-Output "This command will only work if you have made a backup using this console and does not do this automatically."  
    } if ($LiveConsole -eq 'save' -Or $LiveConsole -eq 'Save') {
        Write-Output "Prepairing to save and backup the game..."
        Read-Host "Please press enter when you have paused the game..."
        Start-Sleep -s 5
        Copy-Item -Path "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames\$account_assets\*" -Destination "$PSScriptRoot\GRWGM Backup\" -Force
        $time = (get-date).ToString('T')
        Write-Output "[GRWGM] $time : Save Action completed!"
    } if ($LiveConsole -eq 'save' -Or $LiveConsole -eq 'Save') {
        Write-Output "Please be aware that this option is disruptive and will overwrite any current save progress!"
        $confirm_load = Read-Host "Are you happy to proceed? [y/n]- "
        if ($confirm_load -eq 'y' -Or $confirm_load -eq 'Y') {
            Write-Output "Prepairing to load the game back..."
            Read-Host "Please press enter when you made a new game and have paused the game..."
            Start-Sleep -s 5
            Copy-Item -Path "$PSScriptRoot\GRWGM Backup\" -Destination "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames\$account_assets\*" -Force
            $time = (get-date).ToString('T')
            Write-Output "[GRWGM] $time : Load Action completed!"
            Write-Output "Please Alt+F4 and re-launch the game..."
            Start-Sleep -s 5
        } Else {
            $void = 'True'
            Write-Output "Load function has been stopped..."
        }
    }
}
