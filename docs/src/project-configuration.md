# Project environment configuration

The environment configuration is done in `geonix.nix` file. In this file, it
is possible to declaratively add packages, services and support for programming
languages.


## Adding more features

By default, the new environment contains only a single `gdalMinimal` package in
`packages` list.

```
{ inputs, config, lib, pkgs, ... }:

{
  packages = [
    pkgs.gdalMinimal
  ];
}
```

### Adding more packages

Update `packages` list as following to add `pdal` package from Geospatial NIX
repository and `tmux` package from Nixpkgs repository:

```
packages = [
  pkgs.gdalMinimal
  pkgs.pdal
  pkgs.tmux
];
```

### Adding languages

Python language can be added by simply adding following line:

```
languages.python.enable = true;
```

### Adding services

PostgreSQL service can be added by simply adding following line:

```
services.postgres.enable = true;
```

!!! note
    See [configuration options](configuration-options.md) for the complete list of
    available configuration options.

## Checking the configuration

After making changes, check configuration using

```
nix run .#geonixcli -- check
```

command.

