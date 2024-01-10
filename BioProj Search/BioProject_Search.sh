#!/bin/bash
#Critic-ism

#first search for bioprojects

echo "File name for BioProject search results:"
read biosearch_output

#create directory for run 
echo "Creating main directory..."
main_dir="$biosearch_output"
mkdir -p "${biosearch_output}"

#directory creation for SRA search results
echo "Creating SRA directory..."
output_dir="$main_dir/${biosearch_output}_SRA_lists"
mkdir -p "$output_dir"
echo "Output directory created: $output_dir"

esearch -db bioproject -query "(\"Staphylococcus aureus\"[Organism]) AND (\"genome sequencing\"[Filter] AND \"bioproject sra\"[Filter] AND \"scope monoisolate\"[Filter])" | efetch -format docsum > $main_dir/${biosearch_output}.txt

#parse the text and grab only the project accession ids
proj_acc="<Project_Acc>"
grep "$proj_acc" "$main_dir/${biosearch_output}.txt" > "$main_dir/${biosearch_output}_projacc.txt"
#sed is nt clearing the whitespace for some reason
#sed -n 's/<Project_Acc>[[:space:]]*\(.*\)[[:space:]]*<\/Project_Acc>/\1/p' "$main_dir/${biosearch_output}_projacc.txt" > "$main_dir/${biosearch_output}_projacc_cleaned.txt"
awk -F'</?Project_Acc>' '{ for (i=2; i<=NF; i+=2) print $i }' "$main_dir/${biosearch_output}_projacc.txt" | awk '{$1=$1};1' > "$main_dir/${biosearch_output}_projacc_cleaned.txt"
input_file="$main_dir/${biosearch_output}_projacc_cleaned.txt"
echo "Initial BioProject search file: $input_file"

#begin for loop to check each BioProject for the desired SRA files
for bioproject_id in $(cat "$input_file"); do
    echo "Checking BioProject: $bioproject_id"

    sra_check=$(esearch -db sra -query "$bioproject_id AND (public[Access] AND type genome[Filter] AND strategy whole genome sequencing[Filter] AND library layout paired[Filter] AND illumina[Platform])" | efetch -format docsum | xtract -pattern Runs -ACC @acc -element "&ACC")

    #checks for SRA files that meet criteria for each bioproject
    if [ -n "$sra_check" ]; then
        echo "$bioproject_id contains SRA files that meet criteria:"
        echo "$sra_check"

        #creates a directory in the output directory for each bioproject; SRA info and fil>
        bioproj_dir="$output_dir/$bioproject_id"
        mkdir -p "$bioproj_dir"

        # Save the files to the subdirectory (named after the BioProject ID)
        echo "$sra_check" > "$bioproj_dir/${bioproject_id}_SRA.txt"

        # Download the SRA files using prefetch
        prefetch --option-file "$bioproj_dir/${bioproject_id}_SRA.txt" --output-directory "$bioproj_dir"
    else
        echo "$bioproject_ID does not contain SRA files that meet criteria."
    fi

done < "$input_file"
