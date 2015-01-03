#!/bin/sh 

# (C) 2014, MIT license, `cut.sh', csitd , GPL license

case "$1" in 
     --help ) echo " -c number-number   print a range of characters"
              echo " -c number          print a specific character" 
              echo " --help             show this menu" 
              echo " -f                 process fields" 
              echo "     last field must be > 1 char )"
              echo "list must be whitespace delineated" 
              echo " -d                 specify delimiter"
              echo "           note:    -d must preceed -f "
              exit 0
              ;;
esac



# process lower number  of -c
low(){ echo "${1%-*}" ; }; 

# process higher number of -c
hih(){ echo "${1#*-}" ; }; 

# count the chars of a word
cnt(){ echo "${#1}" ;};

# cat
dog(){

     [ "$1" ] && i="$@" || i="/dev/stdin"

     for j in $i
     do
          while read -r i
          do printf '%s\n' "$i"
          done < "$j"
     done
}


# Get input from stdin, as per convention
OPTION1=$(dog /dev/stdin )

WLENGTHA=$(cnt $OPTION1)


# Parse user options
parse(){
for i in $@
do case "$i" in 
 --output-delimiter=* ) OD="${1#*=}" ; shift ;;
     -d) VARHOLD=$(echo $i)
         shift
         ;;
     -f) VARHOLD=$(echo $i)
         shift
         ;; 
     -c) VARHOLD=$(echo $i)
         shift
         ;;
      *) case "$VARHOLD" in
             -c) case "$i" in 
                *|*-* )  # errors for compliace
                         if [ $(low $i) = "0" ]
                         then echo "Fields and positions start at 1" 
                              exit 1
                         fi 
                         if [ $(low $i) -gt  $(hih $i) ]
                         then echo "Invalid decrement"
                              exit 1
                         fi

                         # Count lower range
                         COUNTLOW=1 
                         while [      $COUNTLOW -lt  $(low $i)  \
                                  -a  $COUNTLOW -lt $WLENGTHA  ]
                         do LOWQUES=$LOWQUES$(echo -n "?")
                            COUNTLOW=$(( $COUNTLOW + 1 )) 
                         done 
                         
                         # Count upper range
                         COUNTHIH=0 
                         WLENGTHB=$(( $WLENGTHA -  $(hih $i) )) 
                         while [ $COUNTHIH -lt $WLENGTHB ] 
                         do COUNTHIH=$(( $COUNTHIH + 1 ))
                            HIHQUES=$HIHQUES$(echo -n "?")
                         done 
                         ;; 
                   
                 esac 
                 char_cut $OPTION1
                 ;;
             
              *) ;; 
         esac 
         case "$VARHOLD" in
             -d) DELIMITER="$i" 
                #echo " DELIMITER = $DELIMITER"
               
                ;;
         esac

         case "$VARHOLD" in
             -f) FEILDDEPTH="$i" 
                 #echo " FEILDDEPTH= $FEILDDEPTH"
                 
                 field_select $OPTION1 
                    case "$i" in
                        1) echo -n "${WORD1}${DELIMITER:+$OD}" ;;
                        2) echo -n "${WORD2}${DELIMITER:+$OD}" ;;
                        3) echo -n "${WORD3}${DELIMITER:+$OD}" ;;
                        4) echo -n "${WORD4}${DELIMITER:+$OD}";;
                        5) echo -n "${WORD5}${DELIMITER:+$OD}";;
                        6) echo -n "${WORD6}${DELIMITER:+$OD}";;
                        7) echo -n "${WORD7}${DELIMITER:+$OD}";;
                        8) echo -n "${WORD8}${DELIMITER:+$OD}";;
                        9) echo -n "${WORD9}${DELIMITER:+$OD}";;
                        10) echo -n "${WORD10}${DELIMITER:+$OD}" ;;
                        11) echo -n "${WORD11}${DELIMITER:+$OD}" ;;
                        12) echo -n "${WORD12}${DELIMITER:+$OD}" ;;
                        13) echo -n "${WORD13}${DELIMITER:+$OD}" ;; 
                    esac 
                 ;;
         esac 
   esac 
done
echo
} 
LENA=0
OLDLENA=13423


field_select()
{ 
METASTRING="${1}${DELIMITER}" 
if [ $METASTRING = ${METASTRING%${DELIMITER}} ]
then ENDDELIM=NO
     METASTRING="${METASTRING}${DELIMITER}nully" 
fi
FIELDCOUNT=0


while :
do

     FIELDCOUNT=$(( $FIELDCOUNT + 1 )) 
     STRING="$METASTRING" 
     LEN=$( cnt $STRING ) 
     GOODWOR="${STRING%%${DELIMITER}*}" 
     LENA=$( cnt ${STRING%${DELIMITER}} )
     OLDLENA="$LENA"
     if [ "$ENDDELIM" = "NO" ]
     then [ "$LENA" = 1 ] &&  break 
     fi
     [ "$LENA" -lt 2 ] && break 
     GLEN=$(( $( cnt $GOODWOR ) $OLDVAL  + 1 )) 
     OLDVAL=" + $GLEN " 
     export WORD${FIELDCOUNT}=${GOODWOR} 
     NEWVAL=$( echo "${STRING}" | parse -c ${GLEN}-78823 ) 
     NEWVAL="${NEWVAL#${DELIMITER}*}" 
     METASTRING="${NEWVAL}" 
     METASTRING="${METASTRING}${DELIMITER}"
     if [ "$ENDDELIM" = "NO" ]
     then [ "$LENA" = 1 ] && break 
     fi
     [ "$LENA" -lt 2 ] && break 
     OLDLENA="$LENA" 
done 

}

char_cut(){ 

VAR="${1#*$LOWQUES}" 
echo "${VAR%$HIHQUES*}" 

} 


parse $@


