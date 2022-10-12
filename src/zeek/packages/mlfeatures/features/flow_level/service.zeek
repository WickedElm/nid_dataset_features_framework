module Service;

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        service: string &log &optional;
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
    if (c$conn?$service)
    {
        Features::connection_data[c$uid]$service = c$conn$service;
    }
    else
    {
        Features::connection_data[c$uid]$service = "other";
    }
}
