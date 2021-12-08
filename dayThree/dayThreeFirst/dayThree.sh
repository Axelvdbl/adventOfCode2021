#!/bin/bash

file="../records.txt"
line_value=0
count_line=0
array=()
row_values=()

for line in $(<$file);
  do
    ((count_line+=1))
    ((line_value+=10#${line}))
    if [[ $(( $count_line % 9 )) == 0 ]];
      then
        array+=($line_value)
        line_value=0
    fi
done

if [[ $(( $count_line % 9 )) != 0 ]];
  then
    array+=($line_value)
fi

for el in ${array[@]}
  do
    for (( i=0; i<${#el}; i++ ))
      do
        ((row_values[$i]+=(${el:$i:1})))
    done
done

for (( i=0; i<${#row_values[@]}; i++ ))
  do
    if [[ ${row_values[$i]} -gt $((count_line/2)) ]]
      then
        ((row_values[$i]=1))
    else
      ((row_values[$i]=0))
    fi
done

gamma=$( IFS=$''; echo "${row_values[*]}" )
epsilon=$(echo $gamma | tr 01 10)
((power_consumption=$((2#$gamma))*$((2#$epsilon))))

echo $power_consumption
exit