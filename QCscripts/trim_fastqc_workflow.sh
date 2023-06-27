#!/bin/bash
#LloydJonesIII
## Trimmomatic Loop 

for infile in ../../media/volume/sdb/sra/pH/fastq/*_1.fastq.gz 
do 
base=$(basename ${infile} _1.fastq.gz) \ 
trimmomatic PE ${infile} ../../media/volume/sdb/sra/pH/fastq/${base}_2.fastq.gz \
../../media/volume/sdb/sra/pH/fastq/${base}_1.trim.fastq.gz ../../media/volume/sdb/sra/pH/fastq/${base}_1.untrim.fastq.gz \
../../media/volume/sdb/sra/pH/fastq/${base}_2.trim.fastq.gz ../../media/volume/sdb/sra/pH/fastq/${base}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:../../media/volume/sdb/sra/pH/fastq/NexteraPE-PE.fa:2:40:15
done

#### Loop ends 

## need to run fastqc on trimmed files only 
fastqc ../../media/volume/sdb/sra/pH/fastq/*.trim.fastq.gz
