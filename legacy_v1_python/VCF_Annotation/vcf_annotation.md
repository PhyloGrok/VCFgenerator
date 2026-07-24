## Steps for the current approach to annotate the VCF file using SnpEff:
Ref: https://eriqande.github.io/eca-bioinf-handbook/variant-annotation.html
### While in user's home:
### 1. Install SnpEff from Anaconda
```
conda install -c bioconda snpeff
snpEff
```

### 2. Get the path of the directory where the config file is
```
FIRSTDIR=$(dirname $(dirname $(which snpEff)))
TMP=$(dirname $(readlink -s `which snpEff`))
SNPEFFDIR=${FIRSTDIR}${TMP/../}
```
- the variable $SNPEFFDIR holds the directory where the config file is

### 3. Build a database for the reference genome (in this case, the NRC-1: GCF_000006805.1.fna)
#### Add the genome entry (for the database into the snpEff.config
- copy the config file over to the directory
```
mkdir -p resources/SnpEff
cp $SNPEFFDIR/snpEff.config  resources/SnpEff/
```
- Then we add the entry of the ref genome into the config file
```
echo "                    
# Halobact_NRC-1 genome, HsNRC-1
HsNRC-1.genome : Halobact_NRC-1
" >> resources/SnpEff/snpEff.config
```
- Essentially, the most important part is the prefix for `.genome`. The prefix `HsNRC-1` has to be the same with the name of the folder that contains our genome info for the next steps
```
mkdir -p resources/SnpEff/data/HsNRC-1
```
#### Put the necessary files into the genome folder (ref as database)
- Here, we have a folder called `HsNRC-1` in the user home (not to confuse with the folder within `resources/`)
- This folder contains all the ref genome info from NCBI. We need the genome sequence `.fna`, the `.gtf`/`.gff`, and the protein `.faa`
- Per the snpEff documentation, these ref info have to be renamed as such:
  - Ref genome sequence: `sequences.fa`
  - GTF files: `genes.gtf`
  - GFF files: `genes.gff`
  - Protein info: `protein.fa`
  - CDS file: `cds.fa`
- Note: Database building can use .gtf or .gff, depends on availability on NCBI or user's preference.
- Thus, when we copy the files, we also attempt to rename them according to the doc
```
cp HsNRC-1/GCF_000006805.1_ASM680v1_genomic.fna resources/SnpEff/data/HsNRC-1/sequences.fa
cp HsNRC-1/genomic.gtf resources/SnpEff/data/HsNRC-1/genes.gtf
cp HsNRC-1/protein.faa resources/SnpEff/data/HsNRC-1/protein.fa
cp HsNRC-1/genomic.gff resources/SnpEff/data/HsNRC-1/genes.gff
cp HsNRC-1/cds_from_genomic.fna resources/SnpEff/data/HsNRC-1/cds.fa
```
#### Build the database
- Note: run this command at user home, make sure there are 3 files inside the `resources/SnpEff/data/HsNRC-1/`
- With gtf files:     
```
snpEff build -Xmx4g  -noCheckCds -noCheckProtein -gtf22 -c resources/SnpEff/snpEff.config  -v HsNRC-1
```
- With gff files:
```
snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c resources/SnpEff/snpEff.config -v HsNRC-1
```
- *Note: it seems like SnpEff cannot recognize the systemic name, not the human readable gene name from the GFF files. Address in Issue.*
### 4. Run the annotation
- For now, we run annotation with no downstream, no upstream
#### Run with a single file:
```
snpEff ann -no-downstream -no-upstream -c resources/SnpEff/snpEff.config  HsNRC-1 pH_exp_vcfs/SRR9025102_final_variants.vcf > resources/SRR9025102_final_variants_annotated.vcf
```
- Specify more output files
```
snpEff ann -no-downstream -no-upstream -c resources/SnpEff/snpEff.config  HsNRC-1 HsNRC-1/pH_exp_vcfs/SRR9025102_final_variants.vcf > resources/SRR9025102_final_variants_annotated.vcf -s resources/SRR9025102_summary.html -csvStats resources/SRR9025102_annotated.csv
```

