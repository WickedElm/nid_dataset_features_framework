module IsSameIpsPorts;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        is_same_ips_ports: int &log &optional;
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
    Features::connection_data[c$uid]$is_same_ips_ports = 0;

    if (c$id$orig_h == c$id$resp_h && c$id$orig_p == c$id$resp_p)
    {
        Features::connection_data[c$uid]$is_same_ips_ports = 1;
    }
}
