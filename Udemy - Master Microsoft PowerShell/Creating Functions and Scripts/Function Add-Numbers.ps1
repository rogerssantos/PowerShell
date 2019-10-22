function Add-Numbers { 
    param (
        [int]$num1, [int]$num2
    )
    return $num1 + $num2
}

#Add-Numbers 651 231
#Add-Numbers -num1  651 -num2 231
$result = Add-Numbers -num1  651 -num2 231
$result += Add-Numbers -num1  756 -num2 110
$result