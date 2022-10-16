# Guidelines to Improve the Delivery of Network Intrusion Datasets
Full source code repository to accompany the paper "Guidelines to Improve the Delivery of Network Intrusion Datasets"
If you plan on experimenting with the sample implementation of the guidelines from the paper please first ensure you meet the requirements outlined in ./config/unsw-nb15.yaml:

```
python_version:    3.8.10
zeek_version:      4.2.1
 argus_version:     3.0.8.2
 ra_client_version: 3.0.8 
```

In addition, the python libraries outlined in the requirements.txt file need to be installed as part of your python environment:

```
pandas==1.4.3
PyYAML==6.0
requests==2.28.1
```

## Executing Sample Implementation
After downloading this repository, change directory to its root and execute:

```
python ./src/create_dataset.py ./config/unsw-nb15.yaml

```

This sample is for example purposes only to support the paper and set a path towards wider support of the paper's outlined guidelines.

## Expected Outputs
After executing the sample with default settings the output will be contained in a ./unsw_nb15_dataset directory.
The artifacts include the downloaded UNSW-NB15 PCAP file, argus output, Zeek output.
The final output after merging all of the features together is  contained in the ./unsw_nb15_dataset/unsw_nb15_dataset.csv file.
