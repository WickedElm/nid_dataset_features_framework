import ipdb
import pandas as pd
import sys

###
# Read in arguments
###
working_directory = sys.argv[1]
output_file_name = sys.argv[2]

###
# Read in our sources of data
###
zeek_features = pd.read_csv(f'{working_directory}/features.csv')
zeek_ct_src_ltm_column = pd.read_csv(f'{working_directory}/ct_src_ltm.csv')
argus_features = pd.read_csv(f'{working_directory}/argus_features.csv')

###
# Perform pre-processing to make matching easier
###
# Add new columns derived from zeek flows to zeek dataframe
zeek_features['ct_src_ltm'] = zeek_ct_src_ltm_column['ct_src_ltm']

# Round start time column to match precision of zeek data
argus_features.StartTime = argus_features.StartTime.apply(round)

# Drop rows with na values
argus_features.dropna(inplace=True)
zeek_features.dropna(inplace=True)

# Make these strings to account for hex values in argus files
# - This just allows us to join on the columns
zeek_features['id.orig_p'] = zeek_features['id.orig_p'].astype(str)
zeek_features['id.resp_p'] = zeek_features['id.resp_p'].astype(str)

###
# Merge data on unique columns to match flows 
###
merged_features = pd.merge(
    zeek_features, 
    argus_features, 
    how='inner', 
    left_on=['id.orig_h', 'id.orig_p', 'id.resp_h', 'id.resp_p', 'proto', 'stime'], 
    right_on=['SrcAddr', 'Sport', 'DstAddr', 'Dport', 'Proto', 'StartTime']
)

###
# Clean up duplicated columns
###
merged_features = merged_features.drop(columns=['SrcAddr', 'Sport', 'DstAddr', 'Dport', 'Proto', 'StartTime'])

###
# Make label columns last
###
merged_features = merged_features[[c for c in merged_features.columns if c != 'label'] + ['label']]

###
# Save out merged file
###
merged_features.to_csv(f'{working_directory}/{output_file_name}', index=False)
