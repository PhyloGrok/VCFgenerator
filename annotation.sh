#!/bin/bash


# ==============================================================================

# 1. PROJECT SETUP & DIRECTORY

# ==============================================================================

# Ask user for TaxID

read -p "Enter your TaxID: " txid

echo "Processing Annotation for TaxID: $txid"

# Define base project directories

BASE_DIR="$HOME/VCF.projects/$txid"

# BASE_DIR="~/VCF_Test/VCF.projectscopy/$txid"

RESULT_PATH="$BASE_DIR/results"

RESOURCE_PATH="$BASE_DIR/resources"


echo "Status: BASE_DIR is set to: $BASE_DIR"

# ==============================================================================

# 2. LOCATE REF GENOME FILES

# ==============================================================================

REFDIR="$BASE_DIR/data/ncbi_dataset/data" 


# SAFETY CHECK 1: Does the ncbi_dataset/data folder exist?

if [ ! -d "$REFDIR" ]; then

    echo "❌ Error: No ncbi_dataset directory found at $REFDIR"

    echo "Stopping script."

    return 1 2>/dev/null || exit 1

fi


# Find the specific GCF accession folder downloaded from NCBI

REFPATH=$(find "$REFDIR" -type d -name "GCF*" | head -n 1)


# SAFETY CHECK 2: Did we actually find a GCF folder?

if [ -z "$REFPATH" ]; then

    echo "❌ Error: No GCF reference folder found inside $REFDIR"

    echo "Stopping script."

    return 1 2>/dev/null || exit 1

fi


# SAFETY CHECK 3: Does the mandatory Ref Genome (GFF file) exist?

if [ ! -f "$REFPATH/genomic.gff" ]; then

    echo "❌ Error: Mandatory Ref Genome (GFF file) is missing in $REFPATH"

    echo "Stopping script."

    return 1 2>/dev/null || exit 1

fi


# If it passes all checks, define the REFNAME

REFNAME=$(basename "$REFPATH")

echo "✅ Ref Genome (GFF files) found: $REFNAME"


# Extract the organism name/info from the raw FASTA file for the config log

ENTRY_INFO=$(find "$REFPATH" -maxdepth 1 -name '*.fna' -exec sh -c "head -n 1 {} | sed 's/^[^ ]* //;s/,.*$//'" \;)


# Locate the original snpEff installation directory

FIRSTDIR=$(dirname $(dirname $(which snpEff)))

TMP=$(dirname $(readlink -s $(which snpEff)))

SNPEFFDIR="${FIRSTDIR}${TMP/../}"

# ==============================================================================

# 3. CONFIGURE SNPEFF

# ==============================================================================

# Create local SnpEff folder for this specific project

SNPEFF_PATH="$RESOURCE_PATH/SnpEff"

mkdir -p "$SNPEFF_PATH"


# Copy the master config file to our local project workspace

cp "$SNPEFFDIR/snpEff.config" "$SNPEFF_PATH/snpEff.config"


# Append our new reference genome to the bottom of the local config file

echo "" >> "$SNPEFF_PATH/snpEff.config"

echo "# $ENTRY_INFO, $REFNAME" >> "$SNPEFF_PATH/snpEff.config"

echo "$REFNAME.genome : $REFNAME" >> "$SNPEFF_PATH/snpEff.config"


# ==============================================================================

# 4. PREPARE DATABASE FILES

# ==============================================================================

# Create the specific data folder snpEff expects for this genome

mkdir -p "$SNPEFF_PATH/data/$REFNAME"


echo "Status: Copying reference files to SnpEff database folder..."


# Copy mandatory files (FASTA and GFF)

cp "$REFPATH"/GCF_*_genomic.fna "$SNPEFF_PATH/data/$REFNAME/sequences.fa"

cp "$REFPATH/genomic.gff" "$SNPEFF_PATH/data/$REFNAME/genes.gff"


# Copy optional files (Errors suppressed in case NCBI didn't provide them)

cp "$REFPATH/genomic.gtf" "$SNPEFF_PATH/data/$REFNAME/genes.gtf" 2>/dev/null || true

cp "$REFPATH/protein.faa" "$SNPEFF_PATH/data/$REFNAME/protein.fa" 2>/dev/null || true

cp "$REFPATH/cds_from_genomic.fna" "$SNPEFF_PATH/data/$REFNAME/cds.fa" 2>/dev/null || true


# ==============================================================================

# 5. BUILD THE DATABASE

# ==============================================================================

echo "Status: Building snpEff database for TaxID $txid $REFNAME..."


# Build dictionary (-noCheckCds & -noCheckProtein prevent crashes if optional files are missing)

snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 -c "$SNPEFF_PATH/snpEff.config" -v "$REFNAME"


# ==============================================================================

# 6. ANNOTATE VCF FILES

# ==============================================================================

echo "Status: Annotating final VCF files..."


# Loop through the final VCF file(s) and run them against the newly built database

for file in "$RESULT_PATH"/vcf/*_final_variants.vcf; do

    

    # Check if the file actually exists to prevent errors on empty directories

    if [ -e "$file" ]; then

        echo " -> Annotating: $(basename "$file")"

        snpEff -c "$SNPEFF_PATH/snpEff.config" "$REFNAME" "$file" > "${file%.vcf}_annotated.vcf"

    fi


done


echo "Status: Annotation complete!"
