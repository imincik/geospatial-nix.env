#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

# build container image
assemble_devenv
container_name="shell"
image_name=$(nix "${NIX_FLAGS[@]}" eval --raw ".#container-$container_name.imageName")

# copy container image to local docker registry
export DEVENV_CONTAINER=1
copy_script=$( \
    nix build ".#container-$container_name.copyToDockerDaemon" --no-link --print-out-paths --impure \
)
"$copy_script/bin/copy-to-docker-daemon"

# test container
docker run --rm "$image_name":latest gdalinfo --version | grep "GDAL"

# cleanup
docker image rm --force "$image_name"
