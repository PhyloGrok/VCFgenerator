## LloydJonesIII
import subprocess 
import numpy as np
# Import Variables from the Controller py script
with open(f'inputs.txt','r') as userfile:
    inputs = userfile.read().splitlines()
userfile.close()
# Import sra text file and converts it to a python list 
with open(f'../../media/volume/sdb/{inputs[0]}/{inputs[0]}.txt','r') as userfile:
    srafile = userfile.read().splitlines()
userfile.close()
# list analysis to determine what downstream script variant is run
test = len(srafile)/2
test1 = int(test)
answer = test == test1
# Trimmomatic Script variant runs based on length of list 
if answer == True:
    sralist = [x.tolist() for x in np.array_split(srafile, 2)]
    for a in range(len(sralist[1])):
        subprocess.call(["bash","./trimmer2.sh", inputs[0], sralist[0][a], sralist[1][a]])
    subprocess.call(["bash","./fastqc.sh", inputs[0]])
else:
    sralist = [x.tolist() for x in np.array_split(srafile, 2)]
    for a in range(len(sralist[1])):
        subprocess.call(["bash","./trimmer2.sh", inputs[0], sralist[0][a], sralist[1][a]])
    subprocess.call(["bash","./trimmer3.sh", inputs[0], sralist[0][-1]])
    subprocess.call(["bash","./fastqc.sh", inputs[0]])