# Quick start

## Installation

* Install Nix
  [(learn more about this installer)](https://zero-to-nix.com/start/install)

```bash
curl --proto '=https' --tlsv1.2 -sSf \
    -L https://install.determinate.systems/nix \
    | sh -s -- install
```

## Project initialization

* Initialize a new environment
```bash
mkdir my-project && cd my-project

git init

nix run github:imincik/geospatial-nix.env/latest#geonixcli -- init

git add *
```

## Configuration

* Edit `geonix.nix` file
  ([check out available configuration options](configuration-options.md))

## Usage

* Launch shell environment
```bash
nix run .#geonixcli -- shell
```

* Launch services
```bash
nix run .#geonixcli -- up
```

* Run in container
```bash
nix run .#geonixcli -- container shell
docker run --rm -it shell:latest
```

* Show other commands
```bash
nix run .#geonixcli -- --help
```
