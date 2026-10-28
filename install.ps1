<#
.SYNOPSIS
  把 memory-kit 的骨架複製到 agent 的工作區。已存在的檔案不會被覆蓋。

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Dest "D:\my-agent\workspace"
#>
param(
  [Parameter(Mandatory = $true)][string]$Dest,
  [switch]$Force
)

$ErrorActionPreference = 'Stop'
$src = Join-Path $PSScriptRoot 'template'

if (-not (Test-Path $src)) { throw "找不到 template 資料夾:$src" }
if (-not (Test-Path $Dest)) { New-Item -ItemType Directory -Path $Dest -Force | Out-Null }

$copied = 0; $skipped = 0

Get-ChildItem -Path $src -Recurse -File | ForEach-Object {
  $rel = $_.FullName.Substring($src.Length).TrimStart('\')
  $target = Join-Path $Dest $rel
  $dir = Split-Path $target -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

  if ((Test-Path $target) -and -not $Force) {
    Write-Host "skip   $rel (已存在)"
    $skipped++
    return
  }
  Copy-Item $_.FullName $target -Force
  Write-Host "create $rel"
  $copied++
}

Write-Host ""
Write-Host "完成:$copied 個新增,$skipped 個跳過。"
Write-Host "下一步:改 CONSTITUTION.md 與 PARTNER.md,然後跟你的 AI 說「先讀這兩份再回答」。"
