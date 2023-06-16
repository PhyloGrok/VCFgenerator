#!/bin/bash
#LloydJonesIII

#### VCF generation Loop 

for infile in ../../media/volume/sdb/$pname/fastq/*_1.fastq.gz 
do 
base=$(basename ${infile} _1.fastq.gz) \ 

#Create aligned sam files 
bwa mem ../../media/volume/sdb/$pname/ref_genome.fasta ../../media/volume/sdb/$pname/fastq/${base}_1.trim.fastq.gz \
../../media/volume/sdb/$pname/fastq/${base}_2.trim.fastq.gz > ../../media/volume/sdb/$pname/assembly/results/SAM/${base}.aligned.sam

#Creating and sorting BAM Files 
samtools view -S -b ../../media/volume/sdb/$pname/assembly/results/SAM/${base}.aligned.sam > ../../media/volume/sdb/$pname/assembly/results/BAM/${base}.aligned.bam
samtools sort -o ../../media/volume/sdb/$pname/assembly/results/BAM/${base}.aligned.sorted.bam ../../media/volume/sdb/$pname/assembly/results/BAM/${base}.aligned.bam

#read coverage of positions in the genome
bcftools mpileup -O b -o ../../media/volume/sdb/$pname/assembly/results/BCF/${base}_raw.bcf \
-f ../../media/volume/sdb/assembly/HsRefGenome.fa ../../media/volume/sdb/$pname/assembly/results/BAM/${base}.aligned.sorted.bam

#Detect the single nucleotide variants (SNVs)
bcftools call --ploidy 1 -m -v -o ../../media/volume/sdb/$pname/assembly/results/VCF/${base}.vcf ../../media/volume/sdb/$pname/assembly/results/BCF/${base}_raw.bcf

#Filter and report the SNV variants in variant calling format
vcfutils.pl varFilter ../../media/volume/sdb/$pname/assembly/results/VCF/${base}.vcf  > ../../media/volume/sdb/$pname/assembly/results/VCF/${base}_final_variants.vcf

done