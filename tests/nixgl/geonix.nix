#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [
    pkgs.glxinfo
  ];

  nixgl = {
    enable = true;
  };

  enterShell = ''
    set -euo pipefail
    ${pkgs.nixGL}/bin/nixGLIntel ${pkgs.glxinfo}/bin/glxinfo | grep -i 'OpenGL version string'
    exit 0
  '';
}