- To see the optional parameters, run `snpEff ann`
#### Run with multiple files:
- Make a bash script to run a for loop: see `snpeff_annotate.sh` 
- The command from the script takes 4 argument:
  - `-c`: the Snpeff.config file
  - `-d`: the database
  - `-i`: the input folder containing the files
  - `-o`: the output folder
``` 
./resources/snpeff_annotate.sh -c resources/SnpEff/snpEff.config -d HsNRC-1 -i pH_exp_vcfs/ -o resources/
```
- The output files should be located in the `resouces/` under {variant}_annotated.vcf along with the html, txt, and csv files

## Automating SnpEff Annotation
- Here, the annotation process will be automated, from building the custom database based on the reference genome downloaded from NCBI, to performing Snpeff annotation.
### Setting up the custom database
1. Resources
- To set up the resources folder: (in this case, the resources folder have already been created)
```
SNPEFF_PATH="/media/volume/sdb/resources/SnpEff"
```
- First, get the path of the directory where the main config file is:
```
FIRSTDIR=$(dirname $(dirname $(which snpEff)))
TMP=$(dirname $(readlink -s `which snpEff`))
SNPEFFDIR=${FIRSTDIR}${TMP/../}
```
- Copy it to the the resources folder
```
cp $SNPEFFDIR/snpEff.config  $SNPEFF_PATH
```
2. Reference data
- The reference data is located in the user specified folder, in this case, `bigrun2`
```
REFDIR="/media/volume/sdb/bigrun2/assembly/reference/ncbi_dataset/data"
REFPATH=$(find "$REFDIR" -type d -name "GCF*")
REFNAME=$(basename "$REFPATH")
ENTRY_INFO=$(find . -maxdepth 1 -name 'GCF*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)
```
3. Setting up the config file:
- First, you may need to provide access to the user: `sudo chmod a+rw $SNPEFF_PATH/snpEff.config`
- Run the following command to add the database entry to the config file:
```
echo "                    
# $ENTRY_INFO, $REFNAME
$REFNAME.genome : $REFNAME" >> $SNPEFF_PATH/snpEff.config
```
4. Setting up and build the database
- Create the database folder for the entry in the resources/:
```
mkdir -p $SNPEFF_PATH/data/$REFNAME
```
- Copy the reference files into the database folder
```
cp $REFPATH/GCF_*_genomic.fna $SNPEFF_PATH/data/$REFNAME/sequences.fa
cp $REFPATH/protein.faa $SNPEFF_PATH/data/$REFNAME/protein.fa
cp $REFPATH/genomic.gff $SNPEFF_PATH/data/$REFNAME/genes.gff
cp $REFPATH/cds_from_genomic.fna $SNPEFF_PATH/data/$REFNAME/cds.fa
```
- You may need to provide access to the user:
```
sudo chmod a+rw $SNPEFF_PATH/data/$REFNAME/*
sudo chmod a+w $SNPEFF_PATH/data/$REFNAME/
```
- Build the database with gff files
```
snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c $SNPEFF_PATH/snpEff.config -v $REFNAME
```
- Note: right now, the annotation has to be run with `-noCheckCds -noCheckProtein` due to conflicts between gff and the ref genome. 
### Run the annotation
- The built database is located in: `$SNPEFF_PATH/data/$REFNAME`
- The snpeff_annotate.sh is located in: resources/ so `$(dirname "$SNPEFF_PATH")/snpeff_annotate.sh`
- To run the annotation scripts:
```
$(dirname "$SNPEFF_PATH")/snpeff_annotate.sh -c $SNPEFF_PATH/snpEff.config -d $REFNAME -i pH_exp_vcfs/ -o ./test_annotation/
```
- The command from the script takes 4 arguments:
  - `-c`: the Snpeff.config file which is `$SNPEFF_PATH/snpEff.config`
  - `-d`: the database which is `$REFNAME`
  - `-i`: the input folder containing the files, `pH_exp_vcfs/`
  - `-o`: the output folder, `./test_annotation/`



