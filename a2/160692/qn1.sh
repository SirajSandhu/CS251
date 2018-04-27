#!/bin/bash

explore_dir () {
  local comcount=0
  local strcount=0
	local d=`pwd`
	for f in "$d"/* ; do
		if [ ! -d "$f" ]; then
      local filstr=$(awk -f $awkFile $f)
      IFS='-' read -a filarr <<< "$filstr"
			local filcom=${filarr[0]}
			local filstr=${filarr[1]}
      comcount=$(($comcount + $filcom))
      strcount=$(($strcount + $filstr))
		fi
	done

	local DIRS=*/
	local subdircount=`find -maxdepth 1 -type d | wc -l`
	if [ $subdircount -eq 1 ]; then
		echo "$comcount-$strcount"
	else
		for d in $DIRS; do
			cd $d
			local dirstr=$(explore_dir)
      IFS='-' read -a dirarr <<< "$dirstr"
			local dircom=${dirarr[0]}
			local dirstr=${dirarr[1]}
      comcount=$(($comcount + $dircom))
      strcount=$(($strcount + $dirstr))
			cd ..
		done
		echo "$comcount-$strcount"
	fi
}

# set -x
currDir=`pwd`
awkFile="$currDir/qn1.awk"
Path=$1
cd $Path
cntstr=$(explore_dir)
IFS='-' read -a cntarr <<< "$cntstr"
ncom=${cntarr[0]}
nstr=${cntarr[1]}
echo "$ncom comments and $nstr strings"
# set +x
