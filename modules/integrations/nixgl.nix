{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.nixgl;
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  options.nixgl = {
    enable = lib.mkEnableOption "the OpenGL support using NixGL";

    package = lib.mkOption {
      type = lib.types.package;
      default = geopkgs.nixGL;
      defaultText = lib.literalExpression "geopkgs.nixGL";
      description = "The nixGL package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [
      cfg.package
    ];

    enterShell = ''
      echo "Enable OpenGL support for your program by running it with 'nixGLIntel <program>'"
      echo "prefix. For example, 'nixGLIntel glxinfo'."
    '';
  };
}
