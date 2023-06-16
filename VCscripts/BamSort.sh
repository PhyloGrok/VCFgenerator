#!/bin/bash
for infile in results/bam/*.aligned.bam

do
        base=$(basename ${infile} .aligned.bam)
        echo ${infile}
        echo $base
        #samtools view -S -b results/sam/${base}.aligned.sam > results/bam/${base}.aligned.bam
        samtools sort -o results/bam/${base}.aligned.sorted.bam results/bam/${base}.aligned.bam
done
