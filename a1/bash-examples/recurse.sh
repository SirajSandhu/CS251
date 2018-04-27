recurse()
{
    echo i1 $x
    local x=$1
    if [ $1 -lt 3 ]
    then
        echo i2 $1
        recurse $(($1 + 1))
        echo i3 $x
    fi
}

recurse 1
