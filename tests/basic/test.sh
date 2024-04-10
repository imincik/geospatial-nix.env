#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

nix flake check --impure
nix flake show --impure

nix run .#geonixcli -- shell
