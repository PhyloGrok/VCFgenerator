#!/bin/bash
for infile in results/bam/*.aligned.sorted.bam

do
        base=$(basename ${infile} .aligned.sorted.bam)
        echo ${infile}
        echo $base
        #samtools view -S -b results/sam/${base}.aligned.sam > results/bam/${base}.aligned.bam
        bcftools mpileup -O b -o results/bcf/$(base)_raw.bcf -f ../../assemblty/HsRefGenome.fa  results/bam/SRR2584866.aligned.sorted.bam
done
