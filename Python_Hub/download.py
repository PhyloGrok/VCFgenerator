##LJones, JRobinson, NLuu 
# user inputs 
## 0 = directory name
## 1 = project ID
## 2 = taxon ID
## 3 = file status 
## 4 = file path 
import subprocess 
import numpy as np
# Import Variables from the Controller py script
with open(f'inputs.txt','r') as userfile:
    inputs = userfile.read().splitlines()
userfile.close()
## Run the first layer of searches and downloads 
search = subprocess.call(["bash","./import.sh",inputs[0],inputs[1],inputs[2],inputs[4]])
# Import sra text file and converts it to a python list 
with open(f'{inputs[4]}/{inputs[0]}/{inputs[0]}.txt','r') as userfile:
    srafile = userfile.read().splitlines()
userfile.close()
## Splitter check 
yeslist = ['y','Y','yes']
if inputs[3] in yeslist:
## Splitting Paired-end fastq files 
    zipping = subprocess.call(['bash','./zip.sh',inputs[0],inputs[4]])
else:
    for x in srafile:
        splitter = subprocess.call(['bash','./splitter.sh',inputs[0],inputs[4],x])
    zipping = subprocess.call(['bash','./zip.sh',inputs[0],inputs[4]])       
