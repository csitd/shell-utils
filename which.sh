#!/bin/sh


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


which(){

for i in $(tokenizer $PATH ":"  ) 
do 
    #echo "${i}" # test directory walk 
    [ -d "${i}/${1}" ] && break
    [ -x "${i}/${1}" ] && echo "${i}/${1}" && exit 
done

}
which $@



