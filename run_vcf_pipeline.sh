#!/bin/bash
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

# Prompt for paths and credentials
while true; do
	read -rp "Enter absolute path to your storage volume: " HOST_STORAGE_PATH
    	HOST_STORAGE_PATH="${HOST_STORAGE_PATH/#\~/$HOME}"
	[ -d "$HOST_STORAGE_PATH" ] && break
	echo "ERROR: Path '$HOST_STORAGE_PATH' does not exist."
done

read -rp "Enter Taxonomy ID (TaxID): " HOST_TXID
read -rp "Enter your contact email: " HOST_EMAIL
read -rp "Enter your NCBI API Key (Enter to skip): " HOST_API_KEY

echo "=========================================================="
echo "Executing End-to-End Nextflow VCF Pipeline..."
echo "=========================================================="

# Run Nextflow, mounting your large storage disk array directly
nextflow run main.nf \
	--taxid "$HOST_TXID" \
	--email "$HOST_EMAIL" \
	--api_key "$HOST_API_KEY" \
	--data_dir "$HOST_STORAGE_PATH" \
	-with-docker vcfgenerator:latest
