#!/bin/bash -x

echo "!!! WELCOME  TO  TIC-TAC-TOE GAME ... !!!"

declare -a board
function getInitializedBoard(){
	board=( 1 2 3 4 5 6 7 8 9 )

	echo " ${board[0]} ${board[1]} ${board[2]} "
	echo " ${board[3]} ${board[4]} ${board[5]} "
	echo " ${board[6]} ${board[7]} ${board[8]} "
}
getInitializedBoard

function getSymbol(){
	if [[ $((RANDOM%2)) -eq 0 ]]
	then
		echo "Player 1 Will Play First"
		echo "Player 1  Symbol is = X"
	else
		echo "Player 2 Will Play First"
		echo "Player 1 Symbol is = X"
	fi
}
getSymbol
