$ErrorActionPreference = "Stop"

$root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$regionA = Join-Path $root "envs\region-a"
$regionB = Join-Path $root "envs\region-b"
$stateA = Join-Path $root "state\region-a"
$stateB = Join-Path $root "state\region-b"

New-Item -ItemType Directory -Force -Path $stateA, $stateB | Out-Null

Push-Location $regionA
terraform init -upgrade
terraform apply -auto-approve
Pop-Location

Push-Location $regionB
terraform init -upgrade
terraform apply -auto-approve
Pop-Location
