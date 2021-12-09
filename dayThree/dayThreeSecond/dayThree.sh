#!/bin/bash

file="../records.txt"
one_array=()
zero_array=()
ox_generator=()
ox_epurator=()
line_length=0

for line in $(<$file);
  do
    line_length=${#line}
    if [[ ${line:0:1} == 1 ]]
      then
        one_array+=($line)
      else
        zero_array+=($line)
    fi
done

if [[ ${#one_array[@]} -gt ${#zero_array[@]} ]]
  then
    ox_generator=(${one_array[@]})
    ox_epurator=(${zero_array[@]})
  else
    ox_generator=(${zero_array[@]})
    ox_epurator=(${one_array[@]})
fi

set_ox_generator() {
  tmp_zero_array=()
  tmp_one_array=()
  if [[ ${#ox_generator[@]} -eq 1 ]]
    then
      return;
  fi
  for el in ${ox_generator[@]}
    do
      if [[ ${el:$1:1} == 1 ]]
        then
          tmp_one_array+=($el)
          ((count+=1))
        else
          tmp_zero_array+=($el)
          ((count-=1))
      fi
  done
  if [[ $count -ge 0 ]]
    then
      ox_generator=(${tmp_one_array[@]})
    else
      ox_generator=(${tmp_zero_array[@]})
  fi
  count=0
}

set_ox_epurator() {
  tmp_zero_array=()
  tmp_one_array=()
  if [[ ${#ox_epurator[@]} -eq 1 ]]
    then
      return;
  fi
  for el in ${ox_epurator[@]}
    do
      if [[ ${el:$1:1} == 1 ]]
        then
          tmp_one_array+=($el)
          ((count+=1))
        else
          tmp_zero_array+=($el)
          ((count-=1))
      fi
  done
  if [[ $count -ge 0 ]]
    then
      ox_epurator=(${tmp_zero_array[@]})
    else
      ox_epurator=(${tmp_one_array[@]})
  fi
  count=0
}

for (( i=1; i<$line_length; i++ ))
  do
    set_ox_generator $i
    set_ox_epurator $i
done

ox_generator_power=$( IFS=$''; echo "${ox_generator[*]}" )
ox_epurator_rating=$( IFS=$''; echo "${ox_epurator[*]}" )

echo ${ox_generator[@]}
echo ${ox_epurator[@]}

((survival_rating=$((2#$ox_generator_power))*$((2#$ox_epurator_rating))))
echo $survival_rating

exit