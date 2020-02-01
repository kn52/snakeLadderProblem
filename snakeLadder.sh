#!/bin/bash
declare -A playerPosition
readonly STARTING_POINT=0
readonly END_POINT=100
readonly NOPLAY=1
readonly LADDER=2
readonly SNAKE=3
currentPlayerPosition=$STARTING_POINT
playerTurn=1
diceOutput=0
rollingDiceCount=0
echo "Welcome to Snake And Ladder Game"
rollDice()
{
	diceOutput=$(( 1 + $((RANDOM%6)) ))
}
player()
{
	playerPosition[$rollingDiceCount,0]=$rollingDiceCount	
	playerPosition[$rollingDiceCount,1]=$playerTurn
	playerPosition[$rollingDiceCount,2]=$currentPlayerPosition
			
}
changeTurn()
{
	local player=$1
	if (( $player == 1))
	then
		playerTurn=2
	else
		playerTurn=1
	fi
}
playerOptions()
{
	local option=$(( $((RANDOM%3)) + 1 ))
	rollDice
	((rollingDiceCount++))
	case $option in
		$NOPLAY)
			player
			;;
		$LADDER)
			currentPlayerPosition=$(( $currentPlayerPosition + $diceOutput ))
			player
			;;
		$SNAKE)	
			currentPlayerPosition=$(( $currentPlayerPosition - $diceOutput))
			player
			if (( $currentPlayerPosition < 0 ))
			then
				currentPlayerPosition=$STARTING_POINT
				playerPosition[$rollingDiceCount,2]=$currentPlayerPosition
			fi
			;;
		*)
			break
			;;
	esac
	
}
winningGame()
{
	
	
	until [[ $currentPlayerPosition -gt $END_POINT ]]
	do
		currentPlayerPosition=${playerPosition[$rollingDiceCount,2]}
		rollDice		
		if (( $(($currentPlayerPosition + $diceOutput)) == $END_POINT ))
		then
			currentPlayerPosition=$END_POINT
			player
			playerPosition[$rollingDiceCount,2]=$currentPlayerPosition
			echo -e "Player $playerTurn won....\nNumber of times dice rolled: $rollingDiceCount"
			break
		elif (( $(( $currentPlayerPosition + $diceOutput )) > $END_POINT ))
		then
			playerPosition[$rollingDiceCount,2]=${playerPosition[$rollingDiceCount,2]}
		else
			playerOptions
		fi
		changeTurn $playerTurn
	done
}

winningGame
