#!/bin/bash
declare -A playerPosition
readonly START=0
currentPosition=$START
player=1
value=0
roll=0
echo "Welcome to Snake And Ladder Game"
rollDice()
{
	value=$(( 1 + $((RANDOM%6)) ))
	echo "Dice Output: $value"
}
player()
{
	playerPosition[$roll,0]=$roll	
	playerPosition[$roll,1]=$player
			
}
changeTurn()
{
	local playerValue=$1
	if (( $playerValue == 1))
	then
		player=2
	else
		player=1
	fi
}
playerOptions()
{
	local option=$(( $((RANDOM%3)) + 1 ))
	echo "Option: $option"
	rollDice
	((roll++))
	case $option in
		1)
			player
			playerPosition[$roll,2]=$currentPosition
			;;
		2)
			currentPosition=$(( $currentPosition + $value ))
			player
			playerPosition[$roll,2]=$currentPosition
			;;
		3)	
			currentPosition=$(( $currentPosition - $value))
			player
			playerPosition[$roll,2]=$currentPosition
			if (( $currentPosition < 0 ))
			then
				currentPosition=$START
				playerPosition[$roll,2]=$currentPosition
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
		currentPosition=${playerPosition[$roll,2]}
		rollDice		
		if (( $(($currentPosition + $value)) == 100 ))
		then
			currentPosition=100
			player
			playerPosition[$roll,2]=$currentPosition
			echo "Player ${playerPosition[$roll,1]} Won..."
			echo "Current Position of player: ${playerPosition[$roll,2]}"
			echo "Total Rolls: $roll"
			break
		elif (( $(( $currentPosition + $value )) > 100 ))
		then
			playerPosition[$roll,2]=${playerPosition[$roll,2]}
		else
			playerOptions
		fi
		echo "Current Position of player ${playerPosition[$roll,1]} : ${playerPosition[$roll,2]}"
		changeTurn $player
		echo "---------------------"
	done
}

winningGame
