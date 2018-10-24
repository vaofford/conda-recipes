#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: build-packages.sh <recipes_directory>"
	echo "Incorrect number of arguments."
        exit 1;
fi

top_level_dir=`pwd`

function validate_recipe () {
	package_to_validate=$1
	check_recipe_cmd="check-recipe-files-exist.sh "$package_to_build
	result=`$check_recipe_cmd`

	if [ ! -z "$result" ]
	then
		echo "$result"
		exit 1;
	fi
}

function build_package () {
	package_to_build=$1

	valid_recipe=`validate_recipe $package_to_build`

	if [ -z "$valid_recipe" ]
	then
		echo "Building package: "$package_to_build
		build_cmd="conda build --no-anaconda-upload --output-folder $CONDA_BUILD "$package_to_build
		#result=`$build_cmd`
		# Build package
		#conda build --no-anaconda-upload --output-folder $CONDA_BUILD $package_to_build 
	else
		echo "Could not validate recipe for "$package_to_build
		echo "$valid_recipe"
		exit 1;
	fi
}

for package in recipes/*/
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
			build_package $version_dir
			cd $package_dir
		done
	else
		build_package $package_dir
	fi

	cd $top_level_directory
done

exit 0;
