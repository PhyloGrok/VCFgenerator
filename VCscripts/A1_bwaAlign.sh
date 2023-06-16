#!/bin/bash
for infile in ../sra/pH/fastq/*_1.trim.fastq.gz
do
        base=$(basename ${infile} _1.trim.fastq.gz)
        echo ${infile}
        echo $base
        bwa mem HsRefGenome.fa ../sra/pH/fastq/${base}_1.trim.fastq.gz /sra/pH/fastq/${base}_2.trim.fastq.gz > results/sam/${base}.aligned.sam
done
