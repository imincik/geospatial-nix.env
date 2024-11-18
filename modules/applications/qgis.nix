{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.applications.qgis;

in
{
  options.applications.qgis = {
    enable = lib.mkEnableOption "QGIS application";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.qgis;
      defaultText = lib.literalExpression "pkgs.qgis";
      description = "QGIS package to use.";
    };

    withGrass = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GRASS GIS support.";
    };

    pythonPackages = lib.mkOption {
      type = with lib.types; nullOr (functionTo (listOf package));
      default = null;
      description = "List of extra Python packages to include.";
      example = lib.literalExpression ''
        packages: [
          pkgs.python3Packages.flask
          pkgs.python3Packages.fiona
        ];
      '';
    };

    plugins = lib.mkOption {
      # This could be 'type = with lib.types; nullOr (listOf package);', but we
      # keep consistency with pythonPackages which is 'ps: []' function.
      type = with lib.types; nullOr (functionTo (listOf package));
      default = null;
      description = "List of QGIS plugins to include.";
      example = lib.literalExpression ''
        plugins: [
          pkgs.qgisPlugins.qgis2web
          pkgs.qgisPlugins.QGIS-Cloud-Plugin
        ];
      '';
    };
  };

  config =
    let
      qgisPackage = cfg.package.override {
        extraPythonPackages = cfg.pythonPackages;
        withGrass = cfg.withGrass;
      };

      pluginsCollection = pkgs.symlinkJoin {
        name = "qgis-plugins-collection";
        # This could be 'paths = cfg.plugins;', but we need to get list from
        # 'ps: []' function.
        paths = cfg.plugins "give-me-a-list-of-plugins";
      };
    in

    lib.mkIf cfg.enable {
      packages = [
        qgisPackage
      ];

      env.QGIS_PLUGINPATH = pluginsCollection;
    };
}
