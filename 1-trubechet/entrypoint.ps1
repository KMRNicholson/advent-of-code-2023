param (
    [Parameter(Mandatory)]
    [string]
    $InputFilePath
)

Get-ChildItem './functions' `
    | ForEach-Object { . $_ }

$inputs = Get-Content -Path $InputFilePath

$sum = 0
foreach($line in $inputs){
    $sum += Get-CalibrationValue $line
}

Write-Output "The sum of the calibration values: $sum"