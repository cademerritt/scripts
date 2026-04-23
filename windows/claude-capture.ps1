# Reads tool call JSON from stdin, appends timestamped entry to E:\raw\claude-raw.log
$json = $input | Out-String
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logDir = "E:\raw"
$logFile = "$logDir\claude-raw.log"

if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}

$entry = "[$timestamp] $($json.Trim())"
Add-Content -Path $logFile -Value $entry -Encoding UTF8
