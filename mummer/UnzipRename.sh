#!/bin/bash
#JanGina

#Unzip .gz files

for infile in ShewanellaAssemblies/*.fna.gz;
do gzip -d $infile
done

##Unzip ends

echo "Unzip done"

#Rename .fna to .fasta

for infile in ShewanellaAssemblies/*.fna;
do mv -- $infile ${infile%.fna}.fasta;
done

##Rename ends

echo "Renamed files from .fna to .fasta"
