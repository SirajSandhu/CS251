def base_convert(N, b) :
    negative = False
    decimal = False
    invalid = False

    if N.startswith('-') :
        negative = True
        N = N[::-1][:-1]
    else :
        N = N[::-1]

    if b > 10 :
        limit = ord('A') + b - 11
    else :
        limit = ord('0') + b - 1

    n = 0
    place = 0

    for i in N :
        val = ord(i)
        if i == '.' :
            decimal = True
            decimal_places = place
        elif (ord('0') <= val and val <= ord('9')) or (ord('A') <= val and val <= ord('Z')) :
            if val > limit :
                invalid = True
                break
            else :
                if val >= ord('A') :
                    num = val - ord('A') + 10
                else :
                    num = val - ord('0')
            n = n + num * (b ** place)
            place = place + 1

        else :
            invalid = True
            break

    if invalid == True :
        return "Invalid Input"

    if decimal == True :
        n = float(n)
        n = n / (b ** decimal_places)
    if negative == True :
        n = n * -1
    return n

def int_convert(x) :
    xnum = 0
    for i in x :
        xnum = xnum * 10
        xnum = xnum + ord(i) - ord('0')
    return xnum

import sys

N = sys.argv[1]
b = sys.argv[2]
b = int_convert(b);

print base_convert(N, b)
