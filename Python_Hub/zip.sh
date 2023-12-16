#!/bin/bash
##LJonesIII
# User Inputs 
## 1 = directory name
## 2 = file path
echo $1 ' Batch Gzip process has begun'
gzip $2/$1/fastq/untrimmed/*.fastq  ## This runs fine from the command line as "gzip /media/volume/sdb/test1/fastq/untrimmed/*.fastq"
## The error from the script run is "file/direcotry not found", check for the wrong import variables
echo $1 ' Batch have been Gzipped'
