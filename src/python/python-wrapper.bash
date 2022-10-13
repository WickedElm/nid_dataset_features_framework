#!/usr/bin/env bash

##
# A thin wrapper to run python scripts
# specified in a configuration file.
###

WORKING_DIR=$1
FEATURES_DIR=$2
DATA_FILE=$3

# Parse our features file for use as an input argument
FEATURES_FILE=${FEATURES_DIR}/__load__.python
FEATURES=$(cat ${FEATURES_FILE}  | grep -v "#" | grep -v '^[[:space:]]*$')

if [ ${#FEATURES} -gt 0 ];
then
    for python_script in `echo ${FEATURES}`; do
        echo ""
        echo "Executing [python ${FEATURES_DIR}/${python_script}.py ${WORKING_DIR} ${DATA_FILE}]"
        python ${FEATURES_DIR}/${python_script}.py ${WORKING_DIR} ${DATA_FILE}
    done
fi
