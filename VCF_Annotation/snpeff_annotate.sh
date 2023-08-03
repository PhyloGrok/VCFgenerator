#!/bin/bash
# Parse command-line options
while getopts "c:d:i:o:" opt; do
case $opt in
c) config_file=$OPTARG
;;
d) database=$OPTARG
;;
i) vcf_dir=$OPTARG
;;
o) output_dir=$OPTARG
;;
\?) echo "Invalid option: -$OPTARG" >&2
 exit 1
;;
:)
echo "Option -$OPTARG requires an argument." >&2
 exit 1
;;
esac

done
if [ -z "$config_file" ]; then
echo "Error: Option -c requires an argument."
exit 1
 fi
 
if [ -z "$database" ]; then
echo "Error: Option -d requires an argument."
exit 1
 fi

if [ -z "$vcf_dir" ]; then
echo "Error: Option -i requires an argument."
exit 1
 fi

if [ -z "$output_dir" ]; then
echo "Error: Option -o requires an argument."
exit 1
fi

shift $((OPTIND -1))

# Loop through VCF files
for vcf_file in "$vcf_dir"*_final_variants.vcf; do
 # Extract file name without extension
file_name=$(basename "$vcf_file" _final_variants.vcf)
 # Run snpEff annotation command
snpEff ann -no-downstream -no-upstream -c $config_file -s $output_dir${file_name}_summary.html -csvStats $output_dir${file_name}_annotated.csv $database $vcf_file > $output_dir${file_name}_final_variants_annotated.vcf
 echo "snpEff ann -no-downstream -no-upstream -c $config_file $database $vcf_file > $output_dir${file_name}_final_variants_annotated.vcf -s $output_dir${file_name}_summary.html -csvStats $output_dir${file_name}_annotated.csv"
done
