#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  packages = [ ];

  applications.grass = {
    enable = true;
    plugins = p: [ geopkgs.grass-plugin-r-hydrodem geopkgs.grass-plugin-v-histogram ];
  };

  enterShell = ''
    set -euo pipefail
    grass --version | grep -E "^GRASS GIS"
    grass --text --exec r.hydrodem --help
    grass --text --exec v.histogram --help
    exit 0
  '';
}
