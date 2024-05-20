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

    usageWarning = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to show OpenGL usage warning.";
    };
  };

  config = lib.mkIf cfg.enable {
    warnings = lib.mkIf cfg.usageWarning [
      ''
        OpenGL support is not available by default.
        Enable OpenGL by running a program with 'nixGLIntel <program>' wrapper.
        For example, 'nixGLIntel glxinfo' or 'nixGLIntel qgis'.
      ''
    ];

    packages = [
      cfg.package
    ];
  };
}
