param([string]$InputFile = "")

$TransDir = "E:\trans"
$Date = Get-Date -Format "M.d.yy"
$Time = Get-Date -Format "HHmm"
$FileName = "$Date-$Time-W.txt"
$FilePath = "$TransDir\$FileName"

if (!(Test-Path $TransDir)) {
    Write-Output "Trans folder not found: $TransDir"
    exit 1
}

if ($InputFile -and (Test-Path $InputFile)) {
    Copy-Item $InputFile $FilePath
} else {
    $content = $input | Out-String
    Set-Content -Path $FilePath -Value $content
}

Write-Output "Trans file written: $FileName"
