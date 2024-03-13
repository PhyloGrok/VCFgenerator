## LloydJonesIII
## Edited for clarity (future debugging) and user accessibility by Critic-ism (Janifer Le)

# Import Libraries 
import subprocess 
import json
import numpy as np
# user inputs 
## p_dir = directory name
## p_id = project ID
## t_id = taxon ID
## split = file status 
## mpath = file path 
p_dir = input('Please enter the name of your project, no spaces or special characters allowed:    ')
p_id = input('Please enter the Project ID you are using for data:    ')
t_id = input('Please input your reference genomes taxon id, numbers only no spaces:    ')
split = input('Are the paired-end fastq files split?: [yes/no]   ')
mpath = input('What is your mount point path?: /example/1/2/3   ')
uservar = {'proj': p_dir, 'proj_id': p_id, 'tax_id': t_id, 'splitfile': split, 'filepath': mpath}
# Save user inputs as a json file containing dictionary keys and values for later loading 
# JSON has better compatibility between different coding languages
# Dictionaries are a more descriptive method of saving data--does not depend on ordered indexing
with open('inputs.json', 'w') as file:
	json.dump(uservar, file)
# Loads the json file and prints out keys and values
with open('inputs.json', 'r') as file:
	user_inputs = json.load(file)
print(f"Project Name: {user_inputs.get('proj')}")
print(f"Project ID: {user_inputs.get('proj_id')}")
print(f"Taxon ID: {user_inputs.get('tax_id')}")
print(f"Are the paired-end fastq files split? {user_inputs.get('splitfile')}")
print(f"Where you output files will appear: {user_inputs.get('filepath')}") 
# Run the Hub script that controls the workflow 
#hub  = subprocess.call(["python3","Thehub.py"])
