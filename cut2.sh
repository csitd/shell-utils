#!/bin/sh 

# (C) 2014, MIT license, `cut.sh', csitd , GPL license

case "$1" in 
     --help ) echo " -c number-number   print a range of characters"
              echo " -c number          print a specific character" 
              echo " --help             show this menu" 
              echo " -f                 process fields" 
              echo  "   last field must be > 1 char )"
              echo  "   list must be whitespace delineated" 
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
                         [ $(low $i) = "0" ] && 
                              { echo "Start at 1" ; exit 1 ;} ;
                         [ $(low $i) -gt  $(hih $i) ] &&
                                { echo "Invalid decrement" ; exit 1 ;} ;

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
                ;;
         esac

         case "$VARHOLD" in
             -f) FEILDDEPTH="$i" 
                 tokenizer "$i" ","

                 tokenate "$OPTION1" "/"
                 #echo " FEILDDEPTH= $FEILDDEPTH" 
                 #for i in $(tokenizer "$i" ",")
                 #do echo "$i"
                 #done
                  
                 ;;
         esac 
   esac 
done
echo
} 

THROTTLE=0 
 
tokenate()
{
     STRNG="${1}"
     STRNG="${STRNG}/"
     DELIM="${2}"

     while [ true ]
     do
          NEW="${STRNG%${DELIM}}"
         
          while [ "$THROTTLE" -lt "50" ] 
          do   
               THROTTLE=$(( $THROTTLE + 1 )) 
                NEW="${NEW%${DELIM}*}" 
          done
          TOKEN="${NEW%${DELIM}*}"
          STRNG="${STRNG#${TOKEN}${DELIM}}"
         
          printf "%s\n" "$TOKEN"
          THROTTLE=$(( $THROTTLE + 1 ))
          if [ "$THROTTLE" -lt "50" ]
          
          then    echo throttle
          fi
         


          case "$STRNG" in
               *${DELIM}*) ;;
               *) [ -n "$d" ] && break || d="1" ;;
          esac
     done
}



tokenizer()
{
     STRNG="${1}"
     DELIM="${2}"

     while :
     do
          NEW="${STRNG%${DELIM}}"
          while case "$NEW" in
                     *${DELIM}*);;
                     *)break;;
                esac
          do   NEW="${NEW%${DELIM}*}"
          done
          TOKEN="${NEW%${DELIM}*}"
          STRNG="${STRNG#${TOKEN}${DELIM}}"
          printf "%s\n" "$TOKEN"

          case "$STRNG" in
               *${DELIM}*) ;;
               *) [ -n "$d" ] && break || d="1" ;;
          esac
     done
}



char_cut(){ 

VAR="${1#*$LOWQUES}" 
echo "${VAR%$HIHQUES*}" 

} 


parse $@


