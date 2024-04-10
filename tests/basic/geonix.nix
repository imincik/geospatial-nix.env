#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  packages = [
    geopkgs.gdal-minimal
  ];

  enterShell = ''
    gdalinfo --version | grep GDAL
    exit 0
  '';
}
