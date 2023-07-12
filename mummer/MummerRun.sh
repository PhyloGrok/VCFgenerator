#!/bin/bash
#JanGina (Critic-ism and ginaah)

#Run mummer4
##Mummer4 will be run for each .fasta file and outputted to the .mums file with the basename of the .fasta files

for infile in ShewanellaAssemblies/*.fasta;
do base=$(basename ${infile} .fasta);
mummer -mum -b -c So_MR1.fasta $infile > ShewanellaAssemblies/${base}.mums
done

echo "Mummer complete."

#Run mummerplot
##Mummerplot will be run for each .mums file. The outputs will be renamed according to the .mums file.

for infile in ShewanellaAssemblies/*.mums;
        do base=$(basename ${infile} .mums);
        mummerplot -x "[0,5200000]" -y "[0,5200000]" -png -p mummer $infile;
                mv mummer.png  $base.png;
done

echo "Mummerplots complete."

#Move .png files into selected directory

mv *genomic.png ShewanellaAssemblies

echo "Mummer4 run complete"
