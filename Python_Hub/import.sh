#!/bin/bash
##LJones, JRobinson, NLuu 
# User Inputs
## 1 = directory name
## 2 = project ID
## 3 = taxon ID
## 4 = file path
## Variable Check
echo $1
echo $2
echo $3
echo $4
## Make Directories 
mkdir -m777 $4/$1
mkdir -m777 $4/$1/sra
mkdir -m777 $4/$1/fastq
mkdir -m777 $4/$1/fastq/untrimmed
mkdir -m777 $4/$1/fastq/trimmed
mkdir -m777 $4/$1/assembly
mkdir -m777 $4/$1/assembly/reference
mkdir -m777 $4/$1/assembly/results
mkdir -m777 $4/$1/assembly/results/sam
mkdir -m777 $4/$1/assembly/results/bam
mkdir -m777 $4/$1/assembly/results/bcf
mkdir -m777 $4/$1/assembly/results/vcf
mkdir -m777 $4/$1/assembly/results/final_vcf
mkdir -m777 $4/$1/assembly/results/annotation
## Web-search
esearch -db sra -query "${2}" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > $4/$1/${1}.txt
esearch -db sra -query "${2}" | efetch -format runinfo > $4/$1/assembly/reference/RunInfo.txt
datasets download genome taxon $3 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename $4/$1/assembly/${3}.zip
prefetch --option-file $4/$1/${1}.txt -O $4/$1/sra/
#fasterq-dump -t $4/temp_files --outdir $4/$1/fastq $4/$1/sra/SRR*
fasterq-dump $4/$1/sra/SRR* -O $4/$1/fastq/untrimmed -t $4/temp_files
## Data Processing
unzip $4/$1/assembly/${3}.zip -d $4/$1/assembly/reference
cp $4/$1/assembly/reference/ncbi_dataset/data/GCF*/GCF*.fna $4/$1/assembly/reference/ref_genome.fasta
