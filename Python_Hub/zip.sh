#!/bin/bash
##LJonesIII
# User Inputs 
## 1 = directory name
## 2 = file path
echo $1 ' Batch Gzip process has begun'
gzip $2/$1/fastq/untrimmed/*.fastq
echo $1 ' Batch have been Gzipped'
