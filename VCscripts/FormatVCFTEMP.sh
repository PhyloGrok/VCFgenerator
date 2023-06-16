#!/bin/bash
for infile in results/vcf/*_raw_variants.vcf

do
        base=$(basename ${infile} _raw_variants.vcf)
        echo ${infile}
        echo $base
        vcfutils.pl varFilter results/vcf/${base}_raw_variants.vcf  > results/vcf/${base}_final_variants.vcf
done

