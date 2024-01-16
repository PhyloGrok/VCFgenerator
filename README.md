# VCFgenerator
Automated variant calling and Shiny dashboard for NextGen evolutionary genomics.<br>

Environment: Ubuntu 20.02 VM configured with required software packages described in OmicsVMconfigure (https://github.com/PhyloGrok/OmicsVMconfigure)

## Usage
1. Clone VCFgenerator repo ```git clone https://github.com/PhyloGrok/VCFgenerator``` in your Ubuntu 20.02 Linux user/home directory.
2. Run ```sudo python VCFgenerator/Python_Hub/Controller.py```
3. User will be prompted for 5 inputs, used to run the workflow:

![](/Workflow-Chart.png)

## Workflow Description
1. <b><u>download.py</u></b> Data Retrieval.  Downlaods reference genome and BioProject-linked SRA files base on user-provided data.  Currently works only with Illumina paired-end .fastq files, sequenced from genomics DNA data from a whole genome sequencing strategy.  Uses <em>ncbi EDirect, ncbi-datasets, and sra-toolkit</em> APIs.
2. <b>trimmomatic.py</b> Data QC - Runs <em>trimmomatic</em> and <em>fastqc</em> on the .fastq sra files.
3. <b>variants.py</b> Assembly and Variant Calling - Performs alignment of .fastq sequences to the reference genome using <em>bwa</em>.  Performed variant calling with <em>SAMtools</em> and <em>BCFtools</em>, generating variant calling format (.vcf) files as output.
4. <b>annotations.py</b> VCF annotation - Annotates the .vcf files using <em>SNPeff</em> and reference genome .gff/.gtf annotation files. 
5. Shiny Dashboard (nonfunctional, in development) - Transfers annotated .vcf data to a <em>SQLite</em> database, imports into an R dataframe and plots genomes in <em>R Shiny</em> dashboard with a stacked barplot of mutation types by sample, and displays a circos-style plot annotated showing called variants from multiple (up to 5 genomic BioSamples).

## Demonstration Data
1. NCBI BioProject PRJNA541441 (15 .fastq SRA files). "Iron and Acid Adapted Strains of Halobacterium sp. NRC-1 obtained by Experimental Evolution" <em>initial testing</em><br>
2. NCBI BioProject PRJNA844510 (67 .fastq SRA files). Halobacterium mutation acumulation lines. <em>testing for BGIseq and for scaled-up throughput<em?<br>

## Future Goals
1. Incorporate a mummer branch for the workflow.
2. Comparative genomics Shiny app.
3. Microbial human pathogen analysis.

## Acknowledgements
1. <em>Data Carpentry Genomics Workshop</em> (https://datacarpentry.org/genomics-workshop/) was the original template for the QC, alignment and variant calling steps.  Here we focused on a command-line implementation, with user specification, and high-throughput automated processing in Linux Ubuntu-based cloud vm.<br>
2. <b>Lenski Long-Term E. coli Evolution (LTEE) experiment</b>.  The analysis of genomic variants follows the concept of Tenaillon et al. 2016 and other publications and content from the LTEE (https://lenski.mmg.msu.edu/ecoli/genomicsdat.html).
3. See Citations.md for many additional citations and resources.

## Funding

This work used Jetstream2 at Indiana University (IU) through research allocation <b>BIO220099</b> from the Advanced Cyberinfrastructure Coordination Ecosystem: Services & Support (ACCESS) program, which is supported by National Science Foundation grants #2138259, #2138286, #2138307, #2137603, and #2138296.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through research startup allocation  <b>BIO210100</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

This work used Jetstream at Indiana Universery/Texas Advanced Computing Center (IU/TACC) through educational allocation  <b>MCB200044</b> from the Extreme Science and Engineering Discovery Environment (XSEDE), which was supported by National Science Foundation grant number #1548562.

Undergraduate student interns Lloyd Jones III, Nhi Luu, and Jan Le were supported by Merck <b>Data Science in the Life Sciences Fellowship</b>

## Citations

Erin Alison Becker, Tracy Teal, François Michonneau, Maneesha Sane, Taylor Reiter, Jason Williams, et al. (2019, June). 
datacarpentry/genomics-workshop: Data Carpentry: Genomics Workshop Overview, June 2019 (Version v2019.06.1). 
Zenodo. http://doi.org/10.5281/zenodo.3260309

David Y. Hancock, Jeremy Fischer, John Michael Lowe, Winona Snapp-Childs, Marlon Pierce, Suresh Marru, J. Eric Coulter, Matthew Vaughn, Brian Beck, Nirav Merchant, Edwin Skidmore, and Gwen Jacobs. 2021. “Jetstream2: Accelerating cloud computing via Jetstream.” In Practice and Experience in Advanced Research Computing (PEARC ’21). Association for Computing Machinery, New York, NY, USA, Article 11, 1–8. DOI: https://doi.org/10.1145/3437359.3465565

Stewart, C.A., Cockerill, T.M., Foster, I., Hancock, D., Merchant, N., Skidmore, E., Stanzione, D., Taylor, J., Tuecke, S., Turner, G., Vaughn, M., and Gaffney, N.I., “Jetstream: a self-provisioned, scalable science and engineering cloud environment.” 2015, In Proceedings of the 2015 XSEDE Conference: Scientific Advancements Enabled by Enhanced Cyberinfrastructure. St. Louis, Missouri. ACM: 2792774. p. 1-8. DOI: https://dx.doi.org/10.1145/2792745.2792774

Tenaillon O, Barrick JE, Ribeck N, et al. Tempo and mode of genome evolution in a 50,000-generation experiment. Nature. 2016;536(7615):165-170. doi:10.1038/nature18959

Towns, J, and T Cockerill, M Dahan, I Foster, K Gaither, A Grimshaw, V Hazlewood, S Lathrop, D Lifka, GD Peterson, R Roskies, JR Scott. “XSEDE: Accelerating Scientific Discovery”, Computing in Science & Engineering, vol.16, no. 5, pp. 62-74, Sept.-Oct. 2014, doi:10.1109/MCSE.2014.80

