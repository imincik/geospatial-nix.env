#!/usr/bin/env bash

set -euo pipefail

nix flake check --impure
nix flake show --impure

nix develop --impure --command gdalinfo --version | grep GDAL
