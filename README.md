# conda-recipes
Conda recipes for the sanger-pathogens channel: https://anaconda.org/sanger-pathogens

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-brightgreen.svg)](https://github.com/sanger-pathogens/conda-recipes/blob/master/LICENSE)   

## Contents
  * [Introduction](#introduction)
  * [Usage](#usage)
  * [License](#license)
  * [Feedback/Issues](#feedbackissues)

## Introduction
Conda is an open source package and environment management system. This repository hosts recipes for packages on the [sanger-pathogens](https://anaconda.org/sanger-pathogens) Anaconda channel.

### Recipes

Conda recipes that are to be made available as packages on the [sanger-pathogens](https://anaconda.org/sanger-pathogens) Anaconda channel are stored in the **recipes** directory. This follows the same subdirectory structure as Bioconda and conda-forge.

### Environments

Conda environments are collections of their packages and dependencies and are found in the **environments** directory. The environments that are in production are in the **production** directory. The package lists which can be used to generate these environments are found in the **package-lists** directory.

The environments in the production directory are built on linux machines. For MacOS specific environments there is a separate **local-osx** directory.

Before building the environments, make sure that you have the following Conda channels set up.

```
conda config --add channels 'defaults'   # lowest priority
conda config --add channels 'bioconda'
conda config --add channels 'conda-forge'
conda config --add channels 'sanger-pathogens'   # highest priority
```

To build the sanger-pathogens environment from the sanger-pathogens package list:

```
conda create -n sanger-pathogens
conda install --yes --file package-lists/sanger-pathogens.txt
```

To export the environment:

```
conda env export -n sanger-pathogens | cut -f -2 -d "=" | grep -v "prefix" > sanger-pathogens.yml
```

For the sanger-pathogens-deployment environment, the package perl-yaml-xs comes from a different channel at the moment so there is an extra step in the build even though the package is in the requirements file.

```
conda create -n sanger-pathogens-deployment
conda install --yes --file package-lists/sanger-pathogens-deployment.txt
conda install -n sanger-pathogens-deployment -c eumetsat perl-yaml-xs
```

Alternatively, you can add the eumetsat channel before running the first `conda install` but you will need to make sure it has the lowest priority.

## Usage
To use the recipes and/or their corresponding packages you will need to install [Conda](https://conda.io).

## License
The Conda recipes in this repository are freely available, licensed under [GPL v3](https://github.com/sanger-pathogens/conda-recipes/blob/master/LICENSE).

## Feedback/Issues
Please report any issues to the [issues page](ttps://github.com/sanger-pathogens/conda-recipes/issues) or email path-help@sanger.ac.uk.
