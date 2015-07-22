#!/bin/bash
#
# This script needs to be _sourced_ from travis.yml
# so $PATH is set up correctly
#

set -e

# keep the pkginfo cache database outside the conda-lsst dir
# so Travis can cache it easily.
mkdir -p pkginfo-cache

# Prepare conda-lsst environment
rm -rf conda-lsst
git clone https://github.com/mjuric/conda-lsst
cd conda-lsst
./bin/bootstrap.sh
export PATH="$PWD/bin:$PWD/miniconda/bin:$PATH"
hash -r
conda config --set always_yes yes --set changeps1 no
conda config --add channels http://eupsforge.net/conda/dev
conda install lsst-apps
conda install lsst-sims-maf
