# Dask on NASA Pleiades

This guide will walkthrough setting up a Dask cluster to run on the NASA Pleiades cluster. It includes instructions for setting installing Anaconda, setting up a notebook, and configuring a Dask cluster.

## SSH Tunnelling

First, set up SSH passthrough following the instructions provided by NASA HECC [here](https://www.nas.nasa.gov/hecc/support/kb/setting-up-ssh-passthrough_232.html).


```shell
$ ssh -L 9999:127.0.0.1:8888 pfe
```

## Installing Anaconda

Install Miniconda,

```shell
$ curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ bash Miniconda3-latest-Linux-x86_64.sh
```

Then, build an environment from the file provided in this repository,

```shell
$ conda env create -f environment.yml
$ conda activate pangeo
```

## Reserving a Front End Node

## Starting the Notebook
