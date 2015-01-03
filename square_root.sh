#!/bin/sh

square_root()
{ 
	COUNT="1" 
	LENGT="4" 
	echo "$1"

	while [ "$COUNT" -lt "$LENGT" ]
	do 
		COUNT=$((COUNT + 1 ))
	done 
}
square_root $@
