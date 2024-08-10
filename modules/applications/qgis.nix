{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.applications.qgis;
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  options.applications.qgis = {
    enable = lib.mkEnableOption "QGIS application";

    package = lib.mkOption {
      type = lib.types.package;
      default = geopkgs.qgis;
      defaultText = lib.literalExpression "geopkgs.qgis";
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
          pkgs.flask
          geopkgs.python3-fiona
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
          geopkgs.qgis-plugin-qgis2web
          geopkgs.qgis-plugin-QGIS-Cloud-Plugin
        ];
      '';
    };
  };

  config =
    let
      qgisPackage = cfg.package.override {
        qgis-unwrapped = cfg.package.passthru.unwrapped.override { withGrass = cfg.withGrass; };
        extraPythonPackages = cfg.pythonPackages;
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
