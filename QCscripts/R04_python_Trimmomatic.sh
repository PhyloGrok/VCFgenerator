#!/bin/bash
#LloydJonesIII
## Trimmomatic Loop 
for infile in ../../media/volume/sdb/$1/fastq/*_1.fastq.gz 
do 
base=$(basename ${infile} _1.fastq.gz) \ 
trimmomatic PE ../../media/volume/sdb/$1/fastq/${infile} ../../media/volume/sdb/$1/fastq/${base}_2.fastq.gz \
../../media/volume/sdb/$1/fastq/trimmed/${base}_1.trim.fastq.gz ../../media/volume/sdb/$1/fastq/untrimmed/${base}_1.untrim.fastq.gz \
../../media/volume/sdb/$1/fastq/trimmed/${base}_2.trim.fastq.gz ../../media/volume/sdb/$1/fastq/untrimmed/${base}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:../../media/volume/sdb/NexteraPE-PE.fa:2:40:15
done
#### Loop ends 

## need to run fastqc on trimmed files only 
fastqc ../../media/volume/sdb/$1/fastq/trimmed/*.trim.fastq.gz
