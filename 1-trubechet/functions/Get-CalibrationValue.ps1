function Find-IntegerNumber {
    [Cmdletbinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $InputString
    )

    $result = $null

    $i = 0
    while($i -lt $InputString.Length){
        $char = $InputString[$i]
        if([int32]::TryParse($char, [ref]$result)){
            Write-Verbose "Found a number: $char"
            break
        }
        $i++
    }

    Write-Output "$result"
}

function Find-IntegerNumberIndex {
    [Cmdletbinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $InputString
    )

    $result = $null

    $i = 0
    while($i -lt $InputString.Length){
        $char = $InputString[$i]
        if([int32]::TryParse($char, [ref]$result)){
            Write-Verbose "Found a number: $char"
            break
        }
        $i++
    }

    Write-Output @("$result", $i)
}

function Find-StringNumber {
    [Cmdletbinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $InputString,

        [Parameter()]
        [switch]
        $Reverse
    )

    Write-Verbose "[find-stringnumber] $InputString"

    $numbers = @{
        one = 1
        two = 2
        three = 3
        four = 4
        five = 5
        six = 6
        seven = 7
        eight = 8
        nine = 9
    }

    if($Reverse){
        $reversedNumbers = @{}
        foreach($key in $numbers.Keys){
            $reversedKey = $key | Get-ReversedString
            $reversedNumbers.Add($reversedKey, $numbers[$key])
        }
        $numbers = $reversedNumbers
    }

    $integerNumberData = Find-IntegerNumberIndex $InputString
    $lowestIndex = $integerNumberData[1]
    $result = $integerNumberData[0]
    foreach($key in $numbers.Keys){
        $indexOfKey = $InputString.IndexOf("$key")
        if($indexOfKey -lt $lowestIndex -and $indexOfKey -ne -1){
            $lowestIndex = $indexOfKey -lt $lowestIndex ? $indexOfKey : $lowestIndex
            $result = $numbers[$key]
        }
    }

    Write-Verbose "Found $result as the first number in input string $InputString"
    Write-Output $result
}

function Get-FirstNumberInString {
    [Cmdletbinding()]
    [OutputType([string])]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]
        $InputString,

        [Parameter()]
        [switch]
        $MatchStringNumber,

        [Parameter()]
        [switch]
        $Reverse
    )

    Write-Verbose "Getting first number in string: $InputString"

    $result = 0

    Write-Verbose $MatchStringNumber

    if(-not $MatchStringNumber){
        $result = Find-IntegerNumber $InputString
    }else{
        $result = Find-StringNumber $InputString -Reverse:$Reverse
    }

    return $result
}

function Get-ReversedString {
    [OutputType([string])]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]
        $InputString
    )

    $reversedInput = ''
    $copiedInput = $InputString

    while($reversedInput.Length -ne $InputString.Length){
        $lastIndex = $copiedInput.Length - 1
        $reversedInput += $copiedInput.Substring($lastIndex)
        $copiedInput = $copiedInput.Substring(0, $lastIndex)
    }

    Write-Output $reversedInput
}

function Get-CalibrationValueByIntegerNumber {
    [OutputType([int32])]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $CalibrationInput
    )

    Write-Verbose "Getting calibration value for input: $CalibrationInput"

    $firstNumber = $CalibrationInput `
        | Get-FirstNumberInString

    $secondNumber = $CalibrationInput `
        | Get-ReversedString `
        | Get-FirstNumberInString

    [int32]$result = [string]::Concat($firstNumber, $secondNumber)

    Write-Verbose "Calibration value: $result"
    return $result
}

function Get-CalibrationValueByStringNumber {
    [OutputType([int32])]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $CalibrationInput
    )

    Write-Verbose "Getting calibration value for input: $CalibrationInput"

    $firstNumber = $CalibrationInput `
        | Get-FirstNumberInString -MatchStringNumber

    $secondNumber = $CalibrationInput `
        | Get-ReversedString `
        | Get-FirstNumberInString -MatchStringNumber -Reverse

    [int32]$result = [string]::Concat($firstNumber, $secondNumber)

    Write-Verbose "Calibration value: $result"
    return $result
}

