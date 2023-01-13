#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }
inputfile="$1"

total=0

values=(0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

while read -r input; do
  
  # get string length and then get middle
  
  middle=$(( ${#input} / 2 ))

  # param expansion: remove everything after $middle
  
  part1=${input::$middle}
  
  # param expansion: remove everything before $middle
  
  part2=${input:$middle}  

  # sort and remove duplicates

  part1=$(fold -w1 <<< "$part1" | sort | tr -ds '\n' 'aA-zZ')
  part2=$(fold -w1 <<< "$part2" | sort | tr -ds '\n' 'aA-zZ')

  # remove any letter that doesn't exist in both strings

  commonletter=$(tr -dc "$part2" <<< "$part1")

  # replace common letter in array with delimiter, cut anything after and return the length

  importance=$(cut -d/ -f1 <<< "${values[@]/$commonletter//}" | wc -w)
  # explanation https://superuser.com/a/778840

  total=$((importance + total))

done < "$inputfile"

echo $total
