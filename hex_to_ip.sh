#!/bin/sh

hex_to_ip(){
	CACHE="$1"
	NUMBE="$(( ${#1} / 2 )) " 
	COUNT="0"
	REMOV=""
	while [ "$COUNT" -lt "$NUMBE" ]
	do 
		REMOV=${CACHE%*??} 
		printf  "%d"  "0x${CACHE##$REMOV}"
		COUNT=$(( COUNT + 1 ))
		[ "$COUNT" -eq "$NUMBE" ] && break
		printf  "." 
		CACHE="$REMOV" 
	done
	printf  "\n"
	
} 

hex_to_ip $@
