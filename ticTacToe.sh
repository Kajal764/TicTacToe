#!/bin/bash -x

echo "!!! WELCOME  TO  TIC-TAC-TOE GAME ... !!!"

count=0

declare -a board
board=( 1 2 3 4 5 6 7 8 9 )
function getSymbol(){
	if [[ $((RANDOM%2)) -eq 0 ]]
	then
		echo "Player 1 Will Play First"
		echo "Player 1  Symbol is = X"
	else
		echo "Player 2 Will Play First"
		echo "Player 2 Symbol is = X"
	fi
}
getSymbol

function getBoardPrint(){
	echo "  ____ ____ ____ "
	echo " |_${board[0]}__""|""_${board[1]}__""|""_${board[2]}__""|"
	echo " |_${board[3]}__""|""_${board[4]}__""|""_${board[5]}__""|"
	echo " |_${board[6]}__""|""_${board[7]}__""|""_${board[8]}__""|"

	
}
getBoardPrint
function getCellNum(){
	read -p "Enter Cell Num  " cellNum 
	for (( i=0;i<=8;i++ ))
	do
		if [[ ${board[$i]}  == $cellNum ]]
		then
			board[$(($cellNum-1))]="X"
			count=$(($count+1))
			break
		fi
		
	done
}

while [[ $count -ne 9 ]]
do
	getCellNum
	getBoardPrint
done

