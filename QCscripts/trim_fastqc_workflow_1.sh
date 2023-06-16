#!/bin/bash
#LloydJonesIII

## user input 
read -p "Please name your Project, please use same name as search shell" pname
read -p "Please enter the project ID you are researching, please use same name as search shell" project

## Trimmomatic Loop 
for infile in ../../media/volume/sdb/sra/$pname/fastq/*_1.fastq.gz 
do 
base=$(basename ${infile} _1.fastq.gz) \ 
trimmomatic PE ../../media/volume/sdb/sra/$pname/fastq/${infile} ../../media/volume/sdb/sra/$pname/fastq/${base}_2.fastq.gz \
../../media/volume/sdb/sra/$pname/fastq/${base}_1.trim.fastq.gz ../../media/volume/sdb/sra/$pname/fastq/${base}_1.untrim.fastq.gz \
../../media/volume/sdb/sra/$pname/fastq/${base}_2.trim.fastq.gz ../../media/volume/sdb/sra/$pname/fastq/${base}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
done

#### Loop ends 

## need to run fastqc on trimmed files only 
fastqc ../../media/volume/sdb/sra/$pname/fastq/*.trim.fastq.gz