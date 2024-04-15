{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  name = "geospatial-nix.env-docs";

  packages = [ ];

  languages.python = {
    enable = true;
    package = pkgs.python3.withPackages (
      p: [
        pkgs.python3Packages.mkdocs
      ]
    );
  };

  processes = {
    docs.exec = "mkdocs serve";
  };
}
