# VCFgenerator
Automated variant calling and Shiny dashboard for NextGen evolutionary genomics.<br>

Environment: Ubuntu 20.02 VM configured with required software packages described in OmicsVMconfigure (https://github.com/PhyloGrok/OmicsVMconfigure)

## Usage
1. Gitclone VCFgenerator repository into your Ubuntu 20.02 Linux user/home directory.
2. Run the command ```sudo python VCFgenerator/Python_Hub/Controller.py```
3. User will be prompted for 4 inputs:
   0) project name (string),
   1) NCBI BioProject ID (string, starts with PRJNA),
   2) Reference species ncbi taxon ID (txid) (integer),
   3) are the paired-end .fastq files split? (yes/no),
   4) filepath for results directory or storage volume mount point (string) (ie. "/media/volume/sdb/").

## Workflow Description
1. fastqc and Reference Data Retrieval - Takes a user-input BioProjectID to retrieve .fastq files and reference genome data for a user-specified BioProject. (Currently works will Illumina-sequence genomic DNA data).  Uses sratoolkit and ncbi-datasets APIs.
2. Data QC - Runs Trimmomatic and fastqc on the .fastq files.
3. Assembly and Variant Calling - Uses BWA to assemble Illumina paired-end sequences to reference genome, process files with SAMtools and BCFtools to generate variant calling format (.vcf) files
4. VCF annotation - Uses SNPeff to annotate .vcf files using the reference genome .gff/.gtf annotation files.
5. Shiny Dashboard - Transfers .vcf data to SQLite database, displays a stacked barplot of mutation types by sample, and displays a circos-style plot annotated showing called variants from multiple (up to 5 genomic BioSamples).

## Demonstration Data
1. Halobacterium pH experiment 
2. Halobacterium mutation acumulation lines experiment

## Future Goals

## Acknowledgements
1. The <em>Data Carpentry Genomics Workshop</em> (https://datacarpentry.org/genomics-workshop/) was the original template and inspiration for the Illumina QC, BWA assembly and variant calling steps of this workflow.  Implementation here has been modified for user specification of the dataset, high-throughput automated processing within a Linux Ubuntu-based command-line environment with many additonal upstream and downstream features for automation and data dashboard. <br>
2. Lenski Long-Term E. coli Evolution (LTEE) experiment.  The strategy for analysis of genomic variants was inspired by Tenaillon et al. 2016 and other publications and content from the LTEE (https://lenski.mmg.msu.edu/ecoli/genomicsdat.html). 

## Funding

This work used Jetstream2 at Indiana University (IU) through research allocation <b>BIO220099</b> from the Advanced Cyberinfrastructure Coordination Ecosystem: Services & Support (ACCESS) program, which is supported by National Science Foundation grants #2138259, #2138286, #2138307, #2137603, and #2138296.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through research startup allocation  <b>BIO210100</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through educational allocation  <b>MCB200044</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

Undergraduate student interns Lloyd Jones III and Nhi Luu were supported by Merck <b>Data Science in the Life Sciences Fellowship</b>

## Citations

Erin Alison Becker, Tracy Teal, François Michonneau, Maneesha Sane, Taylor Reiter, Jason Williams, et al. (2019, June). 
datacarpentry/genomics-workshop: Data Carpentry: Genomics Workshop Overview, June 2019 (Version v2019.06.1). 
Zenodo. http://doi.org/10.5281/zenodo.3260309

David Y. Hancock, Jeremy Fischer, John Michael Lowe, Winona Snapp-Childs, Marlon Pierce, Suresh Marru, J. Eric Coulter, Matthew Vaughn, Brian Beck, Nirav Merchant, Edwin Skidmore, and Gwen Jacobs. 2021. “Jetstream2: Accelerating cloud computing via Jetstream.” In Practice and Experience in Advanced Research Computing (PEARC ’21). Association for Computing Machinery, New York, NY, USA, Article 11, 1–8. DOI: https://doi.org/10.1145/3437359.3465565

Stewart, C.A., Cockerill, T.M., Foster, I., Hancock, D., Merchant, N., Skidmore, E., Stanzione, D., Taylor, J., Tuecke, S., Turner, G., Vaughn, M., and Gaffney, N.I., “Jetstream: a self-provisioned, scalable science and engineering cloud environment.” 2015, In Proceedings of the 2015 XSEDE Conference: Scientific Advancements Enabled by Enhanced Cyberinfrastructure. St. Louis, Missouri. ACM: 2792774. p. 1-8. DOI: https://dx.doi.org/10.1145/2792745.2792774

Tenaillon O, Barrick JE, Ribeck N, et al. Tempo and mode of genome evolution in a 50,000-generation experiment. Nature. 2016;536(7615):165-170. doi:10.1038/nature18959

Towns, J, and T Cockerill, M Dahan, I Foster, K Gaither, A Grimshaw, V Hazlewood, S Lathrop, D Lifka, GD Peterson, R Roskies, JR Scott. “XSEDE: Accelerating Scientific Discovery”, Computing in Science & Engineering, vol.16, no. 5, pp. 62-74, Sept.-Oct. 2014, doi:10.1109/MCSE.2014.80

