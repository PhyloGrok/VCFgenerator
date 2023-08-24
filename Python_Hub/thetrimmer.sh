#!bin/bash
#LloydJonesIII
# User Inputs 
## 1 = project name
## 2 = file name
## 3 = file path
trimmomatic PE -threads 4 $3/$1/fastq/${2}_1.fastq.gz $3/$1/fastq/${2}_2.fastq.gz \
$3/$1/fastq/trimmed/${2}_1.trim.fastq.gz $3/$1/fastq/untrimmed/${2}_1.untrim.fastq.gz \
$3/$1/fastq/trimmed/${2}_2.trim.fastq.gz $3/$1/fastq/untrimmed/${2}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 