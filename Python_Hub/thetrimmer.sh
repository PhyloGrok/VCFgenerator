#!bin/bash
#LloydJonesIII
# User Inputs 
## 1 = directory name
## 2 = project ID
## 3 = taxon ID
## 4 = file path
## 5 = file name
trimmomatic PE -threads 8 $4/$1/fastq/untrimmed/${5}_1.fastq.gz $4/$1/fastq/untrimmed/${5}_2.fastq.gz \
$4/$1/fastq/trimmed/${5}_1.trim.fastq.gz $4/$1/fastq/untrimmed/${5}_1.untrim.fastq.gz \
$4/$1/fastq/trimmed/${5}_2.trim.fastq.gz $4/$1/fastq/untrimmed/${5}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
