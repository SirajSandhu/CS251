increment () {
	xtemp=$(($1 + 1))
	echo $xtemp
}

x=4
echo "x=$x"
xinc=$(increment $x)
x2inc=$(($xinc + 1))
echo "x=$x2inc"
