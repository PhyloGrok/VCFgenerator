## In here we had a little issue with NCBI datasets getting the wrong genome.  Ie Hs 91-R6 is the same as "txid2242", while Hs NRC-1 is "txid64091" 
## This may be an issue with a broken or inconsistent link in ncbi-datasets, which recently left the beta status

esearch -db genome  -query "txid2242" | efetch -format docsum | xtract -pattern DocumentSummary -element Assembly_Accession
esearch -db genome  -query "txid64091" | efetch -format docsum | xtract -pattern DocumentSummary -element Assembly_Accession
## The second search retrieves the 91-R6 dataset, not the NRC-1 dataset

esearch -db assembly -query GCA_004799605.1 | elink -target nucleotide -name \
        assembly_nuccore_refseq | efetch -format fasta > GCA_004799605.1.fa

## However, if we use the correct assembly id for NRC-1 (from the ncbi database genome page for NRC-1), we get the correct dataset
datasets download genome accession GCF_000006805.1 --include gff3,rna,cds,protein,genome,seq-report --filename GCF_000006805.1.zip
