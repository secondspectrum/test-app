#!/bin/bash
set -euo pipefail

envs_file='envs.yml'
workspaces_file='workspaces.json'

rm -rf "$envs_file"
jsonnet pipelines.jsonnet | yq eval -P - > "$envs_file"

envs=$(jq -r '.workspaces[]' "$workspaces_file")

for e in ${envs[@]}; do
  yq eval ".$e" "$envs_file" | buildkite-agent pipeline upload
done

