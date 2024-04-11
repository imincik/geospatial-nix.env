# test functions

NIX_FLAGS=( --accept-flake-config --no-warn-dirty --extra-experimental-features nix-command --extra-experimental-features flakes )

function processes_down {
    pid="$(cat .devenv/state/devenv.pid)"
    kill -0 "$pid" &> /dev/null && kill $pid || echo "processes_down: process $pid doesn't exist"
}
