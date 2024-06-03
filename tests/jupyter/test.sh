#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

trap processes_down EXIT ERR

nix run .#geonixcli -- up &

sleep 3  # leave some time for things to settle

# test service
curl --silent --retry 10 --retry-all-errors localhost:8888
