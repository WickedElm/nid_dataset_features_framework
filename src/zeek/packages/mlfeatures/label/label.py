import io
import pandas as pd
import subprocess

###
# Read in ground truth data
###

ground_truth_df = pd.read_csv('./NUSW-NB15_GT.csv')

###
# Read in actual data
###

# Get original data
zeek_data = subprocess.check_output(['cat ../../../../pcaps/17-2-2015_1/features.log | zeek-cut -m'], shell=True)
zeek_data_df = pd.read_csv(io.BytesIO(zeek_data), sep='\t')

###
# Update label column in actual data
###

# This is inefficient but just for demonstration purposes...
for row_data in ground_truth_df.iterrows():
    tmp_df = zeek_data_df[(zeek_data_df['id.orig_h'] == row_data[1]['Source IP']) &
                     (zeek_data_df['id.orig_p'] == row_data[1]['Source Port']) &
                     (zeek_data_df['id.resp_h'] == row_data[1]['Destination IP']) &
                     (zeek_data_df['id.resp_p'] == row_data[1]['Destination Port']) &
                     (zeek_data_df['proto'] == row_data[1]['Protocol']) &
                     (zeek_data_df['stime'] == row_data[1]['Start time']) &
                     (zeek_data_df['ltime'] == row_data[1]['Last time'])]

    if tmp_df.shape[0] > 0:
        zeek_data_df.loc[tmp_df.index, 'label'] = 1

###
# Save actual data with updated label
###

zeek_data_df.to_csv('../../../../pcaps/17-2-2015_1/features.csv', index=False)
