## LloydJonesIII
## Holds the shell scripts that run the workflow and acts as a hub for the input variables set in Controller.py
# Import Libraries 
import subprocess
# Import Variables from the Controller py script
with open(f'inputs.txt','r') as userfile:
    all = userfile.read().splitlines()
userfile.close()
# Workflow shell scripts 
search = subprocess.call(["bash","./R03.sh",all[0],all[1],all[2]]) ## Search Shell script
split  = subprocess.call(["python","Split.py"]) ## text file splitting Shell script that runs trimmomatic 
###variants = subprocess.call(["bash","variant2.py"]) ## Variant calling workflow loop
