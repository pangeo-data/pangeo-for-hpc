#!/bin/bash

if [[ $* == *--use-ip* ]]; then
    IP=$(hostname -i)  # if in reserved or interactive node
else
    IP=127.0.0.1
fi
source ~/.bashrc
conda activate aia-on-pleiades
jupyter lab --no-browser --ip=$IP --port=8888
conda deactivate
