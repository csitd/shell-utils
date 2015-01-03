#!/bin/sh

# (C) 2014 `tokenizer' csitd 

# Usage: tokenizer [STRING] [DELIMITER}

# Example:  tokenizer $PATH :




tokenizer()
{
     STRNG="${1}"
     DELIM="${2}" 

     while :
     do   NEW="${STRNG%${DELIM}}" 
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

tokenizer $1 $2 



