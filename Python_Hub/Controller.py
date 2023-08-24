## LloydJonesIII
# Import Libraries 
import subprocess 
import numpy as np
# user inputs 
## 0 = directory name
## 1 = project ID
## 2 = taxon ID
## 3 = file status 
## 4 = file path 
user0 = input('Please enter the name of your project, no spaces or special characters allowed:    ')
user1 = input('Please enter the Project ID you are using for data:    ')
user2 = input('Please input your reference genomes taxon id, numbers only no spaces:    ')
user3 = input('Are the paired-end fastq files split?: [yes/no]   ')
user4 = input('What is your mount point path?: /example/1/2/3   ')
ulist = [user0,user1,user2,user3,user4]
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
