#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  services.postgres = {
    enable = true;
    extensions = e: [ geopkgs.postgresql-postgis ];
    listen_addresses = "127.0.0.1";
  };
}
