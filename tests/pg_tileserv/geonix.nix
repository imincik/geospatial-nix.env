#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  services.postgres = {
    enable = true;
    extensions = e: [ pkgs.postgresqlPackages.postgis ];
    initialScript = ''
      CREATE EXTENSION IF NOT EXISTS postgis;
    '';
  };

  services.pg_tileserv = {
    enable = true;
    package = pkgs.pg_tileserv;
  };
}
