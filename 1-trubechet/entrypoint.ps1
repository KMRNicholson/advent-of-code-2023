param (
    [Parameter(Mandatory)]
    [string]
    $InputFilePath
)

Get-ChildItem './functions' `
    | ForEach-Object { . $_ }

$inputs = Get-Content -Path $InputFilePath

$intSum = 0
$stringSum = 0
foreach($line in $inputs){
    $intSum += Get-CalibrationValueByIntegerNumber $line
    $stringSum += Get-CalibrationValueByStringNumber $line
}

Write-Output "The integer sum of the calibration values: $intSum"
Write-Output "The string sum of the calibration values: $stringSum"