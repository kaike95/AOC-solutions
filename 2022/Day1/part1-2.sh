#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }

#backup input
cp "$1" "copy-$1"

total=0
total_three=0

while [[ -s "copy-$1" ]]; do

	#reads line by line
	while read -r line; do
		[[ -z "$line" ]] && break || { 
			total=$(( total + line ))
			#removes read line
			sed -i "1d" "copy-$1"
			
			#this is so cool yet useless in this case, feel free to comment it
			echo -ne "please wait, reading numbers ... $line"\\r
		}
	done < "copy-$1"

	#remove blank space between number groups
	sed -i "1d" "copy-$1"
	
	echo "$total" >> total.log

	#reset total
	total=0
done

while read -r line; do
		total_three=$(( total_three + line ))
	done < <(sort -nr total.log | head -n3)

echo "Part 1: the highest number of calories is: $(sort -nr total.log | head -n1)"
echo "Part 2: the sum of the calories of the top three elves is: $total_three" 

rm "copy-$1" "total.log"
