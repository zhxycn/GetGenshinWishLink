$logLocationCN = "%userprofile%\AppData\LocalLow\miHoYo\$([char]0x539f)$([char]0x795e)\output_log.txt";
$logLocationGlobal = "%userprofile%\AppData\LocalLow\miHoYo\Genshin Impact\output_log.txt";

$pathCN = [System.Environment]::ExpandEnvironmentVariables($logLocationCN);
$pathGlobal = [System.Environment]::ExpandEnvironmentVariables($logLocationGlobal);
$findCN = [System.IO.File]::Exists($pathCN);
$findGlobal = [System.IO.File]::Exists($pathGlobal);

if ($findCN -And $findGlobal) {
    Write-Host "Find both China and Global log file. Please choose one. Press [1] for CN, [2] for Global." -ForegroundColor Yellow
    $keyInput = [Console]::ReadKey($true).Key
    if ($keyInput -eq "NumPad1" -or $keyInput -eq "D1") {
        $path = $pathCN
    } elseif ($keyInput -eq "NumPad2" -or $keyInput -eq "D2") {
        $path = $pathGlobal
    } else {
        Write-Host "Invalid input." -ForegroundColor Red
        break
    }
} elseif ($findCN) {
    $path = $pathCN
} elseif ($findGlobal) {
    $path = $pathGlobal
} else {
    Write-Host "Cannot find the log file. Make sure to open the wish history first." -ForegroundColor Red
    break
}

$logs = Get-Content -Path $path
$match = $logs -match "^OnGetWebViewPageFinish.*log$"

if (-Not $match) {
    Write-Host "Cannot find the wish history url. Make sure to open the wish history first." -ForegroundColor Red
    return
}

[string] $wishHistoryUrl = $match[$match.Length - 1]  -replace 'OnGetWebViewPageFinish:', ''
Write-Host $wishHistoryUrl
Set-Clipboard -Value $wishHistoryUrl
Write-Host "Link copied to clipboard." -ForegroundColor Green
