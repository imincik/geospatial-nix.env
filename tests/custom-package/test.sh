#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

cp "$(nix "${NIX_FLAGS[@]}" eval .#overrides)" overrides.nix
patch -u overrides.nix -i gdal.patch

nix run .#geonixcli -- shell
