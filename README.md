# Geospatial NIX environment

Check out the user interface at
[https://geospatial-nix.today/](https://geospatial-nix.today/) .


## Quick start

### Installation

* Install Nix
  [(learn more about this installer)](https://zero-to-nix.com/start/install)
```bash
curl --proto '=https' --tlsv1.2 -sSf \
    -L https://install.determinate.systems/nix \
    | sh -s -- install
  ```

### Create the environment

* Initialize a new environment
```bash
mkdir my-project && cd my-project

git init

nix run github:imincik/geospatial-nix.env#geonixcli -- init

git add *
```

* Edit `geonix.nix` file according to your project requirements
  (check out
  [configuration docs](https://github.com/imincik/geospatial-nix.env/wiki/Configuration)
  )

* Launch shell environment
```bash
nix run .#geonixcli -- shell
```

* Launch services
```bash
nix run .#geonixcli -- up
```

## Devenv origin

This project is a fork of [Devenv](https://devenv.sh/) started in version
`be7e835`.

## Credits

* Domen Kožar <domen@dev.si>
* [Devenv](https://devenv.sh/) contributors
