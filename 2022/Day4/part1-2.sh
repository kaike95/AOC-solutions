#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile="$1"; shift

# i learned how to use IFS

while IFS="-," read -ra input; do
  
  if [[ ${input[0]} -le ${input[2]} && ${input[1]} -ge ${input[3]} ]] \
  || [[ ${input[0]} -ge ${input[2]} && ${input[1]} -le ${input[3]} ]]; then

    ((counter++))
  
  fi
 
  if [[ ${input[0]} -le ${input[2]} && ${input[1]} -ge ${input[3]} ]] \
  || [[ ${input[0]} -ge ${input[2]} && ${input[1]} -le ${input[3]} ]] \
  || [[ ${input[0]} -le ${input[3]} && ${input[1]} -ge ${input[2]} ]]; then
    ((overlap++))
  fi

done < "$inputfile"

echo "The amount of assignment pairs where one range fully contains the other is: $counter"
echo "The amount of assignment pairs where the ranges overlap is: $overlap"
