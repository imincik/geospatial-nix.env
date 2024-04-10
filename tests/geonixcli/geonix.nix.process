#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  processes.test.exec = ''
    ${pkgs.python3}/bin/python -m http.server
  '';
}
