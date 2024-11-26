{ inputs, config, lib, pkgs, ... }:

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
