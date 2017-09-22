#!/bin/sh

# Set environment variables
source setup.sh

# Build LArCV
cd dep/LArCV
make -j4

# Build Jumbo
cd ../../
make -j4
