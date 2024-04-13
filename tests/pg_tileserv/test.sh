#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

trap processes_down EXIT ERR

nix run .#geonixcli -- up &

sleep 3  # leave some time for things to settle
nix "${NIX_FLAGS[@]}" develop --impure \
    --command timeout 60 sh -c 'until pg_isready; do sleep 1; done'

# test service
curl --silent --retry 10 --retry-all-errors localhost:7800
