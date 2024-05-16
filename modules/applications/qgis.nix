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
      description = "The QGIS package to use.";
    };

    plugins = lib.mkOption {
      type = with lib.types; nullOr (listOf package);
      default = null;
      description = "List of QGIS plugins to include.";
    };
  };

  config =
    let
      pluginsCollection = pkgs.symlinkJoin {
        name = "qgis-plugins-collection";
        paths = cfg.plugins;
      };
    in

    lib.mkIf cfg.enable {
      packages = [
        cfg.package
      ];

      env.QGIS_PLUGINPATH = pluginsCollection;
    };
}
