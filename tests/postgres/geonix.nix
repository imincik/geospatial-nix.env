#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  services.postgres = {
    enable = true;
    extensions = e: [ pkgs.postgresqlPackages.postgis ];
    listen_addresses = "127.0.0.1";
  };
}
