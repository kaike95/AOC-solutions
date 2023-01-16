#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile="$1"

part1total=0
part2total=0

values=(0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

while read -r input; do
  
  # part 1 

  # get string length and then get middle
  middle=$(( ${#input} / 2 ))

  # sort and remove duplicates
  first=$(fold -w1 <<< "${input::$middle}" | sort | tr -ds '\n' 'aA-zZ') # param expansion: remove everything after $middle
  last=$(fold -w1 <<< "${input:$middle}" | sort | tr -ds '\n' 'aA-zZ') # param expansion: remove everything before $middle

  # remove any letter that doesn't exist in compared strings
  part1commonletter=$(tr -dc "$last" <<< "$first")

  # replace common letter in array with delimiter, cut anything after and return the length
  part1importance=$(cut -d/ -f1 <<< "${values[@]/$part1commonletter//}" | wc -w)
  # explanation https://superuser.com/a/778840

  part1total=$((part1importance + part1total))

  # part 2

  ((loop++))
  
  # sort, remove duplicates and add to group array
  
  badge+=("$(fold -w1 <<< "$input" | sort | tr -ds '\n' 'aA-zZ')")
  
  if [[ $((loop % 3)) -eq 0 ]]; then
    
    # remove any letter that doesn't exist in the compared strings
    
    part2commonletter=$(tr -dc "${badge[2]}" <<< "${badge[1]}")
    part2commonletter=$(tr -dc "$part2commonletter" <<< "${badge[0]}")
    
    # replace common letter in array with delimiter, cut anything after and return the length
    
    part2importance=$(cut -d/ -f1 <<< "${values[@]/$part2commonletter//}" | wc -w)
    # explanation https://superuser.com/a/778840
    
    part2total=$((part2importance + part2total))
  
    badge=()
  
  fi

done < "$inputfile"

echo "The sum of the priorities in part 1 is: $part1total"
echo "The sum of the priorities in part 2 is: $part2total"
