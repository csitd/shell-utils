#!/bin/sh


# (C) 2014, MIT license, "selection_sort.sh" , csitd


selection_sort()
{
C="0" 
N="$#"

for i in $@
do
     eval ARRAY_"$C"="$i" 
     C=$(( $C + 1 ))
done 

C="0" 
   
while [ "$C" -lt "$(( $N - 1 ))" ]
do

     POSIT="$C";
     D=$(( $C + 1 ))
     while [ "$D" -lt "$N"  ]
     do
           if [ "$( eval printf '$'ARRAY_$POSIT )" -gt \
                "$( eval printf '$'ARRAY_$D )" ]
           then POSIT="$D";
           fi
           D=$(( $D + 1 ))
     done

     if [ "$POSIT" != "$C" ]
     then 
           HOLD="$( eval printf '$'ARRAY_$C )" 
           eval ARRAY_"$C"="$( eval printf '$'ARRAY_$POSIT )" 
           eval ARRAY_$POSIT="$HOLD"
     fi
     C=$(( $C + 1 ))
done 

C="0" 

while [ "$C" -lt "$N" ]
do 
     printf "%s\n"  "$( eval printf '$'ARRAY_$C )" 
     C=$(( C + 1 )) 
done

}
selection_sort $@

