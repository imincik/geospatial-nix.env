# Entering shell environments and using services

## Shell environments

Run following command to enter shell environment containing all packages
configured in `geonix.nix` file.

```
nix run .#geonixcli -- shell
```

## Services

Run following command to run all services configured in `geonix.nix` file.

```
nix run .#geonixcli -- up
```

!!! note
    Service's data is stored in state directory `.devenv/state/<SERVICE>`
    located in the root directory of the project . This directory is usually
    populated during the first start of the service. Deleting the state
    directory may be necessary for certain configuration changes to take effect.
