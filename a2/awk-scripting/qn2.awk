#!/usr/bin/gawk
BEGIN{

}
{
    # split string into src and dest
    split($5, strArr, ":")
    source=$3
    destination=strArr[1]
    address[source FS destination]=source FS destination

    # timestamp
    split($1, timestamp, ":")
    currTime[source FS destination]=timestamp[3]
    if (startTime[source FS destination]) {}
    else { startTime[source FS destination]=timestamp[3] }
    totalTime[source FS destination]=currTime[source FS destination] - startTime[source FS destination]

    data[source FS destination]+=$NF
    if($NF != 0) { numDataPackets[source FS destination]++ }
    numPackets[source FS destination]++
}

END{
    for (i in address) { flag[i]  =0 }
    for (i in address) {
        if(flag[i] != 1) {
            split(i, addressStr, " ")
            source=addressStr[1]
            sourceCpy=split(source, srctemp, ".")
            sourceTemp=srctemp[1]"."srctemp[2]"."srctemp[3]"."srctemp[4]":"srctemp[5]
            destination=addressStr[2]
            destinationCpy=split(destination, desttemp, ".")
            destinationTemp=desttemp[1]"."desttemp[2]"."desttemp[3]"."desttemp[4]":"desttemp[5]
            printf("Connection (A=%s B=%s)\n", sourceTemp, destinationTemp)
            printf("A-->B #packets=%d, #datapackets=%d, #bytes=%d, #retrans=%d xput=%d bytes/sec\n",numPackets[source FS destination],numDataPackets[source FS destination], data[source FS destination], 0, data[source FS destination]/totalTime[source FS destination])
            printf("B-->A #packets=%d, #datapackets=%d, #bytes=%d, #retrans=%d xput=%d bytes/sec\n", numPackets[destination FS source],numDataPackets[destination FS source], data[destination FS source], 0, data[destination FS source]/totalTime[destination FS source])
            flag[destination FS source]=1
         }
    }
}
