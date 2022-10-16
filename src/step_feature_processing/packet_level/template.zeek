module Template;

###
# Alter this template to create a feature script.
# - Replace Template and template with desired feature
#   name
# - Ensure the name of the file also matches the feature name
###

###
# Add new feature to the connection record
###

export {
    redef record Features::Info += {
        template: int &log &optional;
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
    Features::connection_data[c$uid]$template = "Populate with data here";
}
