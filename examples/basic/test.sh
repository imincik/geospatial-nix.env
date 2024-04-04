#!/usr/bin/env bash

set -euo pipefail

nix flake check --impure
nix flake show --impure

nix develop --impure --accept-flake-config --command gdalinfo --version | grep GDAL
