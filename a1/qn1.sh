#! /bin/bash

print_lt_crore () {
	n=$1
	len=`echo "$n" | wc -m`
	len=$(($len - 1))
	defer=0
	prev_digit=0

	if [ $len -lt 8 ]; then
		while [ $len -gt 0 ]; do
			exp=$(($len - 1))
			digit=`echo "$n/(10^$exp)" | bc`

			if [ $len -eq 7 ] || [ $len -eq 5 ] || [ $len -eq 2 ]; then
				if [ $digit -eq 1 ]; then
					defer=1
					len=$(($len - 1))
					n=`echo "$n%(10^$exp)" | bc`
					continue
				fi

				case $digit in
					2) echo -n "twenty " ;;
					3) echo -n "thirty " ;;
					4) echo -n "forty " ;;
					5) echo -n "fifty " ;;
					6) echo -n "sixty " ;;
					7) echo -n "seventy " ;;
					8) echo -n "eighty " ;;
					9) echo -n "ninety " ;;
				esac
			else
				if [ $defer -eq 1 ]; then
					defer=0
					case $digit in
						0) echo -n "ten " ;; 
						1) echo -n "eleven " ;;
						2) echo -n "twelve " ;;
						3) echo -n "thirteen " ;;
						4) echo -n "fourteen " ;;
						5) echo -n "fifteen " ;;
						6) echo -n "sixteen " ;;
						7) echo -n "seventeen " ;;
						8) echo -n "eighteen " ;;
						9) echo -n "nineteen " ;;
					esac
				else
					case $digit in
						1) echo -n "one " ;;
						2) echo -n "two " ;;
						3) echo -n "three " ;;
						4) echo -n "four " ;;
						5) echo -n "five " ;;
						6) echo -n "six " ;;
						7) echo -n "seven " ;;
						8) echo -n "eight " ;;
						9) echo -n "nine " ;;
					esac
				fi	
			fi

			case $len in
				6) echo -n "lakh " ;;
				4) 
					if [ $prev_digit -ne 0 ] || [ $digit -ne 0 ]; then
						echo -n "thousand "
					fi
					;;
				3) 
					if [ $digit -ne 0 ]; then
						echo -n "hundred "
					fi
					;;
			esac

			len=$(($len - 1))
			n=`echo "$n%(10^$exp)" | bc`
			prev_digit=$digit
		done
	fi
}

n=$1
n=`echo "$n" | sed 's/^0*//'`
len=`echo "$n" | wc -m`
len=$(($len - 1))

if [ $len -gt 7 ]; then
	n_trunc=`echo "$n/(10^7)" | bc`
	n_left=`echo "$n%(10^7)" | bc`
	print_lt_crore $n_trunc
	echo -n "crore "
	print_lt_crore $n_left
	echo ""
else
	print_lt_crore $n
	echo ""
fi



