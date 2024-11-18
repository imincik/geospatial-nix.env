#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  python = pkgs.python3.withPackages (p: [
    pkgs.python3Packages.fiona
  ]);

in
{
  name = "test";

  languages.python = {
    enable = true;
    package = python;
  };
}
