#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

cp ../../pkgs/geonixcli/templates/override/overrides.nix .
patch -u overrides.nix -i gdal.patch

nix run .#geonixcli -- shell
