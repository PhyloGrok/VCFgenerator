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
with open('inputs.txt', 'r') as userfile:
    all = userfile.read().splitlines()
userfile.close()
# run the variant calling process 
yeslist = ['y','Y','yes']
if all[3] in yeslist:
    primary = subprocess.call(["bash","./VCF.sh", all[0],all[4]])
else:
    interleaved = subprocess.call(["bash","./VCF_Int.sh", all[0],all[4]])
