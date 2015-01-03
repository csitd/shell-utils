#!/bin/sh


# (C) 2014, MIT license, "bubble_sort.sh" , csitd


bubble_sort()
{
C="0" 
N="$#"

for i in $@
do
      eval ARRAY_"$C"="$i" 
      C=$(( $C + 1 ))
done


C="0"

while [  "$C" -lt "$(( $N - 1 ))"  ]
do 
     D=0 
     while [ "$D" -lt "$(( $N - $C - 1 ))"  ]
     do 
          if [  "$( eval printf '$'ARRAY_$D )" -gt \
                "$( eval printf '$'ARRAY_$(( $D + 1 )) )" ] 
          then   
               HOLD="$( eval printf '$'ARRAY_$D )" 
               eval ARRAY_"$D"="$( eval printf '$'ARRAY_$(( $D + 1 )) )" 
               eval ARRAY_$(( $D + 1 ))="$HOLD" 
          fi 
          D=$(( $D + 1 )) 
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
bubble_sort $@

