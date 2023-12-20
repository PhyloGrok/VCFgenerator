#!/bin/bash
#LJones, JRobinson, NLuu
## User Inputs 
## 1 = directory name
## 2 = project ID
## 3 = taxon ID
## 4 = file path
echo $1
echo $2
echo $3
echo $4
## Set the index
bwa index $4/$1/assembly/reference/ref_genome.fasta
## Variant Calling Loop
for x in $4/$1/fastq/untrimmed/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
## Generate the SAM files
bwa mem -t 4 $4/$1/assembly/reference/ref_genome.fasta $4/$1/fastq/trimmed/${name}_1.trim.fastq.gz $4/$1/fastq/trimmed/${name}_2.trim.fastq.gz > $4/$1/assembly/results/sam/${name}.aligned.sam
done
## Generate the BAM files
for x in $4/$1/fastq/untrimmed/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
samtools view -S -b $4/$1/assembly/results/sam/${name}.aligned.sam > $4/$1/assembly/results/bam/${name}.aligned.bam
samtools sort -o $4/$1/assembly/results/bam/${name}.aligned.sorted.bam $4/$1/assembly/results/bam/${name}.aligned.bam
samtools index $4/$1/assembly/results/bam/${name}.aligned.sorted.bam
done
#rm -r ${4}/${1}/assembly/results/sam/
## Read coverage of positions in the genome
for x in $4/$1/fastq/untrimmed/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
bcftools mpileup -O b -o $4/$1/assembly/results/bcf/${name}_raw.bcf -f $4/$1/assembly/reference/ref_genome.fasta $4/$1/assembly/results/bam/${name}.aligned.sorted.bam
done
#rm -r ${4}/${1}/assembly/results/bam/
## SNV Detection
for x in $4/$1/fastq/untrimmed/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
bcftools call --ploidy 1 -m -v -o $4/$1/assembly/results/vcf/${name}.vcf $4/$1/assembly/results/bcf/${name}_raw.bcf
done
#rm -r ${4}/${1}/assembly/results/bcf/
## Final Variant Calling
for x in $4/$1/fastq/untrimmed/*_1.fastq.gz
do
name=$(basename ${x} _1.fastq.gz)
vcfutils.pl varFilter $4/$1/assembly/results/vcf/${name}.vcf > $4/$1/assembly/results/final_vcf/${name}_final_variants.vcf
done
