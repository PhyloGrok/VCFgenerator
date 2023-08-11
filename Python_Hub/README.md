# Introduction to the Python Hub Scripts
##### Primary Collaborators: Dr. Jeffery Robinson, Lloyd W Jones III, Nhi Luu 
The Python Hub and controller scripts Take in user inputs and run the Command Line and Python subscripts that house the workflow code.   
# Code Guide
1. This repository uses 3 languages: Python, Command Line, and R-studio/R-shiny
2. Python is being used for user input management 
3. Command Line is being used to run the workflow functions
4. R-studio/R-shiny is being used for our plotting
### User Inputs 
```
user0 = input('Please enter the name of your project, no spaces or special characters allowed:    ')
```
- This will be used as the name of the project directory in which all the generated files will be saved underneath
```
user1 = input('Please enter the Project ID you are using for data:    ')
```
- This is the NCBI Project ID
- This is used to collect the SRR Files and Project Metadata from the NCBI Database
```
user2 = input('Please input your reference genomes taxon id, numbers only no spaces:    ')
```
- 4-digit taxon ID for the species the project is using
- Collects the current Reference genome of the species and will be used for the variant calling stage 
```
user3 = input('Are the paired-end fastq files already split?: [yes/no]   ')
```
- are your files interleaved or split?
- Interleaved files will be split with a splitter code 
```
user4 = input('What is your mount point path?: /example/1/2/3   ')
```
- Input the file path you are using for your large data storage
- ***If the data storage you are using is not connected to your root directory, you will have to specify the relative path from your current directory***
### Workflow Script Run Order 
1. Controller.py
2. Thehub.py
3. download.py
4. import.sh
5. splitter.sh (Optional)
6. zip.sh
7. trimmomatic.py
8. thetrimmer.sh
9. variants.py
10. VCF.sh
