module Sttl;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        sttl: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global sttls: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {
    sttls[c$uid] = 0;
}

event new_packet(c: connection, p: pkt_hdr) {
    if (p?$ip)
    {
        if (c$id$orig_h == p$ip$src)
        {
            if (p$ip$ttl > sttls[c$uid])
            {
                sttls[c$uid] = p$ip$ttl;
            }
        }
    }

    if (p?$ip6)
    {
        if (c$id$orig_h == p$ip6$src)
        {
            if (p$ip6$hlim > sttls[c$uid])
            {
                sttls[c$uid] = p$ip6$hlim;
            }
        }
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$sttl = sttls[c$uid];
}
