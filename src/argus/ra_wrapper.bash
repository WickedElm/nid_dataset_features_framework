#!/usr/bin/env bash

##
# A thin wrapper around the argus client ra to launch  it
# with specified features from the argus file.
# The configuration file is simply the list of argus fields to
# include in the output.  See man ra for fields available.
###

WORKING_DIR=$1
ARGUS_FILENAME=$2
OUTPUT_FILENAME=$3
FEATURES_FILE=$4

# Parse our features file for use as an input argument
FEATURES=$(cat ${FEATURES_FILE}  | grep -v "#" | grep -v '^[[:space:]]*$' | awk '{print $1}' | tr '\n' ' ')

if [ ${#FEATURES} -gt 0 ];
then
    FEATURES="-s ${FEATURES} "
fi

# Run zeek with all remaining arguments
CMD="ra -c , -n -u -r ${WORKING_DIR}/${ARGUS_FILENAME} ${FEATURES} > ${WORKING_DIR}/${OUTPUT_FILENAME}"

echo ""
echo "Executing [${CMD}]"

ra -c , -n -u -r ${WORKING_DIR}/${ARGUS_FILENAME} ${FEATURES} > ${WORKING_DIR}/${OUTPUT_FILENAME}
