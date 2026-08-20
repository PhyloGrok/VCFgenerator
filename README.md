
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10552756.svg)](https://doi.org/10.5281/zenodo.10552756)
# VCFgenerator
Automated variant calling from NCBI SRA Illumina microbial WGS raw sequence .fastq data.<br>
*For citations and acknowledgements please see paper.md

## Workflow Description
1. <b>Data Retrieval.</b> Uses EDirect, ncbi-datasets, and sra-toolkit to download reference genomes and .fastq data files by user-defined NCBI taxonomy ID.
2. <b>Sequence QC</b> Runs <em>trimmomatic</em> and <em>fastqc</em> on the downloaded .fastq files.
3. <b>variant Calling</b> Aligns .fastq sequences to the reference genome using <em>bwa</em>. Standard variant calling with <em>SAMtools</em> and <em>BCFtools</em>, generating variant calling format (.vcf) files as output.
4. <b>Annotation</b> Annotates .vcf files using <em>SNPeff</em> and reference genome standard .gff/.gtf annotation files. 

## Associated Dataset
1. 300+ Annotated VCF's accessioned in Zenodo Repository.

## Prerequisites

Before running the pipeline, ensure your host system or cloud instance has the following installed:
 
1. **Docker** (v20.10+ recommended)
2. **Java 17 or later** (Required to run the Nextflow orchestrator)
3. **Nextflow 26 or later** (Required workflow manager)

### Host System Setup

For a fresh Ubuntu 22/Jetstream2 VM, initialize your environment: 

```bash
# Install Java 17
sudo apt-get update && sudo apt-get install -y openjdk-17-jre-headless

# Install Nextflow globally
curl -s https://get.nextflow.io | bash sudo mv nextflow /usr/local/bin/
```

## Production Execution
1. Build the Docker container
```
docker build -t vcfgenerator:latest .
```
2. Be prepared with the absolute filepath to your storage drive, and your NCBI TaxID of interest.<br>
Be aware that well-studied species (such as E. coli and Staph aureus) have thousands of individual .fastq files in the SRA database, most environments will not support this size of data.<br>  
Know your collection size, and limit your taxonomy ID to those with smaller collection sizes.

3. Launch the complete sequential pipeline with the interactive launcher script:
```
bash ./run_vcf_pipeline.sh 
```
