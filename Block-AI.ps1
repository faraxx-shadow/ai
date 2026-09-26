# ============================================
# AI WEBSITE BLOCKER
# For authorized school/lab computers
# ============================================

$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

$startMarker = "# === AI-LAB-BLOCK-START ==="
$endMarker   = "# === AI-LAB-BLOCK-END ==="

$domains = @(
    "chatgpt.com",
    "www.chatgpt.com",
    "openai.com",
    "www.openai.com",
    "gemini.google.com",
    "claude.ai",
    "www.claude.ai",
    "perplexity.ai",
    "www.perplexity.ai",
    "copilot.microsoft.com",
    "poe.com",
    "www.poe.com",
    "character.ai",
    "www.character.ai",
    "you.com",
    "www.you.com",
    "deepseek.com",
    "www.deepseek.com"
)

Write-Host "Updating hosts file..."

try {
    $content = Get-Content -Path $hostsFile -Raw -ErrorAction Stop

    # Remove previous block
    $pattern = "(?ms)" + [regex]::Escape($startMarker) + ".*?" + [regex]::Escape($endMarker) + "\s*"
    $content = [regex]::Replace($content, $pattern, "")

    # Build blocking section
    $block = @()
    $block += $startMarker
    $block += "# AI websites blocked on this lab computer"

    foreach ($domain in $domains) {
        $block += "0.0.0.0`t$domain"
    }

    $block += $endMarker

    # Write hosts file
    Set-Content -Path $hostsFile `
        -Value ($content.TrimEnd() + "`r`n" + ($block -join "`r`n")) `
        -Encoding ASCII

    # Clear DNS cache
    ipconfig /flushdns | Out-Null

    Write-Host ""
    Write-Host "SUCCESS: AI website blocking has been applied." -ForegroundColor Green
}
catch {
    Write-Host ""
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
