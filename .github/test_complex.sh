#!/bin/bash

DIR=$(dirname $0)
wget -O $DIR/input_files.tar.gz http://umich.edu/~mdolaboratory/repo_files/ADflow/adflow_input_files.tar.gz
tar -xzf $DIR/input_files.tar.gz
export PETSC_ARCH=complex-opt-\$COMPILERS-\$PETSCVERSION
testflo -v . -m "cmplx_test*" -n 1