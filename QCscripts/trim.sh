#!/bin/bash
for infile in *_1.fastq.gz
do
base=$(basename ${infile} _1.fastq.gz)
trimmomatic PE ${infile} ${base}_2.fastq.gz \
${base}_1.trim.fastq.gz ${base}_1.untrim.fastq.gz \
${base}_2.trim.fastq.gz ${base}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
done
