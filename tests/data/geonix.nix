#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

{
  packages = [ ];

  data.fromUrl = {
    enable = true;

    datasets = [
      {
        name = "file1.zip";
        url = "https://github.com/imincik/geospatial-nix.env/archive/refs/tags/1.5.0.zip";
        curlOpts = [ "--verbose" "--header" "X-ABC: ABC" ];
        hash = "sha256-+DpaRrk58wEVXaghk1Bp1m1AMmujN+vWZ5oKyH76Gy8=";
      }

      {
        name = "file2.zip";
        url = "https://github.com/imincik/geospatial-nix.env/archive/refs/tags/1.5.1.zip";
        curlOpts = [ "--verbose" "--header" "X-ABC: ABC" ];
        hash = "sha256-2EfwIKA4d39C0DE9lxvjW0vPkj1C65CvG/yrtlDSl8w=";
      }
    ];
  };

  enterShell = ''
    set -euo pipefail
    file $(pwd)/.devenv/state/data/*file1.zip
    file $(pwd)/.devenv/state/data/*file2.zip
    exit 0
  '';
}
