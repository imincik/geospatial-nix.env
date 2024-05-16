#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  packages = [ ];

  applications.qgis = {
    enable = true;
    pythonPackages = p: [ pkgs.python3Packages.flask geopkgs.python3-fiona ];
    plugins = p: [ geopkgs.qgis-plugin-qgis2web geopkgs.qgis-plugin-QGIS-Cloud-Plugin ];
  };

  enterShell = ''
    set -euo pipefail
    echo "Shell environment was successfully activated."
    # qgis --code ./test.py  # can't run in CI
    exit 0
  '';
}
