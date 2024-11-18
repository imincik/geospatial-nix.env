#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  name = "test";

  processes = {
    py-server.exec = "${pkgs.python3}/bin/python -m http.server";
  };
}
