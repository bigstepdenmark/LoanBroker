#!/bin/bash
#-------------------------------------------------
# Includes
#-------------------------------------------------
source colors.sh

#-------------------------------------------------
# Functions
#-------------------------------------------------
# Remove all content from data.sh file
function resetData()
{
	> data.sh
}

# Print line
function printTextBox()
{
	echo ""
	echo "${resetColor}--------------------------------------------------------------"
	echo "${1} ${2}"
	echo "${resetColor}--------------------------------------------------------------"
	echo ""
}

# Ask user for input, and set the input from to data.sh file.
function getInput()
{
	while [ true ]; do
		printf "${blue} Enter ${1}: ${yellow}"
		read input
		if [ ! -z "$input" ]; then
			echo "${2}=\"$input\"" >> data.sh
			break
		else
			echo "${pink} Error ${1} is required!"
		fi
	done
}

function getInputs()
{
	getInput "SSN" "ssn"
	getInput "Amount" "amount"
	getInput "Duration" "duration"
}

function startApps()
{
	source startApps.sh 
	startAll
}

#-------------------------------------------------
# Run
#-------------------------------------------------
resetData
printTextBox ${white} "Welcome to Loan Broker"
getInputs
printTextBox ${cyan} "Thank you. You will receive an answer in a moment"
startApps
source data.sh
v=$[100 + (RANDOM % 100)]$[1000 + (RANDOM % 1000)]
v=$[RANDOM % 15].${v:1:2}${v:4:3}
printTextBox ${cyan} "Hello ${ssn}, we can offer you a rate of ${v}"
