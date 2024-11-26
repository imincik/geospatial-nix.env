{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.services.jupyter;

  # Inspired by:
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/development/jupyter/kernel-options.nix
  kernelOptions = with lib; {
    freeformType = (pkgs.formats.json { }).type;

    options = {
      displayName = mkOption {
        type = types.str;
        default = "";
        example = literalExpression ''
          "Python 3 for Data Science"
        '';
        description = ''
          Name that will be shown to the user.
        '';
      };

      language = mkOption {
        type = types.str;
        example = "python";
        description = ''
          Language of the environment. Typically the name of the binary.
        '';
      };

      argv = mkOption {
        type = types.listOf types.str;
        example = [
          "{env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        description = ''
          Command and arguments to start the kernel.
        '';
      };

      env = mkOption {
        type = types.attrsOf types.str;
        default = { };
        example = { OMP_NUM_THREADS = "1"; };
        description = ''
          Environment variables to set for the kernel.
        '';
      };

      logo32 = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = literalExpression ''"''${env}/''${env.sitePackages}/ipykernel/resources/logo-32x32.png"'';
        description = ''
          Path to 32x32 logo png.
        '';
      };

      logo64 = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = literalExpression ''"''${env}/''${env.sitePackages}/ipykernel/resources/logo-64x64.png"'';
        description = ''
          Path to 64x64 logo png.
        '';
      };

      extraPaths = mkOption {
        type = types.attrsOf types.path;
        default = { };
        example = literalExpression ''"{ examples = ''${env}/''${env.sitePackages}/IRkernel/kernelspec/kernel.js"; }'';
        description = ''
          Extra paths to link in kernel directory.
        '';
      };
    };
  };

  defaultKernel = {
    python3 =
      let
        env = pkgs.python3.withPackages (ps: with ps; [
          ipykernel
        ]);
      in
      {
        displayName = "Default Python kernel";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
  };

  stateDir = "${config.devenv.state}/jupyter";

  configFile = pkgs.writeText "jupyter_config.py" ''
    c = get_config()

    ${cfg.rawConfig}
  '';

  startScript = pkgs.writeShellScriptBin "start-jupyter" ''
    set -euo pipefail

    mkdir -p ${stateDir}/jupyter

    PATH=${config.devenv.profile}/bin:$PATH
    ${cfg.package}/bin/jupyter-lab \
      --ip=${cfg.ip} \
      --port=${toString cfg.port} --port-retries 0 \
      --config=${configFile}
  '';

in
{
  options.services.jupyter = {
    enable = lib.mkEnableOption "Jupyter server";

    package = lib.mkOption {
      type = lib.types.package;
      description = "Which Jupyter package to use.";
      default = pkgs.python3Packages.jupyterlab;
      defaultText = lib.literalExpression "pkgs.python3Packages.jupyterlab;";
    };

    kernels = lib.mkOption {
      type = lib.types.nullOr (lib.types.attrsOf (lib.types.submodule kernelOptions));

      default = null;
      example = lib.literalExpression ''
        {
          geospatial =
            let
              env = pkgs.python3.withPackages (p: with p; [
                ipykernel
                pkgs.python3Packages.gdal
                pkgs.python3Packages.geopandas
                pkgs.python3Packages.fiona
                pkgs.python3Packages.rasterio
              ]);
          in
          {
            displayName = "Geospatial Python kernel";
            language = "python";
            argv = [
              "''${env.interpreter}"
              "-m"
              "ipykernel_launcher"
              "-f"
              "{connection_file}"
            ];
            logo32 = "''${env}/''${env.sitePackages}/ipykernel/resources/logo-32x32.png";
            logo64 = "''${env}/''${env.sitePackages}/ipykernel/resources/logo-64x64.png";
          };

          other =
            let
              env = pkgs.python3.withPackages (p: with p; [
                ipykernel
                pandas
              ]);
          in
          {
            displayName = "Other Python kernel";
            language = "python";
            argv = [
              "''${env.interpreter}"
              "-m"
              "ipykernel_launcher"
              "-f"
              "{connection_file}"
            ];
            logo32 = "''${env}/''${env.sitePackages}/ipykernel/resources/logo-32x32.png";
            logo64 = "''${env}/''${env.sitePackages}/ipykernel/resources/logo-64x64.png";
          };
        }
      '';
      description = ''
        Declarative kernel configurations.

        Kernels can be declared in any language that supports and has the
        required dependencies to communicate with a Jupyter server. In python's
        case, it means that ipykernel package must always be included in the
        list of packages of the targeted environment.
      '';
    };

    ip = lib.mkOption {
      type = lib.types.str;
      default = "localhost";
      description = ''
        IP address Jupyter will be listening on.
      '';
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8888;
      description = ''
        Port number Jupyter will be listening on.
      '';
    };

    rawConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Raw Jupyter configuration.
      '';
      example = lib.literalExpression ''
        c.ServerApp.answer_yes = False
        c.ServerApp.open_browser = False
      '';
    };
  };

  config =
    let
      kernels = (pkgs.jupyter-kernel.create {
        definitions =
          if cfg.kernels != null
          then defaultKernel // cfg.kernels
          else defaultKernel;
      });

    in
    lib.mkIf cfg.enable {
      env.JUPYTER_PATH = toString kernels;
      env.JUPYTER_DATA_DIR = stateDir;

      processes.jupyter = {
        exec = "${startScript}/bin/start-jupyter";
      };
    };
}
