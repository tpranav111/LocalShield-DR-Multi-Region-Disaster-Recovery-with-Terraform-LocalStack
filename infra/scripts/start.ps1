$ErrorActionPreference = "Stop"

$composePath = Join-Path $PSScriptRoot "..\docker\docker-compose.yaml"

docker compose -f $composePath up -d
