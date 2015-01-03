#!/bin/sh


# (C) 2014, MIT license, "selection_sort.sh" , csitd


# this is not finished, do not use!!


selection_sort()
{
C="0" 
N="$#"

for i in $@
do
     eval END_"$C"="$i"
     eval BEG_"$C"="$i"
     eval ARRAY_"$C"="$i" 
     C=$(( $C + 1 ))
done 


   
    # int pivot, beg[MAXENGTH], end[MAXENGTH], alpha, omega, varhold ;

    # int c=0;
  
   
    C="0"
     #beg[0] = 0;

      BEG_0="0"
    
     #end[0] = n;
     END_0="$N"
     #while ( c >= 0 ) 
     while [ "$C" -gt  "0" -o "$C" -eq  "0"  ]
     do echo loop 1
          #alpha = beg[c];
          ALPHA="$( eval echo '$'BEG_$C )"
          #omega = end[c] - 1;
          OMEGA=$(( $( eval echo '$'END_$C ) - 1 ))
          #if ( alpha < omega ) 
          if [ "$ALPHA" -lt "$OMEGA" ] 
          then  echo loop 2
               #pivot = numray[alpha];
                PIVOT="$(eval echo '$'ARRAY_$ALPHA )"
               #while ( alpha < omega ) 
               while [ "$ALPHA" -lt "$OMEGA"   ] 
               do echo we are in
                    #while (numray[omega] >= pivot && alpha < omega )
                    while [ "$(eval echo '$'ARRAY_$OMEGA )" -gt "$PIVOT" -o \
                             "$(eval echo '$'ARRAY_$OMEGA )" -eq "$PIVOT" -a \
                            "$ALPHA" -lt "$OMEGA" ] 
                    do OMEGA=$(( $OMEGA - 1 ))
                    done
                    echo we are in 2
                    #if (alpha < omega)
                    if [ "$ALPHA" -lt "$OMEGA" ] 
                    then echo stage 1
                        # numray[alpha++]=numray[omega];
                        ALPHA=$(( $ALPHA + 1 )) 
                        eval ARRAY_$ALPHA="$( eval echo '$'ARRAY_$OMEGA )"
                    fi
                   
                    #while ( numray[alpha] <= pivot && alpha < omega )
                    while [ "$( eval echo '$'ARRAY_$ALPHA )" -lt "$PIVOT" -o \
                             "$( eval echo '$'ARRAY_$ALPHA )" -eq "$PIVOT" -a \
                               "$ALPHA" -lt "$OMEGA" ]
                    do  echo stage 2
                        ALPHA=$(( $ALPHA + 1 ))
                       
                    done 

                    #if ( alpha < omega )
                    if [ "$ALPHA" -lt "$OMEGA" ] 
                    then  echo stage 3

                          #numray[omega--] = numray[alpha];
                          OMEGA=$(( $OMEGA - 1 )) 
                          eval ARRAY_$OMEGA="$( eval echo '$'ARRAY_$ALPHA )"

                    fi
                    echo "ALPHA IS $ALPHA  OMEGA is $OMEGA"
                    #exit
               done
               echo made it out of 2
               # numray[alpha] = pivot;
               eval ARRAY_$ALPHA="$PIVOT"

               #beg[c+1] = alpha + 1;
               eval BEG_$(( $C + 1 ))=$(( $ALPHA + 1 ))
               # end[c+1] = end[c];
               eval END_$(( $C + 1 ))="$( eval echo '$'END_$C )"
               #end[c++] = alpha;
                     C=$(( $C + 1 ))  # extra invermentor
               eval END_$C="$ALPHA"
                  

               #if ( end[c] - beg[c] > end[c-1] - beg[c-1] ) 
               if [ "$(( $( eval echo '$'END_$C )  - $( eval echo '$'BEG_$C ) ))"  -gt \
                    "$(( $( eval echo '$'END_$(( $C - 1 )) ) - $( eval echo '$'BEG_$(( $C - 1 )) )  ))"  ] 
               then echo we are in 3
                     #varhold = beg[c];
                     HOLD="$( eval echo '$'BEG_$C )"

                     #beg[c] = beg[c-1];
                     eval BEG_"$C"="$( eval echo '$'BEG_$(( $C - 1 )) )"

                     #beg[c-1] = varhold;
                      eval BEG_$(( $C - 1 ))="$HOLD"

                     #varhold = end[c];
                     HOLD="$( eval echo '$'END_$C )"

                     # end[c] = end[c-1]; 
                     eval END_"$C"="$( eval echo '$'END_$(( $C - 1 )) )"

                     #end[c-1] = varhold; 
                     eval END_$(( $C - 1 ))="$HOLD"
          
                fi
             
          else  echo tail loop was hit
                 C=$(( $C - 1 )) 
          fi
     done

#while [ "$C" -lt "$(( $N - 1 ))" ]
#do
#
#     POSIT="$C";
#     D=$(( $C + 1 ))
#     while [ "$D" -lt "$N"  ]
#     do
#           if [ "$( eval echo '$'ARRAY_$POSIT )" -gt \
#                "$( eval echo '$'ARRAY_$D )" ]
#           then POSIT="$D";
#           fi
#           D=$(( $D + 1 ))
#     done 
#
#done 

C="0" 

while [ "$C" -lt "$N" ]
do 
    # echo "%s\n"  "$( eval echo '$'ARRAY_$C )" 
    echo   "$( eval echo '$'ARRAY_$C )"

     C=$(( C + 1 )) 
done

}
selection_sort $@

