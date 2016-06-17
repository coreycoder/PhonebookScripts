#!/bin/bash
#Author: Corey Thomason

if [ $# -eq 0 ] ; then
	echo "Please include the Record File as a command line argument and try again" 
	exit
fi

declare -a array
count=0

file="$1"
while IFS= read -r line
do
	name="$line"
	array[$count]="$name"
	(( count ++ ))
done < "$file"

input=0

createTempFile () {
	touch temp
	arg=$1	
	for ((i=0; i < "${#array[@]}"; i++))
	do
		echo "${array[$i]}" >> temp
		if [ $arg == "first" ] ; then
			`sort temp -o temp`
		elif [ $arg == "last" ] ; then
			`sort -k2 temp -o temp`
		fi
	done

	count=0
	while IFS= read -r line
	do
		sorted[$count]="$line"
		(( count ++ ))
	done < temp
}

sortAlphabetical () {
	count=0
	while IFS= read -r line
	do
		sorted[$count]="$line"
		(( count ++ ))
	done < temp
	rm temp

	echo "------------------------------------------------------------------------"
	if [ $1 == "first" ] ; then
		echo "All Records printed in Alphabetical Order by First Name"
	else
		echo "All Records printed in Alphabetical Order by Last Name"
	fi
	echo "------------------------------------------------------------------------"
	for ((i=0; i < "${#sorted[@]}"; i++))
	do
		echo ${sorted[$i]}
	done
	unset sorted
	echo "------------------------------------------------------------------------"
}


sortReverse () {
	count=0
	while IFS= read -r line
	do
		sorted[$count]="$line"
		(( count ++ ))
	done < temp
	rm temp
	
	echo "------------------------------------------------------------------------"
	if [ $1 == "first" ] ; then
		echo "All Records printed in Reverse Alphabetical Order by First Name"
	else 
		echo "All Records printed in Reverse Alphabetical Order by Last Name"
	fi
	echo "------------------------------------------------------------------------"
	for ((i=${#sorted[@]}; i >= 0; i--))
	do
		echo ${sorted[$i]}
	done
	unset sorted 
	echo "------------------------------------------------------------------------"

}


searchRecordLastName() {
	read -p "Enter last name to be searched: " lastname
	echo "------------------------------------------------------------------------"
	echo "Record with the Last name" $lastname
	echo "------------------------------------------------------------------------"
    awk -v var="$lastname" -F'[ :]' '$0 ~ var {print $0}' temp
	rm temp
	echo "------------------------------------------------------------------------"
	
}

searchRecordBirthday() {

	read -p "Enter date to be searched (Month/Day/Year): " birthday
	echo "------------------------------------------------------------------------"
	echo "Record with the birtday" $birthday
	echo "------------------------------------------------------------------------"
	awk -v var="$birthday" -F'[ :]' '$0 ~ var {print $0}' temp
	rm temp
	echo "------------------------------------------------------------------------"
}


while [ $input != 7 ] 
do
	declare -a sorted
	echo "------------------------------------------------------------------------"
	echo "(1) List records in alphabetical order by First Name"
	echo "(2) List records in alphabetical order by Last Name"
	echo "(3) List records in reverse alphabetical order by First Name"
	echo "(4) List records in reverse alphabetical order by Last Name"
	echo "(5) Search for a record by Last Name"
	echo "(6) Search for a record by Birthday"
	echo "(7) Exit"
	read -p "Enter an option: " input


	case $input in
		1)
			createTempFile first
			sortAlphabetical first
			;;

		2)
			createTempFile last
			sortAlphabetical last
			;;
		
		3)
			createTempFile first
			sortReverse first
			;;
	
		4)
			createTempFile last
			sortReverse last
			;;

		5)
			createTempFile first
			searchRecordLastName
			;;
		
		6)
			createTempFile first 
			searchRecordBirthday
			;;
		7)
			echo "Thank you for using"
			exit
			;;
			
		*)
			echo "Please enter a valid choice"
			continue
			;;					
	esac
	
done

