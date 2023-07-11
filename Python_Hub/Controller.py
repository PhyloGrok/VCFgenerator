## LloydJonesIII
# Import Libraries 
import subprocess 
import numpy as np
# user inputs 
user1 = input('Please enter a name for your project (no spaces or special characters):    ')
user2 = input('Please enter the NCBI BioProject ID you want to analyze (starts with PRJNA):    ')
user3 = input('Please input the NCBI taxon id for your reference genome, (will be an integer number):    ')
ulist = [user1,user2,user3]
# Save user inputs as a writen text file 
inputs = open(f"inputs.txt", "w")
for x in ulist:
	inputs.write(x+"\n")
inputs.close()
# double checks and prints the entered inputs 
outputs = open(f"inputs.txt", "r")
contents = outputs.read()
print(contents)
outputs.close()
# Run the Hub script that controls the workflow 
hub  = subprocess.call(["python","Thehub.py"])
