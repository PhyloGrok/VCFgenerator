#!/bin/bash
#LJones, JRobinson, NLuu
## User Inputs
# 1 = directory name
# 2 = directoy path
## Set the index
bwa index $2/$1/assembly/reference/ref_genome.fasta
## Variant Calling Loop
for x in $2/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
## Generate the SAM files
bwa mem -t 4 -p $2/$1/assembly/reference/ref_genome.fasta $2/$1/fastq/trimmed/${name}_1.trim.fastq.gz $2/$1/fastq/trimmed/${name}_2.trim.fastq.gz > $2/$1/assembly/results/sam/${name}.aligned.sam
done
## Generate the BAM files
for x in $2/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
samtools view -S -b $2/$1/assembly/results/sam/${name}.aligned.sam > $2/$1/assembly/results/bam/${name}.aligned.bam
samtools sort -o $2/$1/assembly/results/bam/${name}.aligned.sorted.bam $2/$1/assembly/results/bam/${name}.aligned.bam
samtools index $2/$1/assembly/results/bam/${name}.aligned.sorted.bam
done
rm -r $2/$1/assembly/results/sam/
## Read coverage of positions in the genome
for x in $2/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
bcftools mpileup -O b -o $2/$1/assembly/results/bcf/${name}_raw.bcf -f $2/$1/assembly/reference/ref_genome.fasta $2/$1/assembly/results/bam/${name}.aligned.sorted.bam
done
rm -r $2/$1/assembly/results/bam/
## SNV Detection
for x in $2/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
bcftools call --ploidy 1 -m -v -o $2/$1/assembly/results/vcf/${name}.vcf $2/$1/assembly/results/bcf/${name}_raw.bcf
done
rm -r $2/$1/assembly/results/bcf/
## Final Variant Calling
for x in $2/$1/fastq/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
vcfutils.pl varFilter $2/$1/assembly/results/vcf/${name}.vcf > $2/$1/assembly/results/vcf/${name}_final_variants.vcf
done
