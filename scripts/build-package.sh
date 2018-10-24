#!/bin/bash

if [ $# -ne 1]
then
  echo "Usage: build-package.sh <package_directory>"
  echo "Incorrect number of arguments."
        exit 1;
fi

package_directory=$1

echo "Checking package directory exists: "$package_directory
if [ ! -d $package_directory ]
then
      echo "Package directory doesn't exist: "$package_directory
      exit 1;  
fi

echo "Checking recipe files exist in package directory: "$package_directory
check_recipe_cmd="check-recipe-files-exist.sh "$package_directory
result=`$check_recipe_cmd`
if [ ! -z "$result" ]
then
      echo "$result"
      exit 1;
fi

echo "Building package: "$package_directory
conda build $package_directory
