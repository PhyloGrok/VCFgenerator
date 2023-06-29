## LloydJonesIII
import subprocess
x=True
ylist=['y','yes','Yes','Y']
while x == True:
	user1 = input('Please enter the name of your project, no spaces or special characters allowed:    ')
	user2 = input('Please enter the Project ID you are using for data:    ')
	user3 = input('Please input your reference genomes taxon id, numbers only no spaces:    ')
	search = subprocess.call(["bash","./R03.sh",user1,user2,user3]) ## Search Shell script
	split  = subprocess.call(["python","Split.py"]) ## text file splitting Shell script that runs trimmomatic 
	#variant_calling = 
## testing python variable input into command line scripts 
