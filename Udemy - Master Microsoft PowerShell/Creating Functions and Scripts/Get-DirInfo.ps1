#parameters
param([string]$dir="C:\")

#functions
function Get-DirInfo($dir) {
    $results = Get-ChildItem $dir -Recurse | Measure-Object -Property Length -Sum
    $results = [System.Math]::Round(($results).sum/1GB, 2)
    return "There is $results GB of used space in this folder"
}

#main processing
Get-DirInfo $dir