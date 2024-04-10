#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

trap processes_down EXIT ERR

nix run .#geonixcli -- up &

nix "${NIX_FLAGS[@]}" develop --impure \
    --command timeout 60 sh -c 'until pg_isready; do sleep 1; done'

nix "${NIX_FLAGS[@]}" develop --impure \
    --command psql -c 'CREATE EXTENSION IF NOT EXISTS postgis; SELECT postgis_version();'
