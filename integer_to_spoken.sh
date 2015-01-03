#!/bin/sh 


# 2014, (Free), integer_to_spoken.sh, csitd

# Convert numbers to longhand written/spoken notation


int_to_lex_main()
{

	LENGTH="${#1}"
	TRICOUNT="1"
	HOLD="$1"
	TRIPLE=""
	REMAINDER=$((LENGTH % 3 ))
	COUNT="0"
	PLACE="${#1}"

	# handle any partial sets of three 
	while [ "$COUNT" -lt "$REMAINDER" ]
	do      TRIPLE="${TRIPLE}$(printf "%1c\n" "$HOLD" )"
       	 	HOLD="${HOLD#[0-9]}"
        	COUNT=$(( COUNT + 1 ))
	done

	int_to_lex "$TRIPLE"

	COUNT="0"
	TRIPLE=""
	PLACE="$LENGTH"

	while [ "$COUNT" -lt "$LENGTH" ]
	do      for j in "$HOLD"
	        do      TRIPLE="${TRIPLE}$(printf "%1c\n" "$j" )"
	                HOLD="${j#[0-9]}"
	                [ "$TRICOUNT" -eq 3 ] && int_to_lex "$TRIPLE"
	                [ "$TRICOUNT" -eq 3 ] && TRIPLE=""
	                COUNT=$(( COUNT + 1 ))
	                TRICOUNT=$(( TRICOUNT + 1 ))
	                [ "$TRICOUNT" -eq 4 ] && TRICOUNT="1"
	                PLACE=$(( PLACE - 1 ))
	        done
	done
	printf "\n"
}

int_to_lex()
{

        HOLDT="$1"
        TOKLEN="${#1}"
        TOKCNT="0"
        TOKENS=""

        A="-1"
        B="-1"
        C="-1"

        while [ "$TOKCNT" -lt "$TOKLEN" ]
        do      TOKENS="$(printf "%1c\n" "$HOLDT" )"
                HOLDT="${HOLDT#[0-9]}"
                [ "$TOKCNT" -eq "0" ] && A="$TOKENS"
                [ "$TOKCNT" -eq "1" ] && B="$TOKENS"
                [ "$TOKCNT" -eq "2" ] && C="$TOKENS"
                TOKCNT=$(( TOKCNT + 1 ))
        done

	[ "$TOKLEN" -eq 1 ] && { C="$A"; A="-1"; B="-1" ;}
	[ "$TOKLEN" -eq 2 ] && { C="$B"; B="$A"; A="-1" ;} 

        # hundreds
        [ "$A" -eq 1 ] && printf "one "
        [ "$A" -eq 2 ] && printf "two "
        [ "$A" -eq 3 ] && printf "three "
        [ "$A" -eq 4 ] && printf "four "
        [ "$A" -eq 5 ] && printf "five "
        [ "$A" -eq 6 ] && printf "six "
        [ "$A" -eq 7 ] && printf "seven "
        [ "$A" -eq 8 ] && printf "eight "
        [ "$A" -eq 9 ] && printf "nine "

        # voice rule for hundreds count 
        [ "$TOKLEN" -eq 3 -a "$A" -gt 0 ] && printf "hundred "

        # all of the "teens" have a special rule
        [ "$B" -eq 1 -a "$C" -eq 0 ] && printf "ten "
        [ "$B" -eq 1 -a "$C" -eq 1 ] && printf "eleven "
        [ "$B" -eq 1 -a "$C" -eq 2 ] && printf "twelve "
        [ "$B" -eq 1 -a "$C" -eq 3 ] && printf "thirteen "
        [ "$B" -eq 1 -a "$C" -eq 4 ] && printf "fourteen "
        [ "$B" -eq 1 -a "$C" -eq 5 ] && printf "fifteen "
        [ "$B" -eq 1 -a "$C" -eq 6 ] && printf "sixteen "
        [ "$B" -eq 1 -a "$C" -eq 7 ] && printf "seventeen "
        [ "$B" -eq 1 -a "$C" -eq 8 ] && printf "eighteen "
        [ "$B" -eq 1 -a "$C" -eq 9 ] && printf "nineteen "

        # all "*ties" are "tens" places 
        [ "$B" -eq 2 ] && printf "twenty "
        [ "$B" -eq 3 ] && printf "thirty "
        [ "$B" -eq 4 ] && printf "fourty "
        [ "$B" -eq 5 ] && printf "fifty "
        [ "$B" -eq 6 ] && printf "sixty "
        [ "$B" -eq 7 ] && printf "seventy "
        [ "$B" -eq 8 ] && printf "eighty "
        [ "$B" -eq 9 ] && printf "ninety "

	# Final columns main rule is to not break the "teens" 
        [ "$C" -eq 1 -a "$B" -ne "1" ] && printf "one "
        [ "$C" -eq 2 -a "$B" -ne "1" ] && printf "two "
        [ "$C" -eq 3 -a "$B" -ne "1" ] && printf "three "
        [ "$C" -eq 4 -a "$B" -ne "1" ] && printf "four "
        [ "$C" -eq 5 -a "$B" -ne "1" ] && printf "five "
        [ "$C" -eq 6 -a "$B" -ne "1" ] && printf "six "
        [ "$C" -eq 7 -a "$B" -ne "1" ] && printf "seven "
        [ "$C" -eq 8 -a "$B" -ne "1" ] && printf "eight "
        [ "$C" -eq 9 -a "$B" -ne "1" ] && printf "nine "

        #Change any unused place values to zero
        D="0"
        [ "$A" -lt "0" ] && A=0
        [ "$B" -lt "0" ] && B=0
        [ "$C" -lt "0" ] && C=0
        D=$(( $A + $B + $C ))

        [ "$PLACE" -lt 6 -a "$PLACE" -gt 3 -a "$D" -gt "-1" ] && printf "thousand "
        [ "$PLACE" -lt 9 -a "$PLACE" -gt 6 -a "$D" -gt "-1" ] && printf "million "
        [ "$PLACE" -lt 12 -a "$PLACE" -gt 9 -a "$D" -gt "-1" ] && printf "billion "
        [ "$PLACE" -lt 15 -a "$PLACE" -gt 12 -a "$D" -gt "-1" ] && printf "trillion "
        [ "$PLACE" -lt 18 -a "$PLACE" -gt 15 -a "$D" -gt "-1" ] && printf "quadrillion "
        [ "$PLACE" -lt 21 -a "$PLACE" -gt 18 -a "$D" -gt "-1" ] && printf "quintillion "
        [ "$PLACE" -lt 24 -a "$PLACE" -gt 21 -a "$D" -gt "-1" ] && printf "sextillion "
        [ "$PLACE" -lt 27 -a "$PLACE" -gt 24 -a "$D" -gt "-1" ] && printf "septillion "
        A="-1"
        B="-1"
        C="-1"

}

int_to_lex_main $@


