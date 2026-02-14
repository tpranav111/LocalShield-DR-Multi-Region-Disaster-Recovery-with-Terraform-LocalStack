$ErrorActionPreference = "Stop"

$aws = (Get-Command aws -ErrorAction SilentlyContinue | Select-Object -First 1).Source
if (-not $aws) {
  $fallback = "C:\\Program Files\\Amazon\\AWSCLIV2\\aws.exe"
  if (Test-Path $fallback) {
    $aws = $fallback
  } else {
    throw "AWS CLI not found. Ensure awscli v2 is installed."
  }
}

$bucket = "dr-sim-a"
$tempDir = Join-Path $PSScriptRoot "tmp"
$demoFile = Join-Path $tempDir "demo.txt"

New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
"DR demo file from Region A" | Set-Content -Path $demoFile -Encoding ASCII

$env:AWS_ACCESS_KEY_ID = "test"
$env:AWS_SECRET_ACCESS_KEY = "test"
$env:AWS_DEFAULT_REGION = "us-east-1"

& $aws --endpoint-url http://localhost:4566 s3 cp $demoFile "s3://$bucket/demo.txt"
