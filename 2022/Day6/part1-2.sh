#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile="$1"

echo "Running..."
# read input 1 letter at a time
while read -rn1 input; do 
  
  ((count++))
  packet+=("$input")
  packet2+=("$input")


  # only run if array has wanted marker size and done is not set
  if [[ ${#packet[@]} -eq 4 && $done1 -ne 1 ]]; then
    
    # remove duplicated values in array
    sorted=( $(printf "%s\n" "${packet[@]}" | sort -u ) ) 
    
    # check if sorted array is the same length as unsorted, save count and set done flag
    [[ ${#sorted[@]} -eq ${#packet[@]} ]] && { done1=1; count1=$count; }
    
    # delete first index (0) and reset sorted array
    packet=( "${packet[@]:1}" )
    sorted=() 
  
  fi

  if [[ ${#packet2[@]} -eq 14 && $done2 -ne 1 ]]; then

    sorted2=( $(printf "%s\n" "${packet2[@]}" | sort -u) ) 
    [[ ${#sorted2[@]} -eq ${#packet2[@]} ]] && { done2=1; count2=$count; }
    packet2=( "${packet2[@]:1}" )
    sorted2=()
  
  fi

# break while loop if both markers are found  
[[ $done1 -eq 1 && $done2 -eq 1 ]] && break

done < "$inputfile"

printf "%s characters need to be processed to find the start-of-packet marker\n%s characters need to be processed to find the start-of-message marker" "$count1" "$count2"
