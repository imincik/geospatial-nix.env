#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

nix flake check --impure
nix flake show --impure

nix "${NIX_FLAGS[@]}" develop --impure --command gdalinfo --version | grep GDAL
