#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in {
  packages = [
    pkgs.glxinfo
  ];

  nixgl = {
    enable = true;
    usageWarning = false;
  };

  enterShell = ''
    set -euo pipefail
    ${geopkgs.nixGL}/bin/nixGLIntel ${pkgs.glxinfo}/bin/glxinfo | grep -i 'OpenGL version string'
    exit 0
  '';
}
