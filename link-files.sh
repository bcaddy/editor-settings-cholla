#!/usr/bin/env bash

# Description:
#   This script automatically links all the files and directories that I need for my settings
#   needs.  This includes the IDE directories only at the moment.
#   Those files all are tracked and reside in this repo but need to be
#   accessible in the Cholla directory.
#
# Dependencies:
#   Requires that the Cholla repo is right next to this repo
#

set -x #echo all commands

# Find the paths
REPO_ROOT=$(git rev-parse --show-toplevel)
CHOLLA_ROOT="${REPO_ROOT::-22}"

LN="$(which ln)"
LN_Flags=(
    -s
    --force
)

# Set up arrays for the objects to link
Files_to_link=(
    vscode
)

Link_Names=(
    .vscode
)

# Check if the arrays are the same size
if [ ${#Files_to_link[@]} != ${#Link_Names[@]} ]; then
    printf "Error: The Files_to_link and Link_Names arrays are not the same size."
    exit 2
fi

# Iterate over the arrays and do the linking
for i in {0..2} ##"${#Link_Names[@]}"}
do
    "${LN}" "${LN_Flags[@]}" "${REPO_ROOT}/${Files_to_link[$i]}" "${CHOLLA_ROOT}/${Link_Names[$i]}"
done
