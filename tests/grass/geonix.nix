#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [ ];

  applications.grass = {
    enable = true;
    plugins = p: [
      pkgs.grassPlugins.r-hydrodem
      pkgs.grassPlugins.v-histogram
    ];
  };

  enterShell = ''
    set -euo pipefail
    grass --version | grep -E "^GRASS GIS"
    grass --text --exec r.hydrodem --help
    grass --text --exec v.histogram --help
    exit 0
  '';
}
