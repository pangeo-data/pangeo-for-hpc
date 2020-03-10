# Dask on NASA Pleiades

This guide will walk through setting up a Dask cluster to run on the NASA Pleiades cluster. It includes instructions for installing Anaconda, setting up a notebook, and configuring a Dask cluster.

## SSH Tunnelling

First, set up SSH passthrough following the instructions provided by NASA HECC [here](https://www.nas.nasa.gov/hecc/support/kb/setting-up-ssh-passthrough_232.html).

```shell
$ ssh -L 9999:127.0.0.1:8888 pfe
```

Once you've logged in, clone this directory into your home directory,

```shell
$ git clone https://github.com/pangeo-data/pangeo-for-hpc.git $HOME/pangeo-for-hpc
```

## Installing Anaconda

Next, install the Anaconda distribution of Python,

```shell
$ ./install-conda.sh
```

This script downloads and installs [the Miniconda distribution](https://docs.conda.io/en/latest/miniconda.html) and creates an environment called `pangeo` with the packages necessary for setting up Jupyterlab and a Dask cluster. You'll likely want to add additional packages to this environment or create a new custom environment for your specific needs.


## Reserving a Node

To run the actual notebook, we'll reserve a whole node. To reserve a dedicated Ivy Bridge compute node for 1 hour,

```shell
$ pbs_rfe --duration 1 --model ivy
```

Once you've successfully made your reservation and it has started, log in to your reserved node, making sure to again forward the 8888 port,

```shell
$ RFE_HOST=(`pbs_rfe which`)
$ RFE_IP=(`ssh $RFE_HOST hostname -i`)
$ ssh -L 127.0.0.1:8888:${RFE_IP}:8888 $RFE_HOST
```

## Starting the Notebook

Once you've logged into your reserved node, start a screen session 

```shell
screen
```

This lets you log out of your SSH session without killing your notebook. Pressing `CTRL+a,CTRL+d` let's you exit a screen without killing the session. To log back into an existing screen session, use `screen -r`. You can learn more about `screen` [here](https://linux.die.net/man/1/screen). 

Before starting the notebook, it is best to set a password. To do this, 

```shell
$ jupyter notebook password
```

Finally, start Jupyter Lab,

```shell
$ ./start-jupyter.sh
```

Navigate to `http://127.0.0.1:9999/lab?` in the browser on your local machine to access your notebook. You will need to enter the password you set above.

## Configuring a Dask Cluster

The configuration for the Dask cluster lives in `jobqueue.yml`. To tell Dask where it lives, you can set the following environment variable,

```shell
$ export DASK_ROOT_CONFIG=$HOME/pangeo-for-hpc/pleiades
```

where it is assumed that you've cloned this repo into your `$HOME` directory. For more information on `dask-jobqueue` configuration, see [this page](https://jobqueue.dask.org/en/latest/configuration-setup.html).
