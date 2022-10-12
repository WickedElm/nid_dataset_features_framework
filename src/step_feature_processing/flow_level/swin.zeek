module Swin;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        swin: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global swins: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {
    swins[c$uid] = 0;
}

event new_packet(c: connection, p: pkt_hdr) {
    if (p?$tcp)
    {
        if (p?$ip)
        {
            if (c$id$orig_h == p$ip$src)
            {
                if (p$tcp$win > swins[c$uid])
                {
                    swins[c$uid] = p$tcp$win;
                }
            }
        }
        else
        {
            if (c$id$orig_h == p$ip6$src)
            {
                if (p$tcp$win > swins[c$uid])
                {
                    swins[c$uid] = p$tcp$win;
                }
            }
        }
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$swin = swins[c$uid];
}
