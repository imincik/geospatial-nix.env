#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

nix run .#geonixcli -- shell
