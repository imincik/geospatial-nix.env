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
    initialScript = ''
      CREATE EXTENSION IF NOT EXISTS postgis;
    '';
  };

  services.pg_tileserv = {
    enable = true;
    package = geopkgs.pg_tileserv;
  };
}
