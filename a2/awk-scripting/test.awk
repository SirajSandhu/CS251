BEGIN{
}
{
	barr[$NF] ++;
}
END{
	for (i in barr) {print i" "barr[i]}
}
