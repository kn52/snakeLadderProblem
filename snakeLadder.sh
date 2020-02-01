#!/bin/bash -x 
declare -A playerPosition
readonly START=0
currentPosition=$START
value=0
roll=0
echo "Welcome to Snake And Ladder Game"
rollDice()
{
	value=$(( 1 + $((RANDOM%6)) ))
	((roll++))	
	echo "Dice Output: $value"
}
playerOptions()
{
	local option=$(( $((RANDOM%3)) + 1 ))
	echo "Option: $option"
	case $option in
		1)
			playerPosition[$roll]=$currentPosition
			;;
		2)
			currentPosition=$(( $currentPosition + $value ))
			playerPosition[$roll]=$currentPosition
			;;
		3)	
			currentPosition=$(( $currentPosition - $value))
			playerPosition[$roll]=$currentPosition
			if (( $currentPosition < 0 ))
			then
				currentPosition=$START
				playerPosition[$roll]=$currentPosition
			fi
			;;
		*)
			echo "Option: $(( $((RANDOM%3)) + 1 ))"
			echo "Option not available"
			;;
	esac
	
}
winningGame()
{
	
	
	until [[ $currentPosition -gt 100 ]]
	do
		currentPosition=${playerPosition[$roll]}
		rollDice		
		if (( $(($currentPosition + $value)) == 100 ))
		then
			currentPosition=100
			playerPosition[$roll]=$currentPosition
			echo "You Won..."
			echo "Current Position of player: ${playerPosition[$roll]}"
			echo "Total Rolls: $roll"
			break
		elif (( $(( $currentPosition + $value )) > 100 ))
		then
			playerPosition[$roll]=${playerPosition[$roll]}
		else
			playerOptions
		fi
		echo "Current Position of player: ${playerPosition[$roll]}"
		echo "---------------------"
	done
}

	winningGame
