#!/bin/sh 

hex_to_int()
{
	for i in $@
	do 	printf  "%d\n" "0x${i}" 
	done
}
hex_to_int $@




