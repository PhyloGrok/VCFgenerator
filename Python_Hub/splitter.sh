#!/bin/bash
##LJones, Jrobinson, NLuu 
## Code Inspiration
# biostars.org/p/141256/
## User Inputs 
## 1 = directory name
## 2 = project ID
## 3 = taxon ID
## 4 = file path
## 5 = SRR file name 
echo $1
echo $2
echo $3
echo $4
# Paired end fastq splitter 
paste - - - - - - - - < $4/$1/fastq/${5}.fastq \ | tee >(cut -f 1-4 | tr "\t" "\n" > $4/$1/fastq/${5}_1.fastq) \ | cut -f 5-8 | tr "\t" "\n" > $4/$1/fastq/${5}_2.fastq)
# delete interleaved file after splitting 
rm $4/$1/fastq/${5}.fastq 
