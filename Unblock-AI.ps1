$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

$startMarker = "# === AI-LAB-BLOCK-START ==="
$endMarker = "# === AI-LAB-BLOCK-END ==="

try {
$content = Get-Content -Path $hostsFile -Raw -ErrorAction Stop

# Remove the block installed by Block-AI.ps1
$pattern = "(?ms)" + [regex]::Escape($startMarker) + ".*?" + [regex]::Escape($endMarker) + "\s*"
$newContent = [regex]::Replace($content, $pattern, "")

Set-Content -Path $hostsFile -Value $newContent -Encoding ASCII

ipconfig /flushdns | Out-Null

Write-Host "AI website blocking removed successfully." -ForegroundColor Green


}
catch {
Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
exit 1
}