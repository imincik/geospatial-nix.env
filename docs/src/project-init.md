# Project initialization

New Geospatial NIX.env project is started by running

  ```
  nix run github:imincik/geospatial-nix.env/latest#geonixcli -- init
  ```

command which will create a couple of files in the current working directory.


## flake.nix

`flake.nix` is the main Nix project entrypoint file which contains list of all
project inputs and binary cache configuration. For basic use cases, this file
doesn't need to be modified.

## geonix.nix

`geonix.nix` file contains project configuration and is modified by user
according to their needs. See [configuration](project-configuration.md).

## dot-envrc

This file allows fast, automatic environment activation and evaluation caching
when entering the project directory. To make it work,
[direnv](https://direnv.net/) must be installed on the host machine and this
file must be renamed to `.envrc`.

!!! note

    All files must be added to Git before use, otherwise Nix will complain with
    not very user friendly `No such file or directory` error message.
