#!/usr/bin/env bash

set -euo pipefail

source ../../tests/common.sh

function cleanup {
    echo -e "\nRunning cleanup ..."
    processes_down

    docker kill shell || true
    docker image rm --force shell || true
}
trap cleanup EXIT ERR


# enter shell to install Python Poetry environment
nix "${NIX_FLAGS[@]}" develop --impure --command echo OK


# launch services (with local data backend)
echo -e "\nTEST: local backend"
nix run .#geonixcli -- up &

# test app
sleep 3  # leave some time for things to settle
curl --silent --retry 10 --retry-all-errors localhost:5000 | grep "POLYGON"
processes_down  # terminate services 


# launch services (with db data backend)
echo -e "\nTEST: db backend"
BACKEND=db nix run .#geonixcli -- up &

# test app
sleep 3  # leave some time for things to settle
curl --silent --retry 10 --retry-all-errors localhost:5000 | grep "POLYGON"
processes_down  # terminate services 


# launch services (in container)
echo -e "\nTEST: container with db backend"
image_name="shell"

# build container image
nix run .#geonixcli -- container "$image_name"

# run container
docker run -d --rm --name "$image_name" -p 5001:5000 "$image_name":latest

# test app
sleep 3  # leave some time for things to settle
curl --silent --retry 10 --retry-all-errors localhost:5001 | grep "POLYGON"
