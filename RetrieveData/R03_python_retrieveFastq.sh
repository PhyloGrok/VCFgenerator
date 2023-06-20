#!/bin/bash
#LloydJonesIII

## Variable Check 
echo $1
echo $2
echo $3

## Make Directories 
mkdir ../../media/volume/sdb/$1
mkdir ../../media/volume/sdb/$1/sra
mkdir ../../media/volume/sdb/$1/fastq
mkdir ../../media/volume/sdb/$1/assembly
mkdir ../../media/volume/sdb/$1/fastq/untrimmed
mkdir ../../media/volume/sdb/$1/fastq/trimmed
mkdir ../../media/volume/sdb/$1/assembly/results
mkdir ../../media/volume/sdb/$1/assembly/results/SAM
mkdir ../../media/volume/sdb/$1/assembly/results/BAM
mkdir ../../media/volume/sdb/$1/assembly/results/BCF
mkdir ../../media/volume/sdb/$1/assembly/results/VCF


## NIH API Websearch
esearch -db sra -query $2 | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > ../../media/volume/sdb/$1/${1}.txt

datasets download genome taxon $3 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename ../../media/volume/sdb/$1/assembly/${3}complete.zip

gunzip ${3}complete.zip

cp ../../media/volume/sdb/$1/assembly/${3}complete.zip/GCF*.fna ../../media/volume/sdb/$1/assembly/ref_genome

## Grab metadata using the esearch list 
prefetch --option-file ../../media/volume/sdb/$1/${1}.txt -O ../../media/volume/sdb/$1/sra/

## takes list generated by esearch to grab the desired fastq files from the databases
fasterq-dump --outdir ../../media/volume/sdb/$1/fastq ../../media/volume/sdb/$1/SRR*

## gzip all fastq files that were collected 
gzip ../../media/volume/sdb/$1/fastq/*.fastq
