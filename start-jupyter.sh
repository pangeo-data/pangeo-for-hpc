#!/bin/bash

IP=$(hostname -i)
source ~/.bashrc
conda activate pangeo
jupyter lab --no-browser --ip=$IP --port=8888
conda deactivate
