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

$env:AWS_ACCESS_KEY_ID = "test"
$env:AWS_SECRET_ACCESS_KEY = "test"

Write-Host "Region A buckets:"
& $aws --endpoint-url http://localhost:4566 s3 ls
Write-Host "Region A objects:"
& $aws --endpoint-url http://localhost:4566 s3 ls s3://dr-sim-a --recursive

Write-Host "Region B buckets:"
& $aws --endpoint-url http://localhost:4567 s3 ls
Write-Host "Region B objects:"
& $aws --endpoint-url http://localhost:4567 s3 ls s3://dr-sim-b --recursive
