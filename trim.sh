#! /bin/bash

cd ~/dc_workshop/data/untrimmed_fastq/

for infile in *_1.fastq
  do
  base=$(basename ${infile} _1.fastq)
  trimmomatic PE ${infile} ${base}_2.fastq ${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz ${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
  done


