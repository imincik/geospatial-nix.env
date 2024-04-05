#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

nix "${NIX_FLAGS[@]}" develop --impure --command poetry run python ./test.py
