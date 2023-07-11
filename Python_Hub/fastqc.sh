#!/bin/bash
#LloydJonesIII
echo 'Running the fastqc'
## fastqc process 
fastqc ../../media/volume/sdb/$1/fastq/trimmed/*.trim.fastq.gz
echo 'fastqc has finished'