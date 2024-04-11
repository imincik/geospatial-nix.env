#!/usr/bin/env bash

set -euo pipefail

pushd ../../examples/python-web
./test.sh
popd
