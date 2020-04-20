#!/usr/bin/env bash

# Description:
#   This script automatically links all the files and directories that Cholla
#   needs.  This includes the Makefile and IDE directories only at the moment.
#   Those files all are tracked and reside in this repo but need to be 
#   accessible in the Cholla directory.
#
# Dependencies:
#   Requires that the Cholla repo is right next to the cholla-Makefile repo
#
# Args:
#   $1 - The system being used so that the correct Makefile can be linked

#set -x #echo all commands

# Find the paths
REPO_ROOT=$(git rev-parse --show-toplevel)
CHOLLA_ROOT="${REPO_ROOT::-9}"

LN="$(which ln)"
LN_Flags=(
    -s
    --force
)

if [ "${1,,}" == "h2p" ]; then
    Makefile_Target="h2p-Makefile"
# elif [ "${1,,}" == "ANOTHER SYSTEM" ]; then
else
    printf "Error: No system specified, please choose a system"
    exit 1
fi


# Set up arrays for the objects to link
Files_to_link=(
    "${Makefile_Target}"
    vscode
    idea
)

Link_Names=(
    Makefile
    .vscode
    .idea
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
