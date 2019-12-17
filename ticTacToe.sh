#!/bin/bash -x

echo "!!! WELCOME  TO  TIC-TAC-TOE GAME ... !!!"

count=0
flag1=0
flag2=0
flag3=0

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
	read -p "Enter Cell Number  " cellNum 
	for (( i=0;i<=8;i++ ))
	do
		if [[ ${board[$i]} -eq $cellNum ]]
		then
			board[$(($cellNum-1))]="X"
			count=$(($count+1))
			break
		fi
	done
}

function checkForRow(){
	for((i=0;i<=8;i=$(($i+3)) ))
   do
      if [[ ${board[$i]} == "X"  && ${board[$(($i+1))]} == "X"  && ${board[$(($i+2))]} == "X" ]]
      then
         flag1=1
         break
		fi
	done
	echo $flag1
}

function checkForColumn(){
	for(( i=0;i<=2;i++ ))
   do
		if [[ ${board[$i]} == "X"  && ${board[$(($i+3))]} == "X"  && ${board[$(($i+6))]} == "X" ]]
      then
			flag2=1
			break
		fi
   done
   echo $flag2
}

function checkForDiagonal(){
	i=0
	if [[ ${board[$i]} == "X"  && ${board[$(($i+4))]} == "X"  && ${board[$(($i+8))]} == "X" ]]
   then
		flag3=1
	elif [[  ${board[$i+2]} == "X"  && ${board[$(($i+4))]} == "X"  && ${board[$(($i+6))]} == "X" ]]
   then	
			flag3=1
	fi
	echo $flag3
}

while [[ $count -ne 9 ]]
do
	getCellNum
	getBoardPrint
	rowValue=$(checkForRow)
	columnValue=$(checkForColumn)
	diagonalValue=$(checkForDiagonal)
	if [[ $rowValue -eq 1 || $columnValue -eq 1 || $diagonalValue -eq 1 ]]
	then
		echo "X Symbol User Win!!!"
		break
	fi
done

