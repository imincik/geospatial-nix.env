#!/usr/bin/env bash

set -euo pipefail

source ../common.sh

function cleanup {
    echo -e "\nRunning cleanup ..."
    processes_down

    popd
    git rm -rf test-project
    rm -rf test-project

    docker kill my-project-shell || true
    docker image rm --force my-project-shell || true

    docker kill my-project-processes || true
    docker image rm --force my-project-processes || true
}
trap cleanup EXIT ERR


mkdir test-project && pushd test-project

# init
echo -e "\nCOMMAND: geonixcli init"
nix run ../..#geonixcli -- init
git add *

sed -i "s|github:imincik/geospatial-nix.env/latest|path:../../../.|g" flake.nix
nix flake update

# check
echo -e "\nCOMMAND: geonixcli check"
nix run .#geonixcli -- check

# search
echo -e "\nCOMMAND: geonixcli search"
nix run .#geonixcli -- search gdal | grep 'pkgs.gdal'

# shell
echo -e "\nCOMMAND: geonixcli shell"
cp ../geonix.nix.shell geonix.nix
nix run .#geonixcli -- shell

# up
echo -e "\nCOMMAND: geonixcli up"
nix run .#geonixcli -- up &
cp ../geonix.nix.process geonix.nix
curl --silent --retry 10 --retry-all-errors localhost:8000

# container-config
echo -e "\nCOMMAND: geonixcli container-config"
nix run .#geonixcli -- container-config shell

# container
echo -e "\nCOMMAND: geonixcli container"
nix run .#geonixcli -- container shell
docker images | grep -E "^my-project-shell"

nix run .#geonixcli -- container processes
docker images | grep -E "^my-project-processes"

# update
echo -e "\nCOMMAND: geonixcli update"
nix run .#geonixcli -- update

# version
echo -e "\nCOMMAND: geonixcli version"
nix run .#geonixcli -- version
