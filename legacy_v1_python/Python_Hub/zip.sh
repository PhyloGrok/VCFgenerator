#!/bin/bash
##LJonesIII
# User Inputs
## 1 = directory name
## 2 = project ID
## 3 = taxon ID
## 4 = file path
echo $1 'Batch Gzip process has begun'
echo $4/$1
gzip $4/$1/fastq/untrimmed/*.fastq
echo $1 ' Batch have been Gzipped'

