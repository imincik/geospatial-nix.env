#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

image_name="py-server"

# build container image
nix run .#geonixcli -- container "$image_name"

# run container
docker run -d --name "$image_name" -p 8000:8000 --rm "$image_name":latest

# test container
curl --silent --retry 10 --retry-all-errors localhost:8000

# cleanup
docker kill "$image_name"
docker image rm --force "$image_name"
