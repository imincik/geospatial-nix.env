# About Geospatial NIX

## Rationale and goals

Geospatial software environment is a complex system of software packages, tools
and libraries built to work together. For example, [GDAL](https://gdal.org/),
[PROJ](https://proj.org/) or [GEOS](https://libgeos.org/) libraries are core
components of most of the free (and many non-free) geospatial tools, desktop
applications, database systems and services. Change of such core library has
immediate impact on all depending software. On traditional systems, it is very
difficult to update them without breaking the whole environment.

Various components of this environment are usually coming from different
sources and in different versions depending on platform (Linux, Mac or Windows),
platform version (or Linux distribution and its version) and other additional
sources such as personal Linux users repositories (PPAs, AURs, ...), Homebrew,
OSGeo4W, Python PyPi, and many others.

And to make it even worse, different projects usually require different, very
often conflicting, software requirements and some of them depend on customized
packages.

The primary goal of the Geospatial NIX project is to provide cross-platform,
consistent, declarative, reproducible and up-to-date geospatial environment for
geospatial software developers, data analysts, scientists and end users which
allows to build and run software in isolated environments, created as needed by
particular use case, without breaking other things.


## What is Nix

[Nix](https://nixos.org/) is the most advanced and unique package manager.
[Nix packages (nixpkgs)](https://github.com/NixOS/nixpkgs)
is the largest collection of up-to-date free software in the world
(see [repology comparison](https://repology.org/repositories/graphs)).

Nix runs on Linux, Mac and inside of Windows WSL with very minimal interference
with host system software and configuration.

Beside the installation of Nix package manager itself, installation of any Nix
package or project environment doesn't cause any impact on the host system or
other environments. Everything what is installed by Nix is stored in the `/nix/
store` directory. All `/nix/store` content is stored under uniquely reproducible
cryptographic hash and is shared across whole Nix system for all components
requiring that exact content.

Nix ecosystem offers multiple very unique features which are not found
anywhere else.


## Geospatial NIX ecosystem

**Geospatial NIX.repo**, **Geospatial NIX.env** and **Geospatial NIX.today** are
built on top of Nix, Nix packages (Nixpkgs) and unique features and tools
provided by the Nix ecosystem.

### Geospatial NIX.repo

**Geospatial NIX.repo** is a weekly updated packages repository providing latest
versions of geospatial and non-geospatial software provided by Nixpkgs unstable
branch.

### Geospatial NIX.env

**Geospatial NIX.env** provides the easy way to create, configure and manage
the isolated geospatial software environments (think about it as a Python
virtualenv, but it contains all software which is required to run the project)
which are bug-to-bug reproducible on other machines using the same platform.

### Geospatial NIX.today

**Geospatial NIX.today** is user friendly web UI providing step-by-step
instructions to install and configure a geospatial environment in a few easy
steps.
