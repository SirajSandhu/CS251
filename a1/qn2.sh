#!/bin/bash

read_file () {
	local fs=`egrep -o "[.][^0-9]|[.]$" $1 | wc -l`
	local qm=`fgrep -o ? $1 | wc -l`
	local em=`fgrep -o ! $1 | wc -l`
	local ns=$(($fs + $qm + $em))

	local ni=0
	while read line; do
		for word in $line; do
			if [[ "$word" =~ ^-?[0-9]+[\,\.\;\!]?$ ]]
      	then
        ni=$(($ni + 1))
      fi
		done
	done <$1

	echo "$ns-$ni"
}

explore_dir () {
	local pns=0
	local pni=0
	local d=`pwd`
	for f in "$d"/* ; do
		if [ ! -d "$f" ]; then
			local ret=$(read_file $f)
			IFS='-' read -a narr <<< "$ret"
			local ns=${narr[0]}
			local ni=${narr[1]}
			local fn=$(basename "$f")
			pns=$(($pns + $ns))
			pni=$(($pni + $ni))
			for ((c=1; c<=$depth; c++)); do
				echo -n "	" >&2
			done
			echo "(F) $fn-$ns-$ni" >&2
		fi
	done

	local DIRS=*/
	local subdircount=`find -maxdepth 1 -type d | wc -l`
	if [ $subdircount -eq 1 ]; then
		echo "$pns-$pni"
	else
		for d in $DIRS; do
			cd $d
			depth=$(($depth + 1))
			local rnsi=$(explore_dir)
			IFS='-' read -a rnarr <<< "$rnsi"
			local rns=${rnarr[0]}
			local rni=${rnarr[1]}
			pns=$(($pns + $rns))
			pni=$(($pni + $rni))
			depth=$(($depth - 1))
			for ((c=1; c<=$depth; c++)); do
				echo -n "	" >&2
			done
			echo "(D) $d-$rns-$rni" >&2
			cd ..
		done
		echo "$pns-$pni"
	fi
}

path=$1
depth=1
cd $path
pns=0
pni=0
# set -x
tnsi=$(explore_dir)
IFS='-' read -a tnarr <<< "$tnsi"
tns=${tnarr[0]}
tni=${tnarr[1]}
echo "(D) $(basename "$path")-$tns-$tni"
# set +x
