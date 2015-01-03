#!/bin/sh

expon()
{
        COUNT="1"
        HOLD="$1"
        LENGT="$2"
        if [ "$LENGT" -eq 0 ]
        then    printf "1"
        else    while [ "$COUNT" -lt "$LENGT" ]
                do
                        HOLD=$(( HOLD * $1  ))
                        COUNT=$((COUNT + 1 ))
                done
                printf "$HOLD"
        fi
}
expon $@
