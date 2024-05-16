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
    plugins = with geopkgs; [ qgis-plugin-qgis2web qgis-plugin-MapTiler ];
  };

  enterShell = ''
    set -euo pipefail
    # TODO: test installed plugins
    echo "Shell environment was successfully activated."
    exit 0
  '';
}
