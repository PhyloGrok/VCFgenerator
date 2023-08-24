#!/bin/bash
## NLuu, LJones, JRobinson
## User Inputs
# $1 = directory name
# $3 = directory path
echo $1
echo $2
echo $3

REFDIR="$3/$1/assembly/reference/ncbi_dataset/data"

REFPATH=$(find "$REFDIR" -type d -name "GCF*")

REFNAME=$(basename "$REFPATH")


RESULT_PATH="$3/$1/assembly/results"

RESOURCE_PATH="$3/$1/assembly/resources"

ENTRY_INFO=$(find . -maxdepth 1 -name 'GCF*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)


FIRSTDIR=$(dirname $(dirname $(which snpEff)))

TMP=$(dirname $(readlink -s `which snpEff`))

SNPEFFDIR=${FIRSTDIR}${TMP/../}

mkdir -p ${RESOURCE_PATH}/SnpEff

SNPEFF_PATH="$3/$1/assembly/resources/SnpEff"

cp ${SNPEFFDIR}/snpEff.config  $SNPEFF_PATH


echo "                    

# $ENTRY_INFO, $REFNAME

$REFNAME.genome : $REFNAME" >> $SNPEFF_PATH/snpEff.config


mkdir -p $SNPEFF_PATH/data/$REFNAME


cp $REFPATH/GCF_*_genomic.fna $SNPEFF_PATH/data/$REFNAME/sequences.fa

cp $REFPATH/protein.faa $SNPEFF_PATH/data/$REFNAME/protein.fa

cp $REFPATH/genomic.gff $SNPEFF_PATH/data/$REFNAME/genes.gff

cp $REFPATH/cds_from_genomic.fna $SNPEFF_PATH/data/$REFNAME/cds.fa


snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c $SNPEFF_PATH/snpEff.config -v $REFNAME

$2 -c $SNPEFF_PATH/snpEff.config -d $REFNAME -i $RESULT_PATH/final_vcf/ -o $RESULT_PATH/annotation/
