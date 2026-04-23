$repo = "$env:USERPROFILE\scripts"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"

Set-Location $repo

$status = git status --porcelain
if ($status) {
    git add -A
    git commit -m "auto-push $timestamp"
    git push
}
