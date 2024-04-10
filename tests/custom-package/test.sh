#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

# TODO: replace hardcoded copy of `overrides.nix` file with fresh copy taken
# from `pkgs/geonixcli/templates/override/ overrides.nix` and patch it during
# the test.
# patch -u overrides.nix -i gdal.patch

nix run .#geonixcli -- shell
