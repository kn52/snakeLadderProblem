#!/bin/bash

readonly START=0
currentPosition=$START
echo "Welcome to Snake And Ladder Game"
rollDice()
{
	value=$((RANDOM%6))
	echo "Dice Output: $value"
}

rollDice
