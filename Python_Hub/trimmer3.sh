#!bin/bash
#LloydJonesIII
trimmomatic PE ../../media/volume/sdb/$1/fastq/${2}_1.fastq.gz ../../media/volume/sdb/$1/fastq/${2}_2.fastq.gz \
../../media/volume/sdb/$1/fastq/trimmed/${2}_1.trim.fastq.gz ../../media/volume/sdb/$1/fastq/untrimmed/${2}_1.untrim.fastq.gz \
../../media/volume/sdb/$1/fastq/trimmed/${2}_2.trim.fastq.gz ../../media/volume/sdb/$1/fastq/untrimmed/${2}_2.untrim.fastq.gz \
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:../../media/volume/sdb/NexteraPE-PE.fa:2:40:15 