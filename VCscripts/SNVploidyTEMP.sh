#!/bin/bash
for infile in results/bcf/*.bcf

do
        base=$(basename ${infile} .bcf)
        echo ${infile}
        echo $base
        bcftools call --ploidy 1 -m -v -o results/vcf/${base}_variants.vcf results/bcf/${base}.bcf
done

