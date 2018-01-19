#!/bin/bash
#-------------------------------------------------
# Includes
#-------------------------------------------------
source data.sh

#-------------------------------------------------
# Variables
#-------------------------------------------------
basePath="/Users/ismailcam/uddannelse/soft/2semester/systemintegration/projects/LoanBroker/sources"

#-------------------------------------------------
# Channels
#-------------------------------------------------
prefix="group3"
creditScore_to_getBanks="$prefix.creditscore.getbanks"
getbanks_to_reciplist="$prefix.getbanks.reciplist"

# Not done
reciplist_to_translators="$prefix.reciplist.translators"
xmlTranslator_to_xmlBank=""
jsonTranslator_to_jsonBank=""
bank_to_normalizer="$prefix.bank.normalizer"
normalizer_to_aggregator="$prefix.normalizer.aggregator"

#-------------------------------------------------
# Functions
#-------------------------------------------------
function printLine()
{
	echo "------------------------------------------------------------------"
}

function printTitle()
{
	echo "${yellow}Starting ${1}...${resetColor}"
}

function startCreditScore()
{
	printTitle "Credit Score"
	result=$(java -jar $basePath/creditScore/target/Creditscore.one-jar.jar "$ssn,$amount,$duration" "$creditScore_to_getBanks")
	echo $result
	if [[ "$result" == *"Error"* ]]; then
		exit 1;
	fi
	printLine
}

function startGetBanks()
{
	printTitle "Get Banks"
	java -jar $basePath/getBanks/target/GetBanks.one-jar.jar "$creditScore_to_getBanks" "$getbanks_to_reciplist"
	printLine
}

function startRuleBase()
{
	printTitle "Rule Base Service"
	java -jar $basePath/rulebase/out/artifacts/rolebase_jar/rolebase.jar &
	printLine
}

function startAll()
{
	startRuleBase
	startCreditScore
}