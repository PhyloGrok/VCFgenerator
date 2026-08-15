#!/bin/bash

#read -p "Enter your TaxID:" txid
#echo $txid

BASE_DATA_DIR="${DATA_DIR:-/app/data}"
txid="$TAXID"

bwa index ${BASE_DATA_DIR}/VCF.projects/$txid/data/ncbi_dataset/data/GC*/GC*.fna

for infile in ${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/*_1.trim.fastq
	do
	base=$(basename ${infile} _1.trim.fastq)
	echo ${base}
	bwa mem ${BASE_DATA_DIR}/VCF.projects/$txid/data/ncbi_dataset/data/GC*/GC*.fna \
	${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_1.trim.fastq \
	${BASE_DATA_DIR}/VCF.projects/$txid/data/trimmed_fastq/${base}_2.trim.fastq > ${BASE_DATA_DIR}/VCF.projects/$txid/results/sam/${base}.aligned.sam

	samtools view -S -b ${BASE_DATA_DIR}/VCF.projects/$txid/results/sam/${base}.aligned.sam > ${BASE_DATA_DIR}/VCF.projects/$txid/results/bam/${base}.aligned.bam

	samtools sort -o ${BASE_DATA_DIR}/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam ${BASE_DATA_DIR}/VCF.projects/$txid/results/bam/${base}.aligned.bam

	samtools flagstat ${BASE_DATA_DIR}/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam

	bcftools mpileup -O b -o ${BASE_DATA_DIR}/VCF.projects/$txid/results/bcf/${base}_raw.bcf \
	-f ${BASE_DATA_DIR}/VCF.projects/$txid/data/ncbi_dataset/data/GC*/GC*.fna ${BASE_DATA_DIR}/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam

	bcftools call --ploidy 1 -m -v -o ${BASE_DATA_DIR}/VCF.projects/$txid/results/vcf/${base}_variants.vcf ${BASE_DATA_DIR}/VCF.projects/$txid/results/bcf/${base}_raw.bcf

	vcfutils.pl varFilter ${BASE_DATA_DIR}/VCF.projects/$txid/results/vcf/${base}_variants.vcf > ${BASE_DATA_DIR}/VCF.projects/$txid/results/vcf/${base}_final_variants.vcf
	done
