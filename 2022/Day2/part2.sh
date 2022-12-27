#!/bin/bash

#A/X rock=1
#B/Y paper=2
#C/Z scissors=3

[[ -z $1 ]] && { echo "you need to specify the challenge input: ${0} input.txt"; exit; }
[[ ! -s $1 ]] && { echo "challenge input file is empty or does not exist"; exit; }

inputfile="$1";

score=0
x=0

win() {
	score=$(( score + 6 + $1 ))
	x=$((x+1))
	echo -ne "$x : Win"\\r
}

draw() {
	score=$(( score + 3 + $1 ))
	x=$((x+1))
	echo -ne "$x : Draw"\\r
}

lose() {
	score=$(( score + $1 ))
	x=$((x+1))
	echo -ne "$x : Lose"\\r
}

while read -r input; do
	enemy=$(cut -d " " -f1 <<< "$input")
	player=$(cut -d " " -f2 <<< "$input")
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
