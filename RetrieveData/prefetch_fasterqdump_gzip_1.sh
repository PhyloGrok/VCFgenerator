#!/bin/bash
#LloydJonesIII

## user input 
read -p "Please name your Project" pname
read -p "Please enter the project ID you are researching" project

## Make Directories 
mkdir ../../media/volume/sdb/sra/$pname
mkdir ../../media/volume/sdb/sra/$pname/fastq
mkdir ../../media/volume/sdb/sra/$pname/fastq/SAM
mkdir ../../media/volume/sdb/sra/$pname/fastq/BAM
mkdir ../../media/volume/sdb/sra/$pname/fastq/BCF
mkdir ../../media/volume/sdb/sra/$pname/fastq/VCF
mkdir ../../media/volume/sdb/sra/$pname/ref_genome

## NIH API Websearch
esearch -db sra -query "PRJNA541441" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > ../../media/volume/sdb/sra/$pname/$pname.txt


## Grab metadata using the esearch list 
prefetch --option-file $pname.txt -O ../../media/volume/sdb/sra/$pname/


## takes list generated by esearch to grab the desired fastq files from the databases
fasterq-dump --outdir ../../media/volume/sdb/sra/$pname/fastq/ ../../media/volume/sdb/sra/$pname/SRR*

## gzip all fastq files that were collected 

gzip *.fastq
#reduces storage cost of all collected fastq files by making them zip files 
