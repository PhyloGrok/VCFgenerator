#!/bin/bash

# 1. Automatically detect the directory where this script is located
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo " VCFgenerator Container Launcher                          "
echo "=========================================================="
echo ""

# 2. Interactive user prompt loop for the storage path
while true; do
	read -rp "Enter the absolute path to your mounted storage volume: " HOST_STORAGE_PATH

	# Expand tilde (~) if the user types a home directory shortcut
    	HOST_STORAGE_PATH="${HOST_STORAGE_PATH/#\~/$HOME}"

    	# Check if the directory actually exists on the host VM
    	if [ -d "$HOST_STORAGE_PATH" ]; then
		break
	else
		echo "ERROR: Path '$HOST_STORAGE_PATH' does not exist."
		echo "Please verify the mount point and try again."
		echo ""
    	fi
done

echo ""
echo "=========================================================="
echo "Launching Containerized Pipeline..."
echo "Code Location: $REPO_DIR"
echo "Data Storage: $HOST_STORAGE_PATH"
echo "=========================================================="
echo ""


# NEW: Prompt for TaxID on the host side
read -rp "Enter your Taxonomy ID (TaxID): " HOST_TXID

# 3. Launch the container with dual volume mounts and the runtime environment variable
docker run --rm \
	--user "$(id -u):$(id -g)" \
	-v "$REPO_DIR":/app \
	-v "$HOST_STORAGE_PATH":/app/data \
	-e DATA_DIR="/app/data" \
	-e TAXID="$HOST_TXID" \
	vcfgenerator:latest \
  bash /app/VCF.sh
