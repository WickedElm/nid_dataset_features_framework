module Stime;

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        stime: int &log &optional;
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
    Features::connection_data[c$uid]$stime = double_to_int(time_to_double(c$conn$ts));
}
