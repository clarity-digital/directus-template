#!/bin/bash

snapshotFolder="snapshots"

# Initialize variables for the latest timestamp and file
latestTimestamp=0
latestFile=""

# Loop through files in the snapshot folder
for file in "$snapshotFolder"/*.yaml; do
  # Extract the timestamp from the filename
  if [[ $file =~ ([0-9]{4}-[0-9]{2}-[0-9]{2})-.*-([0-9]+)\.yaml ]]; then
    timestamp="${BASH_REMATCH[2]}"

    # Compare the current file's timestamp with the latest timestamp found
    if (( timestamp > latestTimestamp )); then
      latestTimestamp="$timestamp"
      latestFile="$file"
    fi
  fi
done

# Output the path to the latest snapshot file
if [ -n "$latestFile" ]; then
  echo "Applying snapshot: $latestFile"
  docker exec directus npx directus schema apply ./$latestFile --yes
else
  echo "No snapshot files found."
fi