#!/bin/sh


# (C) 2014, MIT license, "insertion_sort.sh" , csitd


insertion_sort()
{
C="0" 
N="$#"

for i in $@
do
     eval ARRAY_"$C"="$i" 
     C=$(( $C + 1 ))
done 

C="1" 

while [ "$C" -lt "$N" ]
do 
     D="$C" 
     while [ "$D" -gt "0" -a \
         "$( eval printf '$'ARRAY_$D )" -lt \
         "$( eval printf '$'ARRAY_$(( $D - 1 )) )" ]
     do 
          HOLD="$( eval printf '$'ARRAY_$D )" 
          eval ARRAY_"$D"="$( eval printf '$'ARRAY_$(( $D - 1 )) )" 
          eval ARRAY_$(( $D - 1 ))="$HOLD"
          D=$(( $D - 1 ))
     done 
     C=$(( $C + 1 ))
done 
  
C="0" 

while [ "$C" -lt "$N" ]
do 
     printf "%s\n"  "$( eval printf '$'ARRAY_$C )" 
     C=$(( C + 1 )) 
done

}
insertion_sort $@

