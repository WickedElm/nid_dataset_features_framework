###
# Set up our machine learning features log to mirror basic structure of conn.log.
###

@load ./main

###
# Reference the directories that contain our feature scripts.
###

@load ../../../step_feature_processing/packet_level
@load ../../../step_feature_processing/flow_level
@load ../../../step_feature_processing/network_level

###
# Reference the  directories that contain our labeling scripts.
###

@load ../../../step_label_processing/packet_level
@load ../../../step_label_processing/flow_level
@load ../../../step_label_processing/network_level
