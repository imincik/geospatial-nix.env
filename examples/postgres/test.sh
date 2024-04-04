#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

trap processes_down EXIT ERR

assemble_devenv
procfilescript=$(nix "${NIX_FLAGS[@]}" build --impure --no-link --print-out-paths .#devenv-up)
exec $procfilescript &

nix "${NIX_FLAGS[@]}" develop --impure \
    --command timeout 60 sh -c 'pg_isready'

nix "${NIX_FLAGS[@]}" develop --impure \
    --command psql -c 'CREATE EXTENSION IF NOT EXISTS postgis; SELECT postgis_version();'
