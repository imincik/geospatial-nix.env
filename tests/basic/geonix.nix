#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [
    pkgs.gdalMinimal
  ];

  enterShell = ''
    set -euo pipefail
    gdalinfo --version | grep GDAL
    exit 0
  '';
}
