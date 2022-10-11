###
# Set up our machine learning features log to piggy-back off of conn.log
###

@load ./main

###
# Each script below represents the definition of a single feature
# included in our features log.
###

@load ./features/proto
@load ./features/dur
@load ./features/packets
@load ./features/sbytes
@load ./features/dbytes
@load ./features/service
@load ./features/spkts
@load ./features/dpkts
@load ./features/sttl
@load ./features/dttl
@load ./features/swin
@load ./features/dwin
@load ./features/stcpb
@load ./features/dtcpb
@load ./features/state
@load ./features/stime
@load ./features/ltime
@load ./features/sload
@load ./features/dload
@load ./features/is_same_ips_ports

###
# Below are the explicit labeling routines for the data.
###

@load ./label/label
