#!/bin/bash
for infile in results/sam/*.aligned.sam

do
        base=$(basename ${infile} .aligned.sam)
        echo ${infile}
        echo $base
        samtools view -S -b results/sam/${base}.aligned.sam > results/bam/${base}.aligned.bam
done
