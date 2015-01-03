#!/bin/sh

# (C) 2014, MIT license, "dog.sh", csitd 

dog(){
   
     [ -n "$1" ] && i="$@" || i="/dev/stdin" 

     for j in $i
     do   
          while read -r i
          do printf '%s\n' "$i" 
          done < "$j"
     done
}

dog $@




