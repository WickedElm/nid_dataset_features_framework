#!/usr/bin/env bash

##
# A thin wrapper around zeek to launch  it
# with an augmented ZEEKPATH.
###

# Get user input zeek packages directory
ZEEK_PACKAGES=$1
shift

WORKING_DIR=$1
shift
cd ${WORKING_DIR}

# Print out version of zeek being run
zeek --version

# Use zeek with our local packages
zeek --help &> zeek-help
default_zeekpath=$(grep ZEEKPATH zeek-help | awk '{print $6}' | tr -d '(' | tr -d ')')
export ZEEKPATH=$ZEEK_PACKAGES:$default_zeekpath
rm -f zeek-help

# Run zeek with all remaining arguments
zeek $*
