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

  loop=0 
  until [[ $loop -eq ${input[0]} ]]; do 
    
    typeset -n colfrom=a${input[1]}
    typeset -n colto=a${input[2]}
    
    colto=( "${colfrom}" "${colto[@]}" )
    
    # array expansion to move second index to first
    colfrom=( "${colfrom[@]:1}" )
    
    ((loop++))
  done
done <<< "$( tr -d 'aA-zZ' <<< "$(tail -n +11 "$inputfile")" )"

# get first element of each column
echo -n "The part 1 crate sequence is: "
for x in {1..9}; do 
  typeset -n col=a$x
  echo -n "${col[0]}" | tr -d '[]'
done
echo
[[ ! -f ./part2.sh ]] && exit
read -rp "Do you want to run part2? (ANY/n): " question 
case $question in 
  [nN]) exit ;;
  *   ) ./part2.sh "$1" ;;
esac
