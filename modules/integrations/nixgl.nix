{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.nixgl;

in
{
  options.nixgl = {
    enable = lib.mkEnableOption "OpenGL support using NixGL wrapper";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nixGL;
      defaultText = lib.literalExpression "pkgs.nixGL";
      description = "nixGL package to use.";
    };

    usageHint = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to show nixGL usage hint.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [
      cfg.package
    ];

    prepareShell = lib.optionalString cfg.usageHint ''
      echo "HINT: OpenGL support is not available by default."
      echo "Enable OpenGL by running a program with 'nixGLIntel <program>' wrapper."
      echo "For example, 'nixGLIntel glxinfo' or 'nixGLIntel qgis'."
    '';
  };
}
