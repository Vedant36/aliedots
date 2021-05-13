#!/bin/bash

# filename: wordcount.sh
# usage: word count

# handle position arguments
if [ $# -ne 1 ]
then
    echo "Usage: $0 filename"
    exit -1
fi

# realize word count
printf "%-18s%s\n" "Word" "Count"

cat $1 | tr 'A-Z' 'a-z' | \
egrep -o "\b[[:alpha:]]+\b" | \
awk '{ count[$0]++ }
END{
for(ind in count)
{ printf("%-18s%d\n",ind,count[ind]); }
}' | sort -k2 -n -r #| head -n 10
