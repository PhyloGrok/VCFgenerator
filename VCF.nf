params.ref="/home/elaysha/dc_workshop/data/ref_genome/GCA_004799605.1_ASM479960v1_genomic.fna"
params.index_dir="/home/elaysha/dc_workshop/data/ref_genome/index_dir"

process index {

publishDir("${params.index_dir}", mode: 'copy')

input:
 path genome

output:
 path "${genome}.bwt", emit: ref_genome

script:
"""
bwa index $genome

"""

}

workflow {

ref_ch=Channel.fromPath(params.ref)

index(ref_ch)
index.out.ref_genome.view()

}
