module Label;

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        label: int &log &optional;
    };
}

###
# Specify any namespace variables
###

###
# Event handlers for feature
###

event connection_established(c: connection) {

}

event new_packet (c: connection, p: pkt_hdr) {

}

event connection_state_remove(c: connection) &priority=-10 
{
    Features::connection_data[c$uid]$label = 1;
}
