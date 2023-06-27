from trial3 import user1
import subprocess 
import numpy as np
with open(f'{user1}.txt','r') as userfile:
    srafile = userfile.read().splitlines()
test = len(srafile)/2
test1 = int(test)
answer = test == test1
if answer == True:
    sralist = [x.tolist() for x in np.array_split(srafile, 2)]
    for a in range(len(sralist[0])):
        subprocess.call(["bash","./trimmer2.sh", user1, sralist[0][a], sralist[1][a]])
else:
    sralist = [x.tolist() for x in np.array_split(srafile, 3)]
    for a in range(len(sralist[0])):
        subprocess.call(["bash","./trimmer3.sh", user1, sralist[0][a], sralist[1][a], sralist[2][a]])