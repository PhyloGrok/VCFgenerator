## LloydJonesIII
import subprocess 
import numpy as np
# Import Variables from the Controller py script
with open('inputs.txt', 'r') as userfile:
    all = userfile.read().splitlines()
userfile.close()
# run the variant calling process 
subprocess.call(["bash","./VCF.sh", all[0]])