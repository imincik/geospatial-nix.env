# Project update 

New project is always created in the latest Geospatial NIX and Geospatial
NIX.env versions. Geospatial NIX repository is releasing new version of packages
every week and new versions of Geospatial NIX.env containing new features or bug
fixes are released when available.

Run following command to update the project to use the latest version of
Geospatial NIX packages:


## Updating Geospatial NIX

```
nix run .#geonixcli -- update geonix
```

## Updating Geospatial NIX.env

Run following command to update the project to use the latest version of
Geospatial NIX.env:

```
nix run .#geonixcli -- update geoenv
```

!!! note
    It is also possible to downgrade project to use previous versions or pin
    project to always use the same version.

    In `flake.nix` file, replace `latest` version in `geonix` or `geoenv` `url`
    input as needed.

    For example, this will pin `geonix` version to `v2024.18.0`.

      ```
      geonix.url = "github:imincik/geospatial-nix.repo/v2024.18.0";
      ```
