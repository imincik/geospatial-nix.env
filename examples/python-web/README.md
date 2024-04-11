# Example Python web application

This is a example web application demonstrating development of Python
application using dependencies provided by multiple sources. This example
configuration is also automatically setting pre-commit hooks when shell
environment is launched.

Application data is provided by local Python server or by PostgreSQL/PostGIS
database backend.


## Dependencies

### Provided by Geonix

* shapely

### Provided by Nixpkgs

* matplotlib

### Provided by Poetry

* black
* flask
* isort
* pytest


## Configuration

Environment configuration is done via `geonix.nix` file. Configuration is based
on modules provided by
[geospatial-nix.env](https://github.com/imincik/geospatial-nix.env/wiki/Configuration).


## Usage

### Development environment

* Enter development shell
 (this will install Python Poetry environment during a first run)

```
nix run .#geonixcli -- shell
```

### Services (with local data backend)

* Launch services

```
nix run .#geonixcli -- up
```

### Services (with database data backend)

* Launch services

```
BACKEND=db nix run .#geonixcli -- up
```

### Run in container

* Build container image and import it in Docker

```
nix run .#geonixcli -- container shell
```

* Run container

```
docker run --rm -p 5000:5000 shell:latest
```


## More info

* [Nix documentation](https://nix.dev/)
* [geospatial-nix.env](https://github.com/imincik/geospatial-nix.env)
