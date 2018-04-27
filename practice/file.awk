#!/usr/bin/awk -f
{
	split($1, a, ",")
	if(a[3] == "UNIX")
	print $0
}
