#!/bin/bash
echo $1
echo $2
FILES="/media/volume/sdb/test1/fastq/untrimmed/*.fastq"
for f in $FILES
do
  echo "zipping $f"
  gzip "$f"
done
