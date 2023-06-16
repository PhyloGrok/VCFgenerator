#!/bin/bash
for infile in results/bam/*.aligned.sorted.bam

do
        base=$(basename ${infile} .aligned.sorted.bam)
        echo ${infile}
        echo $base
        bcftools mpileup -O b -o results/bcf/${base}_raw.bcf \
        -f HsRefGenome.fa results/bam/${base}.aligned.sorted.bam
done

#If errors occur with the reference file after -f, check directory as that seems to be the main issue with the script
