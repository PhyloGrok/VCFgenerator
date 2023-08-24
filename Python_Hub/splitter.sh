#!/bin/bash
##LJones, Jrobinson, NLuu 
## Code Inspiration
# biostars.org/p/141256/
# User Inputs
## 1 = project name 
## 2 = file path
## 3 = file name 
# Paired end fastq splitter 
paste - - - - - - - - < $2/$1/fastq/${3}.fastq \ | tee >(cut -f 1-4 | tr "\t" "\n" > $2/$1/fastq/${3}_1.fastq) \ | cut -f 5-8 | tr "\t" "\n" > $2/$1/fastq/${3}_2.fastq)
# delete interleaved file after splitting 
rm $2/$1/fastq/${3}.fastq 
