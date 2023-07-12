## Data from different sources:
*July 2023, NCBI is transitioning from the old framework of the Genome database, into a new framework called NCBI-datasets.
Although these are good because they compile data within a single source, it is still Beta, and there can be some glitches.
For example, we find that trying to download a RefSeq genome assembly using taxonomy ID for one strain can download the wrong reference genome.

### 1. (R01.sh) Generate lists of AssemblyIDs, BioprojectIDs, and SRA accession IDs using NCBI EDirect API.  
  -Generate a list of SRA accessions based on their BioProject ID.
  -Generate a list of RefSeq assembly IDs base on a taxonomic UID from genus-level or higher.

### 2. Download reference datasets using NCBI-Datasets API.  The complete dataset contains important files for genome processing including:
  -The RefSeq genome assembly .fasta file
  -The .gff and .gtf annotation files.
  -Fasta files of the Protein sequences.
  -Fasta files of the coding RNA sequences.

### 3. Download SRA datasets using NCBI SRA-toolkit/SRA-tools
  -Currently we are focused primarily on genomic DNA variant calling from NextGen Illumina platform.
  -We will branch out eventually into RNA-seq and ChIP-seq data, and also NextGen long-read sequence from PacBio and Nanopore.


