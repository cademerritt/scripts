# Reads a Claude transcript .jsonl file, extracts user/assistant messages,
# strips #### Correction: lines, writes markdown session note to E:\wiki\sessions\YYYY-MM-DD.md
param(
    [Parameter(Mandatory=$true)]
    [string]$TranscriptPath
)

if (-not (Test-Path $TranscriptPath)) {
    Write-Error "Transcript file not found: $TranscriptPath"
    exit 1
}

$date = Get-Date -Format "yyyy-MM-dd"
$outDir = "E:\wiki\sessions"
$outFile = "$outDir\$date.md"

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$lines = Get-Content $TranscriptPath -Encoding UTF8
$output = [System.Collections.Generic.List[string]]::new()
$output.Add("# Session - $date")
$output.Add("")

foreach ($line in $lines) {
    try {
        $obj = $line | ConvertFrom-Json -ErrorAction Stop
    } catch {
        continue
    }

    $role = if ($obj.message) { $obj.message.role } else { $obj.role }
    if ($role -ne "user" -and $role -ne "assistant") { continue }

    $content = if ($obj.message) { $obj.message.content } else { $obj.content }
    if ($content -is [string]) {
        $text = $content
    } else {
        $text = (@($content) | Where-Object { $_.type -eq "text" } | ForEach-Object { $_.text }) -join "`n"
    }

    $text = ($text -split "`n" | Where-Object { $_ -notmatch "^#### Correction:" }) -join "`n"
    $text = $text.Trim()
    if (-not $text) { continue }

    if ($role -eq "user") { $label = "**Cade:**" } else { $label = "**Claude:**" }
    $output.Add($label)
    $output.Add($text)
    $output.Add("")
}

$output | Set-Content -Path $outFile -Encoding UTF8
Write-Host "Written to $outFile"
