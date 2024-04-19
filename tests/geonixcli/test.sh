#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

function cleanup {
    processes_down
    rm -rf ../test-project
    docker image rm --force shell
}
trap cleanup EXIT ERR

mkdir test-project && cd test-project

# init
echo -e "\nCOMMAND: geonixcli init"
git init
nix run ../..#geonixcli -- init
git add *

# search
echo -e "\nCOMMAND: geonixcli search"
nix run ../..#geonixcli -- search gdal | grep 'geopkgs.gdal'

# shell
echo -e "\nCOMMAND: geonixcli shell"
cp ../geonix.nix.shell geonix.nix
nix run ../..#geonixcli -- shell

# up
echo -e "\nCOMMAND: geonixcli up"
nix run ../..#geonixcli -- up &
cp ../geonix.nix.process geonix.nix
curl --silent --retry 10 --retry-all-errors localhost:8000

# container-config
echo -e "\nCOMMAND: geonixcli container-config"
nix run ../..#geonixcli -- container-config shell

# container
echo -e "\nCOMMAND: geonixcli container"
nix run ../..#geonixcli -- container shell
docker images | grep -E "^shell"

# update
echo -e "\nCOMMAND: geonixcli update"
nix run ../..#geonixcli -- update

# override
echo -e "\nCOMMAND: geonixcli override"
nix run ../..#geonixcli -- override
stat --terse ./overrides.nix

# version
echo -e "\nCOMMAND: geonixcli version"
nix run ../..#geonixcli -- version
