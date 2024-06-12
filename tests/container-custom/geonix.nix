#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  name = "test";

  containers.custom = {
    name = "container-custom";
    entrypoint = [ "/bin/sh" "-c" ];
    startupCommand = "${pkgs.python3}/bin/python -m http.server";
    copyToRoot = null;
  };
}
