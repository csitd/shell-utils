#!/bin/sh
func(){ 

	IFS="$1" 
	shift
	for i in $@ 
	do printf "$i" 
	done 

}
func $@

func(){ IFS="$1" ; shift ; for i in $@ ; do printf "$i" ; done ; } ; func

