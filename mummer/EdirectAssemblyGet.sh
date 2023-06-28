#!/bin/bash
filename='ShewanellaList.txt'

echo Start

## Test the iteration through the list
for line in $(cat ShewanellaList.txt)
do
echo "$line"
done

for line in $(cat ShewanellaList.txt)
do
esearch -db assembly -query "$line" | \
efetch -format docsum | \
xtract -pattern DocumentSummary -element FtpPath_RefSeq | \
awk -F "/" '{print $0"/"$NF"_genomic.fna.gz"}' | \
xargs wget
done
