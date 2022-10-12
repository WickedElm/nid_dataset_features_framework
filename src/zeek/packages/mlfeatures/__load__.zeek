###
# Set up our machine learning features log to piggy-back off of conn.log
###

@load ./main

###
# Each script below represents the definition of a single feature
# included in our features log.
###

@load ./features/flow_level/proto
@load ./features/flow_level/dur
@load ./features/flow_level/packets
@load ./features/flow_level/sbytes
@load ./features/flow_level/dbytes
@load ./features/flow_level/service
@load ./features/flow_level/spkts
@load ./features/flow_level/dpkts
@load ./features/flow_level/sttl
@load ./features/flow_level/dttl
@load ./features/flow_level/swin
@load ./features/flow_level/dwin
@load ./features/flow_level/stcpb
@load ./features/flow_level/dtcpb
@load ./features/flow_level/state
@load ./features/flow_level/stime
@load ./features/flow_level/ltime
@load ./features/flow_level/sload
@load ./features/flow_level/dload
@load ./features/flow_level/is_same_ips_ports

###
# Below are the explicit labeling routines for the data.
###

@load ./label/flow_level/label
