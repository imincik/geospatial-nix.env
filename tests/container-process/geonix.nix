#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  containers = {
    py-server.name = "py-server";
    py-server.entrypoint = [ "/bin/sh" "-c" ];
    py-server.startupCommand = "${pkgs.python3}/bin/python -m http.server";
    py-server.copyToRoot = null;
  };
}
