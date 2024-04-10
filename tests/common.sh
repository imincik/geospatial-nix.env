# test functions

NIX_FLAGS=( --accept-flake-config --no-warn-dirty --extra-experimental-features nix-command --extra-experimental-features flakes )

function processes_down {
    kill "$(cat .devenv/state/devenv.pid)"
}
