NIX_FLAGS=( --accept-flake-config --no-warn-dirty --extra-experimental-features nix-command --extra-experimental-features flakes )


function assemble_devenv {
    # see: https://github.com/cachix/devenv/blob/405a4c6a3fecfd2a7fb37cc13f4e760658e522e6/src/devenv.nix#L29

    DEVENV_DIR="$(pwd)/.devenv"
    DEVENV_STATE="$DEVENV_DIR"/state
    export DEVENV_DIR
    export DEVENV_STATE
}

