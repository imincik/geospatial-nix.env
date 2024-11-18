#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  processes.test.exec = ''
    ${pkgs.python3}/bin/python -m http.server
  '';
}
