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

### 3. Build a database for the reference genome (in this case, the NRC-1 GCF_004*.fna)
#### Add the genome entry (for the database into the snpEff.config
- copy the config file over to the directory
```
mkdir -p resources/SnpEff
cp $SNPEFFDIR/snpEff.config  resources/SnpEff/
```
- Then we add the entry of the ref genome into the config file
```
echo "                    

# Halobact_91-R6 genome, Hs91-R6

Hs91-R6.genome : Halobact_91-R6

" >> resources/SnpEff/snpEff.config
```
- Essentially, the most important part is the prefix for `.genome`. The prefix `Hs1asm` has to be the same with the name of the folder that contains our genome info for the next steps
```
mkdir -p resources/SnpEff/data/Hs91-R6
```
#### Put the necessary files into the genome folder (ref as database)
- Here, we have a folder called `Hs91-R6/` in the user home (not to confuse with the folder within `resources/`)
- This folder contains all the ref genome info from NCBI. We need the genome sequence `.fna`, the `.gtf`, and the protein `.faa`
- Per the snpEff documentation, these ref info have to be renamed as such:
  - Ref genome sequence: `sequences.fa`
  - GTF files: `genes.gtf`
  - Protein info: `protein.fa`
- Thus, when we copy the files, we also attempt to rename them according to the doc
```
cp Hs91-R6/GCF_004799605.1_ASM479960v1_genomic.fna resources/SnpEff/data/
sequences.fa
cp Hs91-R6/genomic.gtf resources/SnpEff/data/genes.gtf
cp Hs91-R6/protein.faa resources/SnpEff/data/protein.fa
cp Hs91-R6/genomic.gff resources/SnpEff/data/genes.gff
```
- Move the files into the ref-genome database folder `Hs91-R6/`
```
mv resources/SnpEff/data/{sequences.fa,genes.gtf,protein.fa} resources/SnpEff/data/Hs91-R6/
```
#### Build the database
- Note: run this command at user home, make sure there are 3 files inside the `resources/SnpEff/data/Hs91-R6/`
```
snpEff build -Xmx4g  -noCheckCds -noCheckProtein -gtf22 -c resources/SnpEff/snpEff.config  -v Hs91-R6
```
### 4. Run the annotation
- For now, we run annotation without optional parameters
```
snpEff ann -c resources/SnpEff/snpEff.config  Hs91-R6 Hs91-R6/pH_exp_vcfs/SRR9025102_final_variants.vcf > resources/SRR9025102_final_variants_annotated.vcf
```
- To see the optional parameters, run `snpEff ann`
