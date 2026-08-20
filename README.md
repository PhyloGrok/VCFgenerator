
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10552756.svg)](https://doi.org/10.5281/zenodo.10552756)
# VCFgenerator
Automated variant calling from NCBI SRA Illumina microbial WGS raw sequence .fastq data.<br>

## Workflow Description
1. <b>Data Retrieval.</b> Uses EDirect, ncbi-datasets, and sra-toolkit to download reference genomes and .fastq data files by user-defined NCBI taxonomy ID.
2. <b>Sequence QC</b> Runs <em>trimmomatic</em> and <em>fastqc</em> on the downloaded .fastq files.
3. <b>variant Calling</b> Aligns .fastq sequences to the reference genome using <em>bwa</em>. Standard variant calling with <em>SAMtools</em> and <em>BCFtools</em>, generating variant calling format (.vcf) files as output.
4. <b>Annotation</b> Annotates .vcf files using <em>SNPeff</em> and reference genome standard .gff/.gtf annotation files. 

## Associated Dataset
1. 300+ Annotated VCF's accessioned in Zenodo Repository.

## Funding

This work used Jetstream2 at Indiana University (IU) through research allocation <b>BIO220099</b> from the Advanced Cyberinfrastructure Coordination Ecosystem: Services & Support (ACCESS) program, which is supported by National Science Foundation grants #2138259, #2138286, #2138307, #2137603, and #2138296.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through research startup allocation  <b>BIO210100</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through educational allocation  <b>MCB200044</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

UMBC Translational Life Science Technology (TLST) student interns Lloyd Jones III, Nhi Luu, and Jan Le supported by <em>Merck Data Science Fellowship for Observational Research Program</em> and the <em>UMBC College of Natural and Mathematical Sciences</em></b>.  Lloyd Jones III developed the variant calling workflow framework and workflow integration. Nhi Luu developed the annotation scripts and R-Shiny framework and integration. Jan Le prepared the "Iron and Acid Adaptation" analysis, developed EDirect scripts, and troubleshooted throughout the workflow.  Additionally, TLST student Gina Hwang contributed to the MUMMER branch of the workflow.

## Prerequisites

Before running the pipeline, ensure your host system or cloud instance has the following installed:
 
1. **Docker** (v20.10+ recommended)
2. **Java 17 or later** (Required to run the Nextflow orchestrator)

### Host System Setup

For a fresh Ubuntu 22/Jetstream2 VM, initialize your environment: 

```bash
# Install Java 17
sudo apt-get update && sudo apt-get install -y openjdk-17-jre-headless

# Install Nextflow globally
curl -s https://nextflow.io | bash sudo mv nextflow /usr/local/bin/ 
```

## Production Execution
Once your local system prerequisites are ready and your Docker image is built (`docker build -t vcfgenerator:latest .`), launch the complete 
end-to-end sequential workflow using our interactive launcher script:
```bash ./run_vcf_pipeline.sh ```
