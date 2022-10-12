module Dbytes;

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        dbytes: count &log &optional;
    };
}

###
# Specify any namespace variables
###

###
# Event handlers for feature
###

event new_connection(c: connection) {

}

event new_packet(c: connection, p: pkt_hdr) {

}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$dbytes = c$conn$resp_bytes;
}
