#!/bin/sh


STRNG="${1}"
DELIM="${2}"
RANGE="${3}"

#cutter(){ echo "${1%*}" ; };

# nasty hack, string has prepended delimiter

shift
shift 

for i in $@
do   [ -n "$i" ] && RANGE="$i" 
     [ -n "$LCNT" ] && [ "$LCNT" -gt "$RANGE" ] && exit
     #RANGE="$LCNT" 

     TAIL="${DELIM}${STRNG}" 
     COUNT="0"

     while [ "$RANGE" -gt "$COUNT" ]
     do 
          COUNT=$(( $COUNT + 1 )) 
          #echo "original string: ${STRNG}" 
          TAIL="${TAIL#*${DELIM}}" 
          HEAD="${TAIL%%${DELIM}*}" 
          if [ "$RANGE" -eq "$COUNT" ]
          then LAST="$HEAD"
               LCNT="$COUNT" 
               printf "%s${DELIM}" "$HEAD" 
          fi 
     done
done












