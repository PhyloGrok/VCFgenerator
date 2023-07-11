#!/bin/bash
##LJonesIII
## Variable Check
echo $1
echo $2
echo $3
## Make Directories 
mkdir ../../media/volume/sdb/$1
mkdir ../../media/volume/sdb/$1/text
mkdir ../../media/volume/sdb/$1/sra
mkdir ../../media/volume/sdb/$1/fastq
mkdir ../../media/volume/sdb/$1/fastq/untrimmed
mkdir ../../media/volume/sdb/$1/fastq/trimmed
mkdir ../../media/volume/sdb/$1/assembly
mkdir ../../media/volume/sdb/$1/assembly/reference
mkdir ../../media/volume/sdb/$1/assembly/results
mkdir ../../media/volume/sdb/$1/assembly/results/sam
mkdir ../../media/volume/sdb/$1/assembly/results/bam
mkdir ../../media/volume/sdb/$1/assembly/results/bcf
mkdir ../../media/volume/sdb/$1/assembly/results/vcf
## Web-search
esearch -db sra -query "${2}" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > ../../media/volume/sdb/$1/${1}.txt

## The EDirect retrieval for RefSeq genome is retrieving the Halobacterium 91-R6 (DSM 3754), for the pH experiment, it needs the NRC-1 genome
datasets download genome taxon $3 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename ../../media/volume/sdb/$1/assembly/${3}.zip
prefetch --option-file ../../media/volume/sdb/$1/${1}.txt -O ../../media/volume/sdb/$1/sra/
fasterq-dump --outdir ../../media/volume/sdb/$1/fastq ../../media/volume/sdb/$1/sra/SRR*
## Data Processing
unzip ../../media/volume/sdb/$1/assembly/${3}.zip -d ../../media/volume/sdb/$1/assembly/reference
echo 'Gzip process has begun'
gzip ../../media/volume/sdb/$1/fastq/*.fastq
echo 'All files have benn Gzipped'
mv ../../media/volume/sdb/$1/assembly/reference/ncbi_dataset/data/GCF*/GCF*.fna ../../media/volume/sdb/$1/assembly/reference/ref_genome
