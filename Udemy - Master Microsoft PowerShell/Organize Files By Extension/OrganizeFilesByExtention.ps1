param([string]$source="D:\Workspace\GitHub\PowerShell\Udemy - Master Microsoft PowerShell\Organize Files By Extension\files", [string]$destination="D:\Workspace\GitHub\PowerShell\Udemy - Master Microsoft PowerShell\Organize Files By Extension\files")
Write-Host
function Check-Folder([string]$path, [switch]$create){
    $exists = Test-Path $path
    if (!$exists -and $create) {
        mkdir $path | Out-Null
        $exists = Test-Path $path
    }
    return $exists
}

function Display-FolderStats([string]$path){
    $files = Get-ChildItem $path -Recurse | Where-Object {!$_.PSIsContainer -and $_.FullName -notlike "*ps1*"}
    $totals = $files | Measure-Object -Property length -sum
    $stats = "" | Select-Object path, count, size
    $stats.path = $path
    $stats.count = $totals.Count
    $stats.size = [math]::Round($totals.sum/1MB,2)
    return $stats
}

$sourceexists = Check-Folder $source

if (!$sourceexists){
    Write-Host "The source directory is not found. Script can not continue."
    Exit
}

$destinationexists = Check-Folder $destination -create

if (!$destinationexists){
    Write-Host "The destination directory is not found. Script can not continue."
    Exit
}

$files = Get-ChildItem $source -Recurse | Where-Object {!$_.PSIsContainer}

foreach ($file in $files){
    $ext = $file.Extension.Replace(".", "")
    $extdestdir = "$destination\$ext"
    $extdestdirexists = Check-Folder $extdestdir -create

    if (!$extdestdirexists){
        Write-Host "The source destination ($extdestdir) can't be created."
        Exit
    }

    Move-Item $file.FullName $extdestdir
}

$dirs = Get-ChildItem $destination | Where-Object {$_.PSIsContainer}

$allstats = @()
foreach($dir in $dirs){
    $allstats += Display-FolderStats $dir.FullName
}

$allstats | sort size -Descending
