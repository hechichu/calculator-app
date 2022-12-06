#!/bin/bash

clear																	#initialize terminal

echo > /tmp/calchist.txt												#initialize calculation history [Delete if you want perpetual history]

#Color & Text FX

BLNK='\033[5m'
RED='\033[0;31m'
YF='\033[33;5m'
NC='\033[0m'

#Introduction Text

echo "Welcome to the calculator app."									#Welcoming Text
sleep 1
echo
echo "Type q to exit."													#Command Help For Exiting
sleep 1
clear;

#While Loop for First Integer Input

while true; do		
	while true; do
	echo "Input first number:"											#Asks for first input
	read num1															#Collects user input
	echo
	if [ $num1 = "q" ]; then											#Quits if q is the input
		echo "Goodbye.";												#Output Text for quit input
		sleep 1; clear; exit;	
	elif [[ $((num1)) = $num1 ]]; then									#Checks if input is an integer by comparing it to itself arithmetically	
		echo; break;:													#If an integer is the input then it is stored, break the loop and go to the 2nd integer.
	else																
		clear;
		echo -e "${YF}$num1 is not an integer. Try Again.${NC}";		#If the input does not satisfy either of the previous conditions it is not a valid input so restart the loop.
		sleep 3;
		clear;
		echo "Try Again. NUMBERS only."
		echo															#Spacing, helps readability
	fi																	#End of First Input loop
	done																#End of Loop for First Integer Input
clear;
#While Loop for Second Integer Input

	while true; do
	echo "Input second number:"; 										#Asks for second input
	read num2															#Collects user input
	echo
	if 	[ $num2 = "q" ]; then											#Quits if q is the input
		echo;
		echo "Goodbye.";												#Output Text for quit input
		sleep 1; clear; exit
	elif [[ $((num2)) = $num2 ]]; then									#Checks if input is an integer by comparing it to itself arithmetically
		echo; break;:													#If an integer is the input then it is stored, break the loop and go to the Operator.
	else
		clear;
		echo -e "${YF}$num2 is not an integer. Try Again.${NC}";		#If the input does not satisfy either of the previous conditions it is not a valid input so restart the loop.
		sleep 3;														#Spacing, helps readability
		clear;
		echo "Try Again. NUMBERS only."
		echo
	fi																	#End of Second Input Loop
	done																#End of Loop for Second Integer Input
clear;

#While Loop for Operation	
	while true; do															
	echo "Which operation? (A) for +,(S) for -,(D) for /,(M) for *?";	#Asks For Operator
	read op1															#Collects user input
	echo																#Spacing, helps readability

	add=$(expr $num1 + $num2)											#Defines what addition of the two inputs equals and stores it in a variable
	subtract=$(expr $num1 - $num2)										#Defines what subtraction of the second input from the first input equals and stores it in a variable.
	divide=$(expr $num1 / $num2)										#Defines what Division of the first input by the second equals and stores it in a variable
	remainder=$(expr $num1 % $num2)										#Defines what a remainder of the division operator is and stores it in a variable
	multiply=$(expr $num1 \* $num2)										#Defines what multiplication of the two inputs equals and stores it in a variable

	if [[ $op1 = A ]]; then												#If the input is "A" then run the following lines of code
		sol=$add;														#Place the "add" variable in the "sol" variable
		cal="$num1 '+' $num2 '=' $sol";echo $cal; sleep 3;break			#Human readable annotation
	elif [[ $op1 = S ]]; then											#If the input is "S" then run the following lines of code
		sol=$subtract;													#Place the "subtract" variable in the "sol" variable	
		cal="$num1 '-' $num2 '=' $sol";echo $cal; sleep 3;break			#Human readable annotation
	elif [[ $op1 = D ]]; then 											#If the input is "D" then run the following lines of code
		sol="$divide with a remainder of $remainder";					#Place a string that displays the quotient as well as "with a remainder of" the remainder
		cal="$num1 '/' $num2 '=' $sol";echo $cal;sleep 3;break			#Human readable annotation
	elif [[ $op1 = M ]]; then											#If the input is "M" then run the following lines of code
		sol=$multiply;													#Place the "multiply" variable in the "sol" variable
		cal="$num1 '*' $num2 '=' $sol";echo $cal;sleep 3;break			#Human readable annotation
	elif [[ $op1 = "q" ]]; then											#Quits if q is the input
		echo;
		echo "Goodbye.";												#Output text for the quit input
		sleep 1; clear; exit
	else
		clear;
		echo -e "${YF}Invalid Input. Try Again.${NC}";
		sleep 3;
		clear;
	fi																	#End of If loop for Operation
 	
	done																#End of While Loop for Operation	
	echo;
	echo $cal >> /tmp/calchist.txt										#Appends the Human Readable Annotation to a text file in the same directory as script
	clear;
#While Loop for Displaying History
		while true; do
			echo "Display history? (20 Max) (Y/N) [e to clear history]"	#Asks user if they want to view or erase calculation history
			read hist													#Collects user response
			echo;
			if [[ $hist = Y ]]; then									#If user inputs Y then run the following commands
				clear;
				echo "Last 20 Operations:";								#Helps readability
				tail -20 /tmp/calchist.txt;								#Print the last 20 lines of text from calchist.txt
				sleep 8;echo; clear; sleep 1; echo "Welcome Back!";		#Welcome back for the case when a user wants to do more than one calculation
				sleep 1;
				echo; echo "Reminder: Type q to exit.";sleep 1;			#Reminder for the quit input
				clear;
				break													#Go back to ask for integer loop

			elif [[ $hist = "q" ]]; then								#If user inputs q then quit the script
				echo;
				echo "Goodbye.";										#Output for quitting the script
				sleep 1; clear; exit;
			elif [[ $hist = "N" ]]; then								#If user inputs N then run the following commands
				echo; clear; sleep 1; echo "Welcome Back!";				#Welcome back for the case when a user wants to do more than one calculation
				sleep 1;
				echo; echo "Reminder: Type q to exit.";sleep 1;			#Reminder for the quit input
				clear;
				break													#Go back to ask for integer loop
			elif [[ $hist = "e" ]]; then
				echo > /tmp/calchist.txt; clear;
				echo;
				echo -e "\033[5mHistory reset complete.\033[0m";
				sleep 4;
				echo; clear; sleep 1; echo "Welcome Back!";				#Welcome back for the case when a user wants to do more than one calculation
				sleep 1;
				echo; echo "Reminder: Type q to exit.";sleep 1;			#Reminder for the quit input
				clear;
				break													#Go back to ask for integer loop
			else
				clear;
				echo -e "${YF}Invalid Input. Try Again.${NC}";
				sleep 3;
				clear;
					 													#If an improper input is entered then restart the loop and ask for a proper input
			fi
		done
done	

	exit


exit
