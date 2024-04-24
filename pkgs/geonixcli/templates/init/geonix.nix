#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  # CUSTOMIZED PACKAGES
  # Run `nix run .#geonixcli -- override` and replace geopkgs variable with
  # function below to use customized packages defined by `overrides.nix` file.

  # geopkgs = inputs.geonix.lib.customizePackages {
  #   nixpkgs = pkgs;
  #   geopkgs = inputs.geonix.packages.${pkgs.system};
  #   overridesFile = ./overrides.nix;
  # };

  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  packages = [
    geopkgs.gdal-minimal
  ];
}
