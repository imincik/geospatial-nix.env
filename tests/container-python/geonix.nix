#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

  python = pkgs.python3.withPackages (p: [
    geopkgs.python3-fiona
  ]);

in
{
  languages.python = {
    enable = true;
    package = python;
  };
}
