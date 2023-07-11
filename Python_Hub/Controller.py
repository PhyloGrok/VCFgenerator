## LloydJonesIII
# Import Libraries 
import subprocess 
import numpy as np
# user inputs 
user1 = input('Please enter the name of your project, no spaces or special characters allowed:    ')
user2 = input('Please enter the Project ID you are using for data:    ')
user3 = input('Please input your reference genomes taxon id, numbers only no spaces:    ')
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
