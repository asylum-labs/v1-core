#!/bin/bash

# this script extracts ABIs from the v1-core contracts and copies them to the xeon-dapp/abi directory

SRC_DIR="src/" # v1-core directory
ABI_DIR="abi/" # xeon-dapp directory

# ensure ABI directory exists
mkdir -p $ABI_DIR

# array to hold contract names
CONTRACTS=()

# iterate over all .sol files in src/
for file in $SRC_DIR*.sol; do
  # extract the filename without the path and extension
  contract_name=$(basename "$file" .sol)
  # add contract name to CONTRACTS array
  CONTRACTS+=("$contract_name")
done

# print the CONTRACTS array (for debugging)
echo "Contracts found: ${CONTRACTS[@]}"

# extract ABIs and save them to the ABI directory
for contract in "${CONTRACTS[@]}"; do
  echo "Extracting ABI for $contract"
  forge inspect "$contract" abi > "$ABI_DIR/$contract.abi.json"
done

# now copy the ABIs to the xeon-dapp/abi directory
DAPP_ABI_DIR="../xeon-dapp/abi/"

# ensure the xeon-dapp ABI directory exists
mkdir -p $DAPP_ABI_DIR

# copy ABIs
cp $ABI_DIR*.abi.json $DAPP_ABI_DIR

echo "ABIs copied to xeon-dapp/abi"
