#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: check-recipe-files-exist.sh <recipe_directory>"
	echo "Incorrect number of arguments."
	exit 1;
fi

recipe_dir=$1
expected_files=(meta.yaml build.sh)
num_expected_files=${#expected_files[@]}
found=0

# Check whether expected recipe files are present
for fname in "${expected_files[@]}"
do
	fpath=$recipe_dir"/"$fname
        if [ ! -f "$fpath" ]
	then
               	echo "Recipe file not found: "$fpath
	else
       		(( found++ ))
        fi
done

# Check number of files found matches expected number of files
if [ $found -ne $num_expected_files ]
then
	echo "Number of expected recipe files ("$num_expected_files") does not match number found ("$found")"
	exit 1;
fi
