#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [ ];

  enterShell = ''
    set -euo pipefail
    echo "LOCALE_ARCHIVE: $LOCALE_ARCHIVE"
    locale -a | grep -E '(en_US.UTF-8|en_US.utf8)'
    exit 0
  '';
}
