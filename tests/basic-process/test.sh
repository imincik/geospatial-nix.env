#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

assemble_devenv
procfilescript=$(nix "${NIX_FLAGS[@]}" build --impure --no-link --print-out-paths .#devenv-up)
exec $procfilescript
