import requests
import sys

destination_directory = sys.argv[1]

pcap_dir = '17-2-2015'
pcap_base_url = f'https://cloudstor.aarnet.edu.au/plus/s/2DhnLGDdEECo4ys/download?path=/UNSW-NB15%20-%20pcap%20files/pcaps%20{pcap_dir}&files='

print(f'Downloading {pcap_dir}_1.pcap')

pcap_file_name = f'1.pcap'
response = requests.get(f'{pcap_base_url}{pcap_file_name}')
with open(f'{destination_directory}/{pcap_dir}_{pcap_file_name}', 'wb') as f:
    f.write(response.content)
