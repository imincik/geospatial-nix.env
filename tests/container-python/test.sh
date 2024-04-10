#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

image_name="shell"

# build container image
nix run .#geonixcli -- container shell

# test container
docker run --rm "$image_name":latest \
    python -c "import fiona; print(fiona.supported_drivers)" \
    grep "ESRI Shapefile"

# cleanup
docker image rm --force "$image_name"
