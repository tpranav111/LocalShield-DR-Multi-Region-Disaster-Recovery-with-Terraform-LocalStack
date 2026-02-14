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

$sourceBucket = "dr-sim-a"
$destBucket = "dr-sim-b"
$tempDir = Join-Path $PSScriptRoot "tmp\replication"

New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

$env:AWS_ACCESS_KEY_ID = "test"
$env:AWS_SECRET_ACCESS_KEY = "test"
$env:AWS_DEFAULT_REGION = "us-east-1"

& $aws --endpoint-url http://localhost:4566 s3 sync "s3://$sourceBucket" $tempDir

$env:AWS_DEFAULT_REGION = "us-west-2"
& $aws --endpoint-url http://localhost:4567 s3 sync $tempDir "s3://$destBucket"
