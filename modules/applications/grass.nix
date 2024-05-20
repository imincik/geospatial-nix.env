{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.applications.grass;
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  options.applications.grass = {
    enable = lib.mkEnableOption "GRASS application";

    package = lib.mkOption {
      type = lib.types.package;
      default = geopkgs.grass;
      defaultText = lib.literalExpression "geopkgs.grass";
      description = "GRASS package to use.";
    };

    plugins = lib.mkOption {
      # This could be 'type = with lib.types; nullOr (listOf package);', but we
      # keep consistency with qgis which is using 'ps: []' function.
      type = with lib.types; nullOr (functionTo (listOf package));
      default = null;
      description = "List of GRASS plugins (addons) to include.";
      example = lib.literalExpression ''
        plugins: [
          geopkgs.grass-plugin-r-hydrodem
          geopkgs.grass-plugin-v-histogram
        ];
      '';
    };
  };

  config =
    let
      stateDir = "${config.env.DEVENV_STATE}/grass";

      rcFile = pkgs.writeText "grass-rcfile" ''
        GISDBASE: ${stateDir}/grassdata
        LOCATION_NAME: world_latlong_wgs84
        MAPSET: PERMANENT
      '';

      pluginsCollection = pkgs.symlinkJoin {
        name = "grass-plugins-collection";
        # This could be 'paths = cfg.plugins;', but we need to get list from
        # 'ps: []' function.
        paths = cfg.plugins "give-me-a-list-of-plugins";
      };

    in
    lib.mkIf cfg.enable
      {
        packages = [
          cfg.package
        ];

        prepareShell = ''
          mkdir -p ${stateDir}

          if [ ! -d ${stateDir}/grassdata ]; then
            ${cfg.package}/bin/grass --text -c EPSG:4326 -e ${stateDir}/grassdata/world_latlong_wgs84
            cat ${rcFile} > ${stateDir}/.grass${lib.versions.major cfg.package.version}/rc
          fi

          echo "GRASS GISDBASE: ${stateDir}/grassdata ."
        '';

        env.GRASS_CONFIG_DIR = stateDir;
        env.GRASS_ADDON_BASE = pluginsCollection;
      };
}
