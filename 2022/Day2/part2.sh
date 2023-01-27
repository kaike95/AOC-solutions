#!/bin/bash

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }

inputfile="$1"
score=0
x=0

win() {
	score=$(( score + 6 + $1 ))
	x=$((x+1))
}

draw() {
	score=$(( score + 3 + $1 ))
	x=$((x+1))
}

lose() {
	score=$(( score + $1 ))
	x=$((x+1))
}

while read -r input; do
	enemy=${input::1}
	player=${input:2}
	case $enemy in
		A)
		case $player in
			X) lose 3 ;;
			Y) draw 1  ;;
			Z) win 2 ;;
		esac ;;

		B)
		case $player in
			X) lose 1 ;;
			Y) draw 2 ;;
			Z) win 3  ;;
		esac ;;

		C)
		case $player in
			X) lose 2  ;;
			Y) draw 3 ;;
			Z) win 1 ;;
		esac ;;
	
	esac
done < "$inputfile"

echo "The actual RPS tournament final score is: ${score}"
