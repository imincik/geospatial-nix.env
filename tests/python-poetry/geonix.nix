#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  python = pkgs.python3.withPackages (p: [
    pkgs.python3Packages.gdal
  ]);


in {
  packages = [ ];

  languages.python = {
    enable = true;
    package = python;
    poetry.enable = true;
  };

  env.NIX_PYTHON_SITEPACKAGES = "${python}/${python.sitePackages}";

  enterShell = ''
    set -euo pipefail
    poetry run python ./test.py
    exit 0
  '';
}
