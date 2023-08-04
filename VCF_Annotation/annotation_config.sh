#!/bin/bash
##Nluu

REFDIR="/media/volume/sdb/$1/assembly/reference/ncbi_dataset/data"
REFPATH=$(find "$REFDIR" -type d -name "GCF*")
REFNAME=$(basename "$REFPATH")

RESULT_PATH="/media/volume/sdb/$1/assembly/results"

RESOURCE_PATH="/media/volume/sdb/$1/assembly/resources"

ENTRY_INFO=$(find . -maxdepth 1 -name 'GCF*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)

FIRSTDIR=$(dirname $(dirname $(which snpEff)))
TMP=$(dirname $(readlink -s `which snpEff`))
SNPEFFDIR=${FIRSTDIR}${TMP/../}

sudo mkdir -p $RESOURCE_PATH/SnpEff

SNPEFF_PATH="/media/volume/sdb/$1/assembly/resources/SnpEff"
sudo cp $SNPEFFDIR/snpEff.config  $SNPEFF_PATH
sudo chmod a+rw $SNPEFF_PATH/snpEff.config

echo "                    
# $ENTRY_INFO, $REFNAME
$REFNAME.genome : $REFNAME" >> $SNPEFF_PATH/snpEff.config

sudo mkdir -p $SNPEFF_PATH/data/$REFNAME

sudo cp $REFPATH/GCF_*_genomic.fna $SNPEFF_PATH/data/$REFNAME/sequences.fa
sudo cp $REFPATH/genomic.gtf $SNPEFF_PATH/data/$REFNAME/genes.gtf
sudo cp $REFPATH/protein.faa $SNPEFF_PATH/data/$REFNAME/protein.fa
sudo cp $REFPATH/genomic.gff $SNPEFF_PATH/data/$REFNAME/genes.gff
sudo cp $REFPATH/cds_from_genomic.fna $SNPEFF_PATH/data/$REFNAME/cds.fa

sudo chmod a+rw $SNPEFF_PATH/data/$REFNAME/*
sudo chmod a+w $SNPEFF_PATH/data/$REFNAME/

snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c $SNPEFF_PATH/snpEff.config -v $REFNAME

$2 -c $SNPEFF_PATH/snpEff.config -d $REFNAME -i $RESULT_PATH/final_vcf/ -o $RESULT_PATH/annotation/
