#!/bin/bash -x

echo "!!! WELCOME  TO  TIC-TAC-TOE GAME ... !!!"

count=0
player=" "
symbol1="O"
symbol2="O"

declare -a board
board=( 1 2 3 4 5 6 7 8 9 )

function getSymbol(){
	if [[ $((RANDOM%2)) -eq 0 ]]
	then
		echo "Player 1 Will Play First"
		echo "Player 1  Symbol is = X"
		player="user"
	else
		echo "Computer Will Play First"
		echo "Computer Symbol is = X"
		player="computer"
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

function checkForSides(){
   temp=0
   for (( i=0;i<9;i++ ))
	do
     if [[ ${board[$i]} != "X" && ${board[$i]} != "O" ]]
     then
        if [[ $((${board[$i]}%2)) -eq 0 ]]
        then
           temp=1
           echo ${board[$i]}
           break
        fi
     fi
	done
}

function checkForCorner(){
	temp=0
	for (( i=0;i<9;i++ ))
	do
		if [[ $i -ne 4 && ${board[$i]} != "X" && ${board[$i]} != "O" ]]
		then
			if [[ $((${board[$i]}%2)) -eq 1 ]]
			then
				temp=1
				echo ${board[$i]}
				break
			fi
		fi
	done
	if [[ $temp -eq 0 ]]
	then
		value=$(checkForSides)
		echo $value
	fi
}

function checkOpponentDiagonal(){
      #blockCondition for diagonal
   temp=0
   i=0
   if [[ ${board[$i]} == ${board[$(($i+4))]} &&  ${board[$(($i+8))]} != $symbol1 &&  ${board[$(($i+8))]} != $symbol ]]
	then
   	temp=1
      cellValue=${board[$(($i+8))]}
	elif [[ ${board[$(($i+4))]} == ${board[$(($i+8))]} && ${board[$i]} != $symbol1 &&  ${board[$i]} != $symbol2 ]]
   then
   	temp=1
      cellValue=${board[$i]}
   elif [[ ${board[$i]} == ${board[$(($i+8))]} && ${board[$(($i+4))]} != $symbol1 && ${board[$(($i+4))]} != $symbol2 ]]
   then
   	temp=1
      cellValue=${board[$(($i+4))]}
   elif [[ ${board[$i+2]} == ${board[$(($i+4))]} && ${board[$(($i+6))]} != $symbol1 && ${board[$(($i+6))]} != $symbol2 ]]
   then  
   	temp=1
      cellValue=${board[$(($i+6))]}
   elif [[ ${board[$i+4]} == ${board[$(($i+6))]} && ${board[$(($i+2))]} != $symbol1 && ${board[$(($i+2))]} != $symbol2 ]]
   then  
   	temp=1
      cellValue=${board[$(($i+2))]}
	elif [[ ${board[$i+2]} == ${board[$(($i+6))]} && ${board[$(($i+4))]} != $symbol1 && ${board[$(($i+4))]} != $symbol2 ]]
   then  
   	temp=1
      cellValue=${board[$(($i+4))]}
     fi
   
   if [ $temp -eq 0 ]
   then
      cornerValue=$(checkForCorner)
      echo $cornerValue
	else
      echo $cellValue
   fi

}

function checkOpponentColumn(){ 
      #blockCondition for column
   temp=0
   for(( i=0;i<=2;i++ ))
   do
      if [[ ${board[$i]} == ${board[$(($i+3))]} && ${board[$(($i+6))]} != $symbol1 && ${board[$(($i+6))]} != $symbol2 ]]
      then
         temp=1
         cellValue=${board[$(($i+6))]}
         break
      elif [[ ${board[(($i+3))]} == ${board[(($i+6))]} && ${board[$i]} != $symbol1 && ${board[$i]} != $symbol2 ]]
      then
         temp=1
         cellValue=${board[$i]}
         break
      elif [[ ${board[$i]} == ${board[(($i+6))]} && ${board[(($i+3))]} != $symbol1 && ${board[(($i+3))]} != $symbol2 ]]
      then
         temp=1
         cellValue=${board[(($i+3))]}
         break
      fi
	done
   if [ $temp -eq 0 ]
   then
      Value=$(checkOpponentDiagonal)
      echo $Value
   else
      echo $cellValue
   fi
}

function checkOpponentRow(){
	temp=0
	cellValue=0
	for((i=0;i<=8;i=$(($i+3)) ))
  	do
	#blockcondition For row
		if [[ ${board[$i]} == ${board[$(($i+1))]} && ${board[(($i+2))]} != $symbol2 && ${board[(($i+2))]} != $symbol1 ]]
		then
			temp=1
			cellValue=${board[(($i+2))]}
			break
		elif [[ ${board[(($i+1))]} == ${board[(($i+2))]} && ${board[$i]} != $symbol1 && ${board[$i]} != $symbol2 ]]
		then
			temp=1
			cellValue=${board[$i]}
			break
		elif [[ ${board[$i]} == ${board[(($i+2))]} && ${board[(($i+1))]} -ne $symbol1 && ${board[(($i+1))]} -ne $symbol2 ]]
		then
			temp=1
			cellValue=${board[(($i+1))]}
			break
	fi
	done
	if [ $temp -eq 0 ]
   then
      Value=$(checkOpponentColumn)
      echo $Value
	else
      echo $cellValue
   fi

}


function getUserInput(){
	echo "User"
	read -p "Enter Cell Number  " cellNum 
	for (( i=0;i<=8;i++ ))
   do
      if [[ ${board[$i]} -eq $cellNum ]]
      then
         board[$(($cellNum-1))]=$symbol1
         count=$(($count+1))
      fi
   done
	player="computer"
}

function getComputerInput(){
	echo "Computer"
	cellNum=$(checkOpponentRow)
   for (( i=0;i<=8;i++ ))
   do
      if [[ ${board[$i]} -eq $cellNum ]]
     	then
			board[(($cellNum-1))]=$symbol2
      	count=$(($count+1))
			player="user"
			break
      fi
	player="computer"
   done
}

function checkForRow(){
	flag1=0
	for((i=0;i<=8;i=$(($i+3)) ))
   do
      if [[ ${board[$i]} == "X"  && ${board[$(($i+1))]} == "X"  && ${board[$(($i+2))]} == "X" ]]
      then
        	flag1=1
         break
		elif [[ ${board[$i]} == "O"  && ${board[$(($i+1))]} == "O"  && ${board[$(($i+2))]} == "O" ]]
      then
        	flag1=2
         break
		fi
	done
	echo $flag1
}

function checkForColumn(){
	flag2=0
	for(( i=0;i<=2;i++ ))
   do
		if [[ ${board[$i]} == "X"  && ${board[$(($i+3))]} == "X"  && ${board[$(($i+6))]} == "X" ]]
      		then
			flag2=1
			break
	   	elif [[ ${board[$i]} == "O"  && ${board[$(($i+3))]} == "O"  && ${board[$(($i+6))]} == "O" ]]
      		then
         		flag2=2
         		break
		fi
   	done
   	echo $flag2
}

function checkForDiagonal(){
	flag3=0
	i=0
	if [[ ${board[$i]} == "X"  && ${board[$(($i+4))]} == "X"  && ${board[$(($i+8))]} == "X" ]]
   	then
		flag3=1
	elif [[  ${board[$i+2]} == "X"  && ${board[$(($i+4))]} == "X"  && ${board[$(($i+6))]} == "X" ]]
   	then	
		flag3=1
	elif [[ ${board[$i]} == "O"  && ${board[$(($i+4))]} == "O"  && ${board[$(($i+8))]} == "O" ]]
   	then
      		flag3=2
   	elif [[  ${board[$i+2]} == "O"  && ${board[$(($i+4))]} == "O"  && ${board[$(($i+6))]} == "O" ]]
   	then  
      		flag3=2
	fi

	echo $flag3
}

function checkForWin(){
	win=0
   	rowValue=$(checkForRow)
   	columnValue=$(checkForColumn)
   	diagonalValue=$(checkForDiagonal)
   	if [[ $rowValue -eq 1 || $columnValue -eq 1 || $diagonalValue -eq 1 ]]
   	then
		win=1
   	elif [[ $rowValue -eq 2 || $columnValue -eq 2 || $diagonalValue -eq 2 ]]
   	then
		win=2
   	fi
	echo $win
}

function getInput(){
	check=0
	while [[ $count -ne 9 ]]
	do
		if [[ $player == "user" ]]
      		then
			if [[ $count -eq 0 ]]
			then
				symbol1="X"
			fi
			getUserInput
      		else
			if [[ $count -eq 0 ]]
			then
				symbol2="X"
			fi
			getComputerInput
      		fi
		getBoardPrint
		check=$(checkForWin)
		if [ $check -eq 1 ]
		then
			echo "X Symbol User Win!!!"
			break
		elif [ $check -eq 2 ]
		then
			echo "O Symbol User Win!!!"
			break
		fi
	done
}
getInput
function checkTieCondition(){
	if [[ $count -ge 9 ]]
	then
		echo "Game Draw"
	fi
}
checkTieCondition
