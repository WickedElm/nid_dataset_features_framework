module Packets;

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        packets: int &log &optional;
    };
}

###
# Specify any namespace variables
###
global packet_count: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {
    packet_count[c$uid] = 0;
}

event new_packet(c: connection, p: pkt_hdr) {
    ++packet_count[c$uid];
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$packets = packet_count[c$uid];
}
