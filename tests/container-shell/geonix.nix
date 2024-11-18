#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{

  name = "test";

  packages = [ pkgs.gdalMinimal ];
}
