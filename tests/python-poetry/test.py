# Poetry in Nix is patched to actively unset PYTHONPATH variable. If you want to
# use Python modules provided by Nixpkgs add NIX_PYTHON_SITEPACKAGES on path as
# below or create a wrapper script to set PYTHONPATH=NIX_PYTHON_SITEPACKAGES.
import os
import sys

nix_python_sitepackages = str(os.environ.get("NIX_PYTHON_SITEPACKAGES"))
sys.path.append(nix_python_sitepackages)

from osgeo import gdal
import flask

print(gdal)
print(flask)
