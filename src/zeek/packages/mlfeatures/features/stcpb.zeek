module Stcpb;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        stcpb: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global stcpbs: table[string] of count;

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
            if (c$id$orig_h == p$ip$src)
            {
                # Only populate on the first packet
                # to get base sequence number
                if (!(c$uid in stcpbs))
                {
                    stcpbs[c$uid] = p$tcp$seq;
                }
            }
        }
        else
        {
            if (c$id$orig_h == p$ip6$src)
            {
                # Only populate on the first packet
                # to get base sequence number
                if (!(c$uid in stcpbs))
                {
                    stcpbs[c$uid] = p$tcp$seq;
                }
            }
        }
    }
    else
    {
        stcpbs[c$uid] = 0;
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$stcpb = stcpbs[c$uid];
}
