## Get all files started by text and unifies into a new files called all.txt
Get-Content text* | Set-Content all.txt

## Get content from multiple files and remove duplicated and blank lines
$hash = @{}
$FileName = "unified_files.txt"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}
Get-Content *.txt | ? {$_.trim() -ne "" } | %{if($hash.$_ -eq $null) { $_ }; $hash.$_ = 1} > $FileName
