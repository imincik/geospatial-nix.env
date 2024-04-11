#
# Use https://geospatial-nix.today to add more configuration.
#

{ inputs, config, lib, pkgs, ... }:

let
  # Geospatial NIX packages
  geopkgs = inputs.geonix.packages.${pkgs.system};

  python = pkgs.python3.withPackages (p: [
    # packages from Geospatial NIX
    geopkgs.python3-psycopg
    geopkgs.python3-shapely

    # packages from Nixpkgs 
    pkgs.python3.pkgs.matplotlib
  ]);

in
{
  packages = [ ];

  languages.python = {
    enable = true;
    package = python;
    poetry.enable = true;
    poetry.activate.enable = true;
    poetry.install.enable = true;
  };

  services.postgres = {
    enable = !config.container.isBuilding;  # don't include in container
    listen_addresses = "127.0.0.1";
    port = 15432;

    extensions = e: [ geopkgs.postgresql-postgis ];

    settings =  {
      # verbose logging
      log_connections = "on";
      log_duration = "on";
      log_statement = "all";
      log_disconnections = "on";
      log_destination = "stderr";
    };
  };

  env.PYTHONPATH = "${python}/${python.sitePackages}";
  env.NIX_PYTHON_SITEPACKAGES = "${python}/${python.sitePackages}";

  processes.flask-run.exec = ''
    ${config.languages.python.poetry.package}/bin/poetry run flask \
      --app src/python_app run \
      --host 0.0.0.0 \
      ${lib.optionalString (!config.container.isBuilding) "--reload"}
  '';

  containers.shell = {
    # don't copy `.venv` directory to image (it is not portable)
    copyToRoot = builtins.filterSource (path: type: baseNameOf path != ".venv") ./.;
    startupCommand = config.procfileScript;
  };

  # Uncomment this to enable pre-commit hooks
  # pre-commit.hooks = {
  #   black.enable = true;
  # };
}
