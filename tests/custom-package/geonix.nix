#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [
    pkgs.gdal
  ];

  enterShell = ''
    set -euo pipefail
    gdalinfo --help | grep "Usage: gdalinfo (patched)"
    exit 0
  '';
}
