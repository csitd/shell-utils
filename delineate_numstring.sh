#!/bin/sh 

delineate()
{
	for i in $@ 
	do
		CACHE="$i" 
		NUMBE=${#i}
        	COUNT="0" 
        	while [ "$COUNT" -lt "$NUMBE" ]
        	do 	printf "%1c\n" "${CACHE}" 
			CACHE="${CACHE#$(printf "%1c" "${CACHE}")}"
			COUNT=$(( COUNT + 1)) 
		done 
		printf "\n"
		CACHE="$i"
       		NUMBE="${#i}"
      		COUNT="0"
      	 	REMOV=""
		while [ "$COUNT" -lt "$NUMBE" ]
       		do	REMOV=${CACHE%*?} 
               		printf "%d\n" "${CACHE##$REMOV}"
               		COUNT=$(( COUNT + 1 )) 
           		CACHE="$REMOV"
        	done
		printf "\n" 
	done 
}
delineate "$@"





