#!/bin/bash

## download all genomic fastas from a specific higher taxa into a single multifasta
 esearch -db genome  -query "txid22" | elink -target nuccore | efetch -format fasta  > txid22.fasta


## use a specific taxon id to retrieve the assembly accession uids:
esearch -db genome -query "txid70863" | efetch -format docsum | xtract -pattern DocumentSummary -element Assembly_Accession

## use an assembly accession ID to download a genomic fasta
esearch -db assembly -query GCA_000146165.2 | elink -target nucleotide -name assembly_nuccore_refseq | efetch -format fasta > GCA_000146165.2.fa
