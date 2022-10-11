module Dtcpb;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        dtcpb: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global dtcpbs: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {

}

event new_packet(c: connection, p: pkt_hdr) {
    if (p?$tcp)
    {
        if (p?$ip)
        {
            if (c$id$resp_h == p$ip$dst)
            {
                # Only populate on the first packet
                # to get base sequence number
                if (!(c$uid in dtcpbs))
                {
                    dtcpbs[c$uid] = p$tcp$seq;
                }
            }
        }
        else
        {
            if (c$id$resp_h == p$ip6$dst)
            {
                # Only populate on the first packet
                # to get base sequence number
                if (!(c$uid in dtcpbs))
                {
                    dtcpbs[c$uid] = p$tcp$seq;
                }
            }
        }
    }
    else
    {
        dtcpbs[c$uid] = 0;
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$dtcpb = dtcpbs[c$uid];
}
