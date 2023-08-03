#!/bin/bash

REFDIR="/media/volume/sdb/$1/assembly/reference/ncbi_dataset/data"
REFPATH=$(find "$REFDIR" -type d -name "GCF*")
REFNAME=$(basename "$REFPATH")

RESULT_PATH="/media/volume/sdb/$1/assembly/results"

ENTRY_INFO=$(find . -maxdepth 1 -name 'GCF*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)

FIRSTDIR=$(dirname $(dirname $(which snpEff)))
TMP=$(dirname $(readlink -s `which snpEff`))
SNPEFFDIR=${FIRSTDIR}${TMP/../}

SNPEFF_PATH="/media/volume/sdb/resources/SnpEff"
cp $SNPEFFDIR/snpEff.config  $SNPEFF_PATH
sudo chmod a+rw $SNPEFF_PATH/snpEff.config

echo "                    
# $ENTRY_INFO, $REFNAME
$REFNAME.genome : $REFNAME" >> $SNPEFF_PATH/snpEff.config

mkdir -p $SNPEFF_PATH/data/$REFNAME

cp $REFPATH/GCF_*_genomic.fna $SNPEFF_PATH/data/$REFNAME/sequences.fa
cp $REFPATH/genomic.gtf $SNPEFF_PATH/data/$REFNAME/genes.gtf
cp $REFPATH/protein.faa $SNPEFF_PATH/data/$REFNAME/protein.fa
cp $REFPATH/genomic.gff $SNPEFF_PATH/data/$REFNAME/genes.gff
cp $REFPATH/cds_from_genomic.fna $SNPEFF_PATH/data/$REFNAME/cds.fa

sudo chmod a+rw $SNPEFF_PATH/data/$REFNAME/*
sudo chmod a+w $SNPEFF_PATH/data/$REFNAME/

snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c $SNPEFF_PATH/snpEff.config -v $REFNAME

$(dirname "$SNPEFF_PATH")/snpeff_annotate.sh -c $SNPEFF_PATH/snpEff.config -d $REFNAME -i $RESULT_PATH/final_vcf/ -o $RESULT_PATH/annotation/
