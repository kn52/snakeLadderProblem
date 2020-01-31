#!/bin/bash

readonly START=0
currentPosition=$START
echo "Welcome to Snake And Ladder Game"
rollDice()
{
	value=$(( 1 + $((RANDOM%6)) ))
	echo "Dice Output: $value"
}
playerOptions()
{
	local option=$(( $((RANDOM%3)) + 1 ))
	echo "Option: $option"
	rollDice
	case $option in
		1)
			currentPosition=$currentPosition
			;;
		2)
			currentPosition=$(( $currentPosition + $value ))
			;;
		3)	
			currentPosition=$(( $currentPosition - $value))
			if (( $currentPosition < 0 ))
			then
				currentPosition=$START
			fi
			;;
		*)
			echo "Option: $(( $((RANDOM%3)) + 1 ))"
			echo "Option not available"
			;;
	esac
	echo "Current Position of player: $currentPosition"
}

playerOptions
