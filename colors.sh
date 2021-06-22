#!/bin/bash

# prints columns of text by index of array

h=`tput lines`
w=`tput cols`
buff=' '
_total_to_print=255
str=${1:-'tput setaf '}
let _max_size=`echo $(( ${#str} + ${#buff} + ${#_total_to_print} ))`
let _swatches_per_line=$(( $w/($_max_size) )) # number of cols
let _lines_to_print=$(( $_total_to_print/$_swatches_per_line ))
if [[ $(( $_total_to_print % $_swatches_per_line )) -gt 0 ]]; then
	_lines_to_print=$(( $_lines_to_print + 1))
fi

function print_swatch () {
        tput setaf $1
        printf "$str$1"
	printf "$buff%.0s" `seq $(( ${#_total_to_print} - ${#1} +1))`
} 
let _ct=0
for c in `seq $_lines_to_print`; do
	printf "\n"
	for r in `seq $_swatches_per_line`; do
		print_swatch $(( ( ( ( ($r-1) ) % $_swatches_per_line )*$_lines_to_print ) + c))
		#print_swatch $(( ( ( ($r-1) % $_swatches_per_line ) * c ) + c))
		_ct=$(( $_ct + 1 ))
	done
done
printf "\n"
tput setaf 255

function commentedout () {
_chars_printed=0
for i in `seq $_total_to_print`; do
	_size=$(( ${#i} + ${#str} - 3 )) 
	_padding=$((${#str} - 3))
	if [[ $(( $_chars_printed + $_max_size )) -gt $w ]]; then 
		printf "$wrap_count\n"
		_chars_printed=0
	fi
	_pad_size=$(( ${#_total_to_print} - ${#i} ))
	#echo "---$_pad_size"
	print_swatch $i
	printf "$buff%.0s" {0..$_pad_size}
	#tput setaf $i
	#printf "$str$i$buff" {0..${#buff}}
	let _chars_printed=$(( $_chars_printed + ${#str} + ${#i} + ${#buff} ))
done
}

function debug(){
echo
echo "swatch str: '$str' ($_max_size chars)"
echo "swatches per line: $_swatches_per_line"
echo "lines to print: $_lines_to_print"
echo "cols: $w"
echo "count: $_ct"
}
