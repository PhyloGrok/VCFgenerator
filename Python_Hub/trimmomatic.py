##LJones, JRobinson, NLuu 
import subprocess 
import numpy as np
# user inputs 
## 0 = directory name
## 1 = project ID
## 2 = taxon ID
## 3 = file status 
## 4 = file path 
# Import Variables from the Controller py script
with open(f'inputs.txt','r') as userfile:
    inputs = userfile.read().splitlines()
userfile.close()
# Import sra text file and converts it to a python list 
with open(f'../../media/volume/sdb/{inputs[0]}/{inputs[0]}.txt','r') as userfile:
    srafile = userfile.read().splitlines()
userfile.close()
# Trimmomatic Script variant runs based on length of list 
for a in range(len(srafile)):
    subprocess.call(["bash","./thetrimmer.sh", inputs[0], srafile[a], inputs[4]])
subprocess.call(["bash","./fastqc.sh", inputs[0],inputs[4]])