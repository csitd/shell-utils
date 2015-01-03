#!/bin/sh 

# (C) 2014, MIT license, "grop.sh", csitd 

# `grop', a "Glob Grabbing Parser"
#




compare(){ 
    case "$2" in 
      *${1}*) printf '%s%s%s\n' "${f:+$f:}" "${c:+$c:}" "${2}" ;; 
    esac 

}

stdin(){
     while read -r i
     do   compare "$p" "$i" 
          [ -n "$c" ] && c=$((c + 1)) # count line number
     done

}

concatenate(){ 
    [ -z "$1" ] && stdin
    for j in $@
    do   [ -n "$f" ] && f="$j" # reset file name
         [ -n "$c" ] && c=1 # reset line count
         stdin < "$j"
    done

}
help(){
     echo "V. 0.1 \`grop', a \"Glob Grabbing Parser\" "
     echo "grop.sh [OPTION] [PATTERN] [FILE(S)]" 
     echo "  -H     print file name of match" 
     echo "  -o     print word match only (use alone)" 
     echo "  -n     print line number of match"
     exit 1
}

grop(){ 
     [ -n "$1" ] || help
     for i in $@ ; do
          p="$1" ; shift
          case "$p" in 
            -h) help ;;
            -H) p="$1" ; f="$2" ; continue 
                ;;
            -o) unset f c
                p="$1" ; shift 
                for i in $(concatenate $@) 
                do  compare "$p" "$i" 
                done 
                break 
                ;;
            -n) c="1" ; continue 
                ;; 
             *) concatenate "$@" 
                break
                ;; 
          esac 
     done 
} 

grop "$@"



