#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.lib.customizePackages {
    nixpkgs = pkgs;
    geopkgs = inputs.geonix.packages.${pkgs.system};
    overridesFile = ./overrides.nix;
  };
in
{
  packages = [
    geopkgs.gdal
  ];

  enterShell = ''
    set -euo pipefail
    gdalinfo --help | grep "Usage: gdalinfo (patched)"
    exit 0
  '';
}
