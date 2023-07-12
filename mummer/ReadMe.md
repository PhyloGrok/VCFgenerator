### Mummer dotplot generate

Demo: Mummer dotplots with Shewanella oneidensis MR-1 vs all other species within genus Shewanella that have Complete-quality RefSeq genomes.

#### Workflow:
1. Retrieve a list of genomes assembly accessions from Genus Shewanella, and filter them for "Complete RefSeq" status.  This has been a little difficult because the same species genome assemblies are duplicated in the database.  (accession GCF_* denotes RefSeq and GCA_* denotes GenBank, but with the same assembly number).  *One pending task here is add a step to retrieve and filter these assembly results for RefSeq genomes.  This can be done manually through the NCBI datasets website by selecting Shewanella genus, filtering for "Reference Genomes", "Annotated Genomes", and "Complete-level", then downloading the .tsv file.  (See ncbi_dataset in the mummer directory)

2. 
3. 

#### Resources:
1. Genus Shewanella NCBI Taxonomy browser page: https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=22&lvl=3&lin=f&keep=1&srchmode=1&unlock
2. NCBI Genome Dataset, filtered for RefSeq "Complete-level" genomes: https://www.ncbi.nlm.nih.gov/datasets/genome/?taxon=22&reference_only=true&assembly_level=3%3A3
3. Mummer reference manual: https://mummer4.github.io/tutorial/tutorial.html
4. Circos-style alternative visualization of genomic alignments: https://taylorreiter.github.io/2019-05-11-Visualizing-NUCmer-Output/
