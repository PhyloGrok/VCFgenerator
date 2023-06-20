esearch -db genome  -query "txid2242" | efetch -format docsum | xtract -pattern DocumentSummary -element Assembly_Accession

esearch -db assembly -query GCA_004799605.1 | elink -target nucleotide -name \
        assembly_nuccore_refseq | efetch -format fasta > GCA_004799605.1.fa
