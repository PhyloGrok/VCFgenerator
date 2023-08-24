##LJones, JRobinson, NLuu 
# Import libraries 
import subprocess 
import numpy as np
# user inputs 
## 0 = directory name
## 1 = project ID
## 2 = taxon ID
## 3 = file status 
## 4 = file path 
# Import Variables from the Controller py script
with open('inputs.txt', 'r') as userfile:
    all = userfile.read().splitlines()
userfile.close()
annotation = subprocess.call(['bash',"./annotation_config.sh", f'{all[0]}', './snpeff_annotate.sh',f'{all[4]}'])
