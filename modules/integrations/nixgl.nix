{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.nixgl;
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  options.nixgl = {
    enable = lib.mkEnableOption "OpenGL support using NixGL wrapper";

    package = lib.mkOption {
      type = lib.types.package;
      default = geopkgs.nixGL;
      defaultText = lib.literalExpression "geopkgs.nixGL";
      description = "nixGL package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [
      cfg.package
    ];

    enterShell = ''
      echo "Enable OpenGL support for program by running it with 'nixGLIntel <program>' wrapper."
      echo "For example, 'nixGLIntel glxinfo' or 'nixGLIntel qgis'."
    '';
  };
}
