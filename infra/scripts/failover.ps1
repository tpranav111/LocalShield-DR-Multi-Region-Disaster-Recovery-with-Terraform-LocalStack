param(
  [ValidateSet("a","b")]
  [string]$ToRegion = "b"
)

$ErrorActionPreference = "Stop"

$target = if ($ToRegion -eq "a") { "app-a" } else { "app-b" }
$upstreamPath = Join-Path $PSScriptRoot "..\docker\router\upstream.conf"

@" 
upstream app_upstream {
  server ${target}:80;
}
"@ | Set-Content -Path $upstreamPath -Encoding ASCII

docker exec dr-router nginx -s reload
