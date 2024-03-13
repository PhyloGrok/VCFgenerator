##LJones, JRobinson, NLuu
## Edited for clarity (future debugging) and user accessibility by Critic-ism (Janifer Le)

# user inputs
## proj = directory name
## proj_id = project ID
## tax_id = taxon ID
## splitfile = file status 
## filepath = file path 
import subprocess
import numpy as np
import json
# Import Variables from the Controller py script
with open('inputs.json', 'r') as file:
	user_inputs = json.load(file)
## Run the first layer of searches and downloads 
search = subprocess.call(["bash","./import.sh", user_inputs.get('proj'),user_inputs.get('proj_id'),
user_inputs.get('tax_id', user_inputs.get('splitfile'), user_inputs.get('filepath')])
#RESUME FROM HERE
# Import sra text file and converts it to a python list 
with open(f'{inputs[4]}/{inputs[0]}/{inputs[0]}.txt','r') as userfile:
    srafile = userfile.read().splitlines()
userfile.close()
## Splitter check
yeslist = ['y','Y','yes']
if inputs[3] in yeslist:
## Splitting Paired-end fastq files
    zipping = subprocess.call(['bash','./zip.sh',inputs[0],inputs[1],inputs[2],inputs[4]])
else:
    for x in srafile:
        splitter = subprocess.call(['bash','./splitter.sh',inputs[0],inputs[1],inputs[2],inputs[4],x])
    zipping = subprocess.call(['bash','./zip.sh',inputs[0],inputs[1],inputs[2],inputs[4]])
