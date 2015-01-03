#!/bin/sh


hex_to_ip(){
        CACHE="$1"
        COUNT="0"
        REMOV=""
        while [ "$COUNT" -lt 4 ]
        do
                REMOV=${CACHE%*??}
                printf  "%d"  "0x${CACHE##$REMOV}" 2>/dev/null
                COUNT=$(( COUNT + 1 ))
                [ "$COUNT" -eq 4 ] && break
                printf  "."
                CACHE="$REMOV"
        done 
} 

f1(){ printf "$1\n" ;};
f2(){ printf "$2\n" ;};
f3(){ printf "$3\n" ;};
f8(){ printf "$8\n" ;};

while read -r i 
do 
	if [ $(f3 $(printf '%s' "$i")) = 00000000 ]
	then 	if [ $(f8 $(printf '%s' "$i")) != 00000000 ]
		then
		printf "%s" "Interface: "; 
		f1 $(printf '%s' "$i")
		printf "%s" "Network:   "
		hex_to_ip $(f2 $(printf '%s' "$i"))
		printf "\n"
		printf "%s" "Netmask:   "
		hex_to_ip $(f8 $(printf '%s' "$i")) 
		printf "\n" 
		fi
	fi 
done < /proc/net/route

for j in /proc/net/udp /proc/net/tcp
do
	while read i 
	do 	IFS=': '
		if [ "$(f2 $(printf "$i \n" ) )"  != 00000000  ]
		then HOLD=$(hex_to_ip $(f2 $(printf "$i\n" ) ) ) 
		fi 
	done < "$j"
done

printf "Address:   $HOLD\n"

