##! This script sets up a log for machine learning features.
##! It is initially empty with the user expected to create a zeek
##! script per feature and add it to the record structure for this log.

module Features;

export {
	# The connection logging stream identifier.
	redef enum Log::ID += { LOG };

	# A default logging policy hook for the stream.
	global log_policy: Log::PolicyHook;

	# Include connection id;  Other features filled in later
	type Info: record {
        id: conn_id &log;
	};

	# Event that can be handled to access the :zeek:type:`Features::Info`
	# record as it is sent on to the logging framework.
	global log_conn_features: event(rec: Info);
    
    # Our structure to contain output data
    # We use c$uid as our identifier for table entries
    global connection_data: table[string] of Features::Info;
}

# Create the log stream
event zeek_init() &priority=5
{
	Log::create_stream(Features::LOG, [$columns=Info, $ev=log_conn_features, $path="features", $policy=log_policy]);
}

# Initialize the features structure
# Priority used to ensure it occurs before any features written
event connection_state_remove(c: connection) &priority=-5
{
    connection_data[c$uid] = Features::Info($id=c$id);
}

# Write a line to the log
# Priority used to ensure it occurs after all features have been handled
event connection_state_remove(c: connection) &priority=-15
{
    local features = connection_data[c$uid];
	Log::write(Features::LOG, features);
}
