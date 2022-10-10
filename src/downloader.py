import requests

destination_directory = './'

print('Downloading 17-2-2015 pcaps')
pcap_dir = '17-2-2015'
pcap_base_url = f'https://cloudstor.aarnet.edu.au/plus/s/2DhnLGDdEECo4ys/download?path=/UNSW-NB15%20-%20pcap%20files/pcaps%20{pcap_dir}&files='
for i in range(1, 28):
    print(f'Downloading {pcap_dir}_{i}.pcap')
    pcap_file_name = f'{i}.pcap'
    response = requests.get(f'{pcap_base_url}{pcap_file_name}')
    with open(f'{destination_directory}{pcap_dir}_{pcap_file_name}', 'wb') as f:
        f.write(response.content)

print('Downloading 22-1-2015 pcaps')
pcap_dir = '22-1-2015'
pcap_base_url = f'https://cloudstor.aarnet.edu.au/plus/s/2DhnLGDdEECo4ys/download?path=/UNSW-NB15%20-%20pcap%20files/pcaps%20{pcap_dir}&files='
for i in range(1, 53):
    print(f'Downloading {pcap_dir}_{i}.pcap')
    pcap_file_name = f'{i}.pcap'
    response = requests.get(f'{pcap_base_url}{pcap_file_name}')
    with open(f'{destination_directory}{pcap_dir}_{pcap_file_name}', 'wb') as f:
        f.write(response.content)
