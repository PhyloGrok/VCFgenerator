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
- First, locate the resources/ folder, and the reference data folder

### Reference data:
- The reference data is located in the user specified folder, in this case, `bigrun2`
```
REFDIR="/media/volume/sdb/bigrun2/assembly/reference/ncbi_dataset/data"
REFPATH=$(find "$REFDIR" -type d -name "GCF*")  -> "/media/volume/sdb/bigrun2/assembly/reference/ncbi_dataset/data/GCF_004799605.1"
REFNAME=$(basename "$REFPATH")  -> "GCF_004799605.1"
ENTRY_INFO=$(find . -maxdepth 1 -name 'GCF*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)
```







