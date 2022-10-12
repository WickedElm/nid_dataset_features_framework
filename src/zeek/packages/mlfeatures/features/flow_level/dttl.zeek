module Dttl;

###
# Add new feature to the connection record
# - We take the max ttl of the connection by checking packets
###

export {
    redef record Features::Info += {
        dttl: count &log &optional;
    };
}

###
# Specify any namespace variables
###
global dttls: table[string] of count;

###
# Event handlers for feature
###

event new_connection(c: connection) {
    dttls[c$uid] = 0;
}

event new_packet(c: connection, p: pkt_hdr) {
    if (p?$ip)
    {
        if (c$id$resp_h == p$ip$dst)
        {
            if (p$ip$ttl > dttls[c$uid])
            {
                dttls[c$uid] = p$ip$ttl;
            }
        }
    }

    if (p?$ip6)
    {
        if (c$id$resp_h == p$ip6$dst)
        {
            if (p$ip6$hlim > dttls[c$uid])
            {
                dttls[c$uid] = p$ip6$hlim;
            }
        }
    }
}

event connection_state_remove(c: connection) &priority=-10
{
    Features::connection_data[c$uid]$dttl = dttls[c$uid];
}
