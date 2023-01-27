#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile=$1

declare -a arrtotal
total=0
total_three=0

#reads line by line
while read -r line; do
	if [[ -n "$line" ]]; then
		total=$(( total + line ))
	else 
		arrtotal+=( "$total" )
		total=0
	fi
done < "$inputfile"

sorted=( $(printf "%s\n" "${arrtotal[@]}" | sort -nr) )

total_three=$(( sorted[0] + sorted[1] + sorted[2] ))

echo "Part 1: the highest number of calories is: ${sorted[0]}"
echo "Part 2: the sum of the calories of the top three elves is: $total_three"

