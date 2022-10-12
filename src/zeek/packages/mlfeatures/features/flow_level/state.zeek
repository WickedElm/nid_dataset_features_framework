module State;

###
# Add new feature to the connection record
# - This will likely deviate from the original values of
#   UNSW-NB15 as we use zeek's interpretation of connection state.
###

export {
    redef record Features::Info += {
        state: string &log &optional;
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
    Features::connection_data[c$uid]$state = c$conn$conn_state;
}
