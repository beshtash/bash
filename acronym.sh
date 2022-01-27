##/usr/bin/env bash
# Get the phrase from user.
array=()
IFS=' '
while  read -r -p "Enter the phrase, on second prompt just enter empty line:  " line; 
do
  [[ $line ]] || break # break if line is empty
  array+=( "$line" )
done
printf '%s\n' "Items read: "
printf '%s\n' "${array[@]}"

bar=()
IFS=''
for f in "${array[@]}"; do
  echo "$f"
  bar+=( "${f:0:1}" )
done 


printf '%s\n' "${bar[@]}"
