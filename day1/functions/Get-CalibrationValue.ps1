function Get-FirstNumberInString {
    [Cmdletbinding()]
    [OutputType([string])]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]
        $InputString
    )

    Write-Verbose "Getting first number in string: $InputString"
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

function Get-ReversedString {
    [OutputType([string])]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]
        $InputString
    )

    Write-Verbose "Reversing string: $InputString"
    $reversedInput = ''
    $copiedInput = $InputString

    while($reversedInput.Length -ne $InputString.Length){
        $lastIndex = $copiedInput.Length - 1
        $reversedInput += $copiedInput.Substring($lastIndex)
        $copiedInput = $copiedInput.Substring(0, $lastIndex)
    }

    Write-Verbose "Reversed string: $reversedInput"
    Write-Output $reversedInput
}

function Get-CalibrationValue {
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

