Clear-Host

## Open Excel
##Invoke-Expression .\Census1000.csv

$names = Import-Csv .\Census1000.csv
##($names | sort -Property pcthispanic -descending)[0].name

##$names | sort -Property pcthispanic -descending | select -first 1 | select name

$names | sort -Property pcthispanic -descending | select -first 10 | Format-Table -property name, pcthispanic

##$names | foreach{if($_.pcthispanic -gt $highest.pchhispanic){$highest=$_}}
##$highest