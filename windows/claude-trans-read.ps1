$TransDir = "E:\trans"
$LastReadFile = "$env:USERPROFILE\.trans-last-read"

if (!(Test-Path $TransDir)) {
    Write-Output "Trans folder not found: $TransDir"
    exit 1
}

if (Test-Path $LastReadFile) {
    $LastRead = (Get-Item $LastReadFile).LastWriteTime
    $NewFiles = Get-ChildItem "$TransDir\*-L*.txt" | Where-Object { $_.LastWriteTime -gt $LastRead } | Sort-Object LastWriteTime
} else {
    $NewFiles = Get-ChildItem "$TransDir\*-L*.txt" | Sort-Object LastWriteTime
}

if ($NewFiles.Count -eq 0) {
    Write-Output "No new trans files from Linux."
    exit 0
}

Write-Output "=== AUTO TRANS READ ==="
foreach ($File in $NewFiles) {
    Write-Output ""
    Write-Output "--- $($File.Name) ---"
    Get-Content $File.FullName
    Write-Output ""
}

New-Item -Path $LastReadFile -ItemType File -Force | Out-Null
Write-Output "Trans files loaded into context."
