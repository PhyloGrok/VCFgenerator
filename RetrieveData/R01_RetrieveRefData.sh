#!/bin/bash
## This code uses NCBI Datasets to download reference genomes, annotation files, and metadata for reference taxa genomes
## These dataset collections will be used for within- and between-species comparisons
datasets download genome taxon 2242 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename NRC1complete.zip
