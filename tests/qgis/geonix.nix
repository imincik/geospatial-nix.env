#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [ ];

  applications.qgis = {
    enable = true;
    pythonPackages = p: [
      pkgs.python3Packages.flask
      pkgs.python3Packages.fiona
    ];
    plugins = p: [
      pkgs.qgisPlugins.qgis2web
      pkgs.qgisPlugins.QGIS-Cloud-Plugin
    ];
  };

  enterShell = ''
    set -euo pipefail
    echo "Shell environment was successfully activated."
    # qgis --code ./test.py  # can't run in CI
    exit 0
  '';
}
