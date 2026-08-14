#!/bin/bash

# Read DATA_DIR from environment, default to /app/data if empty
BASE_DATA_DIR="${DATA_DIR:-/app/data}" 
txid="$TAXID"

for infile in ${BASE_DATA_DIR}/VCF.projects/$txid/data/untrimmed_fastq/*_1.fastq
	do
		base=$(basename ${infile} _1.fastq)
		echo ${base}
		echo $infile
		trimmomatic PE ${infile} ${BASE_DATA_DIR}/VCF.projects/$txid/data/untrimmed_fastq/${base}_2.fastq \
		${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_1.trim.fastq ${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_1.untrim.fastq \
		${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_2.trim.fastq ${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_2.untrim.fastq \ 
		SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
	done

fastqc ${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/*.trim.fastq*
