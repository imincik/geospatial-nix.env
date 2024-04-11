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

nix run github:imincik/geospatial-nix.env/latest#geonixcli -- init

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

## Developer documentation

### How to release
* Checkout to a latest `master` branch version
```bash
git checkout master
git pull
```

* Create a version tag in `master` branch
```bash
VERSION="<VERSION>"
git tag -a "$VERSION" -m "Version $VERSION"
```

* Create a latest tag in `master` branch
```bash
git tag -f -a "latest" -m "Latest released version"
```

* Push tags
```bash
git push origin "$VERSION"
git push -f origin latest
```

## Project origin

This project is a fork of [Devenv](https://devenv.sh/) started in version
`be7e835`.

## Credits

* Domen Kožar <domen@dev.si>
* [Devenv](https://devenv.sh/) contributors
