#!bin/bash
##LJones, JRobinson, NLuu
# User Inputs 
## 0 = directory name
## 1 = project ID
## 2 = taxon ID
## 3 = file status 
## 4 = file path 
fastqc $4/$1/fastq/trimmed/*fastq.gz
