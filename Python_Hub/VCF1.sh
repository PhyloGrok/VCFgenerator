#!/bin/bash
#Lloyd Jones III
## Set the index
bwa index ../../media/volume/sdb/$1/assembly/reference/ref_genome.fasta
## Variant Calling Loops
for x in ../../media/volume/sdb/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
## Generate the SAM files
bwa mem -t 4 ../../media/volume/sdb/$1/assembly/reference/ref_genome.fasta ../../media/volume/sdb/$1/fastq/trimmed/${name}_1.trim.fastq.gz ../../media/volume/sdb/$1/fastq/trimmed/${name}_2.trim.fastq.gz > ../../media/volume/sdb/$1/assembly/results/sam/${name}.aligned.sam
## Generate the BAM files
samtools view -S -b ../../media/volume/sdb/$1/assembly/results/sam/${name}.aligned.sam > ../../media/volume/sdb/$1/assembly/results/bam/${name}.aligned.bam
done
## Delete SAM files for storage saving
rm -r ../../media/volume/sdb/$1/assembly/results/sam/
## BAM sorting & BCF creating loops
for x in ../../media/volume/sdb/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
## Sort BAM files for downstream processes
samtools sort -o ../../media/volume/sdb/$1/assembly/results/bam/${name}.aligned.sorted.bam ../../media/volume/sdb/$1/assembly/results/bam/${name}.aligned.bam
samtools index ../../media/volume/sdb/$1/assembly/results/bam/${name}.aligned.sorted.bam
## Read coverage of positions in the genome
bcftools mpileup -O b -o ../../media/volume/sdb/$1/assembly/results/bcf/${name}_raw.bcf -f ../../media/volume/sdb/$1/assembly/reference/ref_genome.fasta ../../media/volume/sdb/$1/assembly/results/bam/${name}.aligned.sorted.bam
done
## Delete BAM files for storage saving
rm -r ../../media/volume/sdb/$1/assembly/results/bam/
## Detection Loops
for x in ../../media/volume/sdb/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
## SNV Detection
bcftools call --ploidy 1 -m -v -o ../../media/volume/sdb/$1/assembly/results/vcf/${name}.vcf ../../media/volume/sdb/$1/assembly/results/bcf/${name}_raw.bcf
## Final Variant Calling
vcfutils.pl varFilter ../../media/volume/sdb/$1/assembly/results/vcf/${name}.vcf > ../../media/volume/sdb/$1/assembly/results/vcf/${name}_final_variants.vcf
done
## Delete the BCF files 
rm -r ../../media/volume/sdb/$1/assembly/results/bcf/
echo $1 'Varaint calling has been completed'
