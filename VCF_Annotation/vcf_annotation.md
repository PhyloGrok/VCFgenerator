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

# Halobact_NRC-1 genome, HsNRC-1

Hs1asm.genome : Halobact_NRC-1

" >> resources/SnpEff/snpEff.config
```
- Essentially, the most important part is the prefix for `.genome`. The prefix `Hs1asm` has to be the same with the name of the folder that contains our genome info for the next steps
```
mkdir -p resources/SnpEff/data/Hs1asm
```
#### Put the necessary files into the genome folder (ref as database)
- Here, we have a folder called `Hs1asm/` in the user home (not to confuse with the folder within `resources/`)
- This folder contains all the ref genome info from NCBI. We need the genome sequence `.fna`, the `.gtf`, and the protein `.faa`
- Per the snpEff documentation, these ref info have to be renamed as such:
  - Ref genome sequence: `sequences.fa`
  - GTF files: `genes.gtf`
  - Protein info: `protein.fa`
- Thus, when we copy the files, we also attempt to rename them according to the doc
```
cp Hs1asm/GCF_004799605.1_ASM479960v1_genomic.fna resources/SnpEff/data/
sequences.fa
cp Hs1asm/genomic.gtf resources/SnpEff/data/genes.gtf
cp Hs1asm/protein.faa resources/SnpEff/data/protein.fa
```
- Move the files into the ref-genome database folder `Hs1asm/`
```
mv resources/SnpEff/data/{sequences.fa,genes.gtf,protein.fa} resources/SnpEff/data/Hs1asm/
```
#### Build the database
- Note: run this command at user home, make sure there are 3 files inside the `resources/SnpEff/data/Hs1asm/`
```
snpEff build -Xmx4g  -noCheckCds -noCheckProtein -gtf22 -c resources/Snp
Eff/snpEff.config  -v Hs1asm
```
### 4. Run the annotation
- For now, we run annotation without optional parameters
```
snpEff ann -c resources/SnpEff/snpEff.config  Hs1asm Hs1asm/pH_exp_vcfs/
SRR9025102_final_variants.vcf > resources/SRR9025102_final_variants_annotated.vcf
```
- To see the optional parameters, run `snpEff ann`
