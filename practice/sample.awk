#!/usr/bin/awk -f
BEGIN {sum=0}
{
	sum=sum+$5
	if(match($9, /.pdf$/)) {print "line no.", NR, "is", $0}
}
END {print sum}
