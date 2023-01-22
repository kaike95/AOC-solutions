#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile="$1"

# set variables I can use as alias
declare -a a1 a2 a3 a4 a5 a6 a7 a8 a9

# get formatted input for arrays (columns)
initial=$(head "$inputfile" | fold -w4)

# read input and assign to one of the nine columns
while read -r start; do  
  ((x++)) 

  # \/ nameref, equivalent to declare -n https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html
  # cheap way to use dynamic array names, probably not recommended 
  typeset -n col=a$x
  [[ $x -eq 9 ]] && x=0
  [[ $start =~ [0-9] || -z $start ]] && continue
  col+=("$start")
done <<< "$initial"

while read -ra input; do
  
  [[ -z "${input[*]}" ]] && continue

  # input[0] loop amount
  # input[1] column from
  # input[2] column to

  typeset -n colfrom=a${input[1]}
  typeset -n colto=a${input[2]}
  
  # compensate for array numbers starting at 0 by removing 1 from loop
  for (( loop = $((input[0] - 1)); loop >= 0; loop-- )); do
    
    # add to target column the loop index of the origin column 
    colto=( "${colfrom[$loop]}" "${colto[@]}" )

  done

  #remove all elements that were transferred above
  colfrom=( "${colfrom[@]:${input[0]}}" )  

# get from start of instructions, remove letters to make it an array of numbers to parse
# if having errors, check when your instruction starts and change +11 to that line number
done <<< "$( tr -d 'aA-zZ' <<< "$(tail -n +11 "$inputfile")" )"

# get first element of each column
echo -n "The part 2 crate sequence is: "
for x in {1..9}; do 
  typeset -n col=a$x
  echo -n "${col[0]}" | tr -d '[]'
done
echo
