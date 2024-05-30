{ config, pkgs, lib, ... }:

let
  cfg = config.data.fromUrl;

in
{
  options.data.fromUrl = {
    enable = lib.mkEnableOption "fetching file datasets from URL";

    datasets = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = ''
              The name of the output file. If no name is given, `url` basename
              is used.
            '';
          };

          url = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "Dataset URL.";
          };

          curlOpts = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = ''
              Additional curl options needed for the download to succeed.
            '';
          };

          hash = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = ''
              Dataset file sha256 hash. If no hash is given, it will be computed
              and printed in the error message.
            '';
          };
        };
      });
      default = [ ];
      description = ''
        Fetch file datasets from URL. Downloaded data will be available in
        `.devenv/state/data` directory.
      '';
      example = lib.literalExpression ''
        [
          {
            name = "file1.zip";
            url = "https://example.com/data1.zip";
            curlOpts = [ "--basic" "--user" "user:password" ];
            hash = "sha256-+DpaRrk58wEVXaghk1Bp1m1AMmujN+vWZ5oKyH76Gy8=";
          }

          {
            name = "file2.zip";
            url = "https://example.com/data2.zip";
            curlOpts = [ "--basic" "--user" "user:password" ];
            hash = "sha256-2EfwIKA4d39C0DE9lxvjW0vPkj1C65CvG/yrtlDSl8w=";
          }
        ]
      '';
    };
  };

  config =
    let
      stateDir = "${config.env.DEVENV_STATE}/data";

      fetchData = dataset: pkgs.fetchurl {
        name = dataset.name;
        url = dataset.url;
        curlOptsList = dataset.curlOpts;
        hash = dataset.hash;
      };

    in
    lib.mkIf cfg.enable {
      prepareShell = ''
        rm --recursive --force ${stateDir}
        mkdir -p ${stateDir}
      ''
      # symlink commands
      + lib.concatMapStrings
        (dataset: ''
          ln --symbolic --force ${dataset} ${stateDir}/$(basename ${dataset}) 
        '')
        (builtins.map fetchData cfg.datasets);
    };
}
