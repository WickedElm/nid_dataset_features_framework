import os
import subprocess
import sys
import yaml

###
# Helper functions
###
def perform_replacements(input_string, setup_options):
    if 'ENV_PWD' in input_string:
        env_pwd = os.getcwd()
        input_string = input_string.replace('ENV_PWD', env_pwd)

    for key, value in setup_options.items():
        string_key = '${setup_options.' + key + '}'
        if string_key in input_string:
            input_string = input_string.replace(string_key, value)

    return input_string

def perform_command(command):
    command = perform_replacements(command, setup_options)
    command_array = command.split()
    print('')
    print(f'Executing [{command}]')
    subprocess.run(command_array)
    print('Complete.')
    print('')


###
# Read in yaml file
###
yaml_file_path = sys.argv[1]

with open(yaml_file_path) as f:
    dataset_instructions = yaml.safe_load(f)

###
# Separate our base steps
###
setup_options = dataset_instructions['setup_options']
step_acquire_source_data = dataset_instructions['step_acquire_source_data']
step_feature_processing = dataset_instructions['step_feature_processing']
step_label_processing = dataset_instructions['step_label_processing']
step_post_processing = dataset_instructions['step_post_processing']

###
# Resolve replacements in our setup_options
###
for key, value in setup_options.items():
    setup_options[key] = perform_replacements(value, setup_options)

###
# Perform Steps
###

# Create working_directory
# - Do not recreate the directory if it already exists
if not os.path.exists(setup_options['working_directory']):
    os.makedirs(setup_options['working_directory'], exist_ok=True)

# Acquire Source Data
for command in step_acquire_source_data:
    perform_command(command)

# Feature Processing
if step_feature_processing['packet_level'] is not None:
    for command in step_feature_processing['packet_level']:
        perform_command(command)

if step_feature_processing['flow_level'] is not None:
    for command in step_feature_processing['flow_level']:
        perform_command(command)

if step_feature_processing['network_level'] is not None:
    for command in step_feature_processing['network_level']:
        perform_command(command)

# Label Processing
if step_label_processing['packet_level'] is not None:
    for command in step_label_processing['packet_level']:
        perform_command(command)

if step_label_processing['flow_level'] is not None:
    for command in step_label_processing['flow_level']:
        perform_command(command)

if step_label_processing['network_level'] is not None:
    for command in step_label_processing['network_level']:
        perform_command(command)

# Post Processing
if step_post_processing is not None:
    for command in step_post_processing:
        perform_command(command)
