#!/bin/bash

#read -p "Enter your TaxID: " txid
#read -p "Enter your filepath (storage_directory/project_directory): " filepath 

#echo $txid
#echo $filepath

# Read DATA_DIR from environment, default to /app/data if empty
BASE_DATA_DIR="${DATA_DIR:-/app/data}"

txid="$TAXID"


# Build the directory tree paths
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/data"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/data/untrimmed_fastq"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/results"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/results/sam"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/results/bam"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/results/bcf"
mkdir -m777 "${BASE_DATA_DIR}/VCF.projects/$txid/results/vcf"


#mkdir -m777 ~/VCF.projects
#mkdir -m777 ~/VCF.projects/$txid/
#mkdir -m777 ~/VCF.projects/$txid/data
#mkdir -m777 ~/VCF.projects/$txid/data/ref_genome
#mkdir -m777 ~/VCF.projects/$txid/data/untrimmed_fastq
#mkdir -m777 ~/VCF.projects/$txid/data/trimmed_fastq
#mkdir -m777 ~/VCF.projects/$txid/results
#mkdir -m777 ~/VCF.projects/$txid/results/sam
#mkdir -m777 ~/VCF.projects/$txid/results/bam
#mkdir -m777 ~/VCF.projects/$txid/results/bcf
#mkdir -m777 ~/VCF.projects/$txid/results/vcf


#datasets download genome taxon $txid --reference --include genome --filename ~/VCF.projects/$txid/data/ref_genome/$txid.zip
datasets download genome taxon $txid --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename ${BASE_DATA_DIR}/VCF.projects/$txid/data/$txid.zip


unzip ${BASE_DATA_DIR}/VCF.projects/$txid/data/$txid.zip -d ~/VCF.projects/$txid/data/
#cd /media/volume/sdc/S25/data/untrimmed_fastq

esearch -db sra -query ""txid$txid"[Orgn] AND "genomic"[Source] AND "paired"[Layout] AND "illumina"[Platform] AND "wgs"[Strategy] AND filetype "fastq"[Filter] AND strategy "genome"[Filter]" | efetch -format docsum | xtract -pattern Runs -ACC @acc -element "&ACC" > ${BASE_DATA_DIR}/VCF.projects/$txid/data/SraList_$txid.txt

prefetch --option-file ${BASE_DATA_DIR}/VCF.projects/$txid/data/SraList_$txid.txt -O ${BASE_DATA_DIR}/VCF.projects/$txid/data/sra/
fasterq-dump ${BASE_DATA_DIR}/VCF.projects/$txid/data/sra/SRR* -O ${BASE_DATA_DIR}/VCF.projects/$txid/data/untrimmed_fastq/
