Write-Host "John Microsoft is a bad man and is on the hook! Can you save him."

function GetPlayerCharacter {
    $inputChar = Read-Host
    if ($inputChar.Length -ne 1) {
        Write-Host "Invalid length"
        return ''
    }

    return $inputChar
}

function DisplayGame {
    param (
        [int]$hp,
        [string]$word,
        [array]$usedLetters
    )

    Clear-Host

    if ($usedLetters.Length -gt 0) {
        Write-Host "Used letters: $usedLetters"
    }
    
    if ($hp -le 5) { $head = "O" } else { $head= " " }
    if ($hp -le 4) { $torso = "|" } else { $torso= " " }
    if ($hp -le 3) { $larm = "/" } else { $larm= " " }
    if ($hp -le 2) { $rarm = "\" } else { $rarm= " " }
    if ($hp -le 1) { $lleg = "/" } else { $lleg= " " }
    if ($hp -le 0) { $rleg = "\" } else { $rleg= " " }

    Write-Host "  +---+`r`n  |   |`r`n  ${head}   |`r`n ${larm}${torso}${rarm}  |`r`n ${lleg} ${rleg}  |`r`n      |`r`n========="
    Write-Host $word
}

function RandomWord {
    return @("ant", "babboon", "badger", "bat", "bear", "beaver", "camel", "cat", "clam", "cobra",
    "cougar", "coyote", "crow", "deer", "dog", "donkey", "duck", "eagle", "ferret", "fox",
    "frog", "goat", "goose", "hawk", "lion", "lizard", "llama", "mole", "rat", "raven",
    "rhino", "shark", "sheep", "spider", "toad", "turkey", "turtle", "wolf", "wombat", "zebra") 
    | Get-Random
}

$hp = 6
$goal = RandomWord
$word = "".PadLeft($goal.length, '_')
$usedLetters = @()

while ($hp -gt 0) {
    DisplayGame $hp $word $usedLetters
    $inputChar = GetPlayerCharacter
    if (-not $inputChar) {
        continue
    } elseif ($usedLetters.Contains($inputChar)) {
        Write-Host "$inputChar already used."
        continue
    }

    $usedLetters += $inputChar
    if ($goal.Contains($inputChar)) {
        $wordArr = $word.ToCharArray()
        for ($i = 0; $i -lt $goal.length; $i++) {
            if ($goal[$i] -eq $inputChar) {
                if ($i -eq 0) {
                    $wordArr[$i] = $inputChar.ToUpper() 
                } else {
                    $wordArr[$i] = $inputChar
                }
            }
        }

        $word = $wordArr -join ''
    }
    else {
        $hp--
    }

    if ($word.ToLower() -eq $goal) {
        Write-Host "You saved John! The word was $goal"
        Write-Host " O`r`n/|\`r`n/ \"
        return
    }
}

Write-Host "John died!";
DisplayGame $hp $word
