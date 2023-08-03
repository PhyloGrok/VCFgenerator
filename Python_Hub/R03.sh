#!/bin/bash
##LJonesIII
## Variable Check
echo $1
echo $2
echo $3
## Make Directories 
mkdir -m777 ../../media/volume/sdb/$1
mkdir -m777 ../../media/volume/sdb/$1/sra
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
mkdir ../../media/volume/sdb/$1/assembly/results/final_vcf
mkdir ../../media/volume/sdb/$1/assembly/results/annotation
## Web-search
esearch -db sra -query "${2}" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > ../../media/volume/sdb/$1/${1}.txt
esearch -db sra -query "${2}" | efetch -format runinfo > ../../media/volume/sdb/$1/assembly/reference/RunInfo.txt
datasets download genome taxon $3 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename ../../media/volume/sdb/$1/assembly/${3}.zip
prefetch --option-file ../../media/volume/sdb/$1/${1}.txt -O ../../media/volume/sdb/$1/sra/
fasterq-dump -t ../../media/volume/sdb/temp_files --outdir ../../media/volume/sdb/$1/fastq ../../media/volume/sdb/$1/sra/SRR*
## Data Processing
unzip ../../media/volume/sdb/$1/assembly/${3}.zip -d ../../media/volume/sdb/$1/assembly/reference
echo $2 ' Gzip process has begun'
gzip ../../media/volume/sdb/$1/fastq/*.fastq
echo $2 ' Files have been Gzipped'
mv ../../media/volume/sdb/$1/assembly/reference/ncbi_dataset/data/GCF*/GCF*.fna ../../media/volume/sdb/$1/assembly/reference/ref_genome.fasta

