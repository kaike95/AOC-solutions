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
			X) draw 1 ;;
			Y) win 2  ;;
			Z) lose 3 ;;
		esac ;;

		B)
		case $player in
			X) lose 1 ;;
			Y) draw 2 ;;
			Z) win 3  ;;
		esac ;;

		C)
		case $player in
			X) win 1  ;;
			Y) lose 2 ;;
			Z) draw 3 ;;
		esac ;;
	esac
done < "$inputfile"

echo "The RPS tournament final score is: ${score}"

[[ ! -f ./part2.sh ]] && exit
read -rp "Do you want to run part2? (ANY/n): " question 
case $question in 
  [nN]) exit ;;
  *   ) ./part2.sh "$1" ;;
esac
