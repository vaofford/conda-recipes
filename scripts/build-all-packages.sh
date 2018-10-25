#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: build-packages.sh <recipes_directory>"
	echo "Incorrect number of arguments."
        exit 1;
fi

top_level_dir=`pwd`
recipes_directory=$1

for package in $recipes_directory/*/
do
	echo "Found package: "$package

	package_dir=$top_level_dir"/"$package
	cd $package_dir

	num_sub_dirs=`ls -l | grep -c ^d`
	echo "Versions found: "$num_sub_dirs

	if [ $num_sub_dirs -gt 0 ]
	then
		for version in */
		do
			echo "Found version: "$version" in "$package
			cd $version
			version_dir=`pwd`
			build-package.sh $version_dir
			
			if [[ $? -ne 0 ]]; then exit 1; fi
			
			cd $package_dir
		done
	else
		build-package.sh $package_dir
	fi

	cd $top_level_directory
done
