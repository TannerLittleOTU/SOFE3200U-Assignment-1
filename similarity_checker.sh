#!/bin/bash

# Check for parameters and exit if not present
if [[ $# < 2 ]]; then
  echo "Usage: $0 <first file> <second file>";
  exit 0;
fi

# Load the first file path
file1=${1-data1}

# Remove the first parameter
shift

# Load the second file path
file2=${1-data2}

# Set file descriptors
exec 3<"$file1"
exec 4<"$file2"

# Initialize counters
eof1=0
eof2=0

count1=0
count2=0

differences=0

# Loop through each line of the files until end-of-file flag is set
while [[ $eof1 -eq 0 || $eof2 -eq 0 ]]
do
  # If the first file is not at end-of-file increment counter, otherwise set end-of-file flag
  if read a <&3; then
    let count1++
  else
    eof1=1
  fi

  # If the second file is not at end-of-file increment counter, otherwise set end-of-file flag
  if read b <&4; then
    let count2++
  else
    eof2=1
  fi

  # If the contents at the line do not match
  if [ "$a" != "$b" ]
  then
    # Print the different lines
    echo "\nDifference found at lines $count1, $count2:"
    echo "$file1: $a"
    echo "$file2: $b"

    # Increment the differences counter for the similarity percent
    let differences++
  fi
done

# Print the similarity percent
size=$(( count1 > count2 ? count1 : count2 ))
echo "\nFiles $file1 and $file2 are $(( ((size - differences) * 100) / size ))% similar.";

exit 0