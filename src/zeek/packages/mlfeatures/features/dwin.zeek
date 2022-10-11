module Dwin;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        dwin: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global dwins: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {
    dwins[c$uid] = 0;
}

event new_packet(c: connection, p: pkt_hdr) {
    if (p?$tcp)
    {
        if (p?$ip)
        {
            if (c$id$resp_h == p$ip$dst)
            {
                if (p$tcp$win > dwins[c$uid])
                {
                    dwins[c$uid] = p$tcp$win;
                }
            }
        }
        else
        {
            if (c$id$resp_h == p$ip6$dst)
            {
                if (p$tcp$win > dwins[c$uid])
                {
                    dwins[c$uid] = p$tcp$win;
                }
            }
        }
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$dwin = dwins[c$uid];
}
