#!/bin/sh


expon()
{
        COUNT="1"
        HOLD="$1"
        LENGT="$2"
        if [ "$LENGT" -eq 0 ]
        then    printf "1" 
        else	while [ "$COUNT" -lt "$LENGT" ]
        	do	HOLD=$(( HOLD * $1  ))
          		COUNT=$((COUNT + 1 ))
        	done
        	printf "$HOLD" 
        fi 
}



decimal_to_ip() 
{ 
	DEC="$1"
	for i in 3 2 1 0
	do 	OCTET=$(( $DEC /  $(expon 256 $i)  )) 
		DEC=$(( $DEC - $OCTET * $(expon 256 $i ) ))
		IP="${IP}${DELIM}$OCTET" 
		DELIM="."
	done
	printf '%s\n' "$IP"

}

decimal_to_ip "$@"
