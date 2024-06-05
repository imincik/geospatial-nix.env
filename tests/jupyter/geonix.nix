#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};

in
{
  packages = [ ];

  services.jupyter = {
    enable = true;

    kernels = {
      geospatial =
        let
          env = (pkgs.python3.withPackages (ps: with ps; [
            ipykernel
            geopkgs.python3-gdal
            geopkgs.python3-geopandas
            geopkgs.python3-fiona
            geopkgs.python3-rasterio
          ]));
        in
        {
          displayName = "Geospatial Python kernel";
          language = "python";
          argv = [
            "${env.interpreter}"
            "-m"
            "ipykernel_launcher"
            "-f"
            "{connection_file}"
          ];
          logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
        };
    };

    rawConfig = ''
      c.ServerApp.open_browser = False
    '';
  };
}
