#!/bin/bash

echo "Enter the phrase: "
read text
IFS=''
read -a strarr <<< "$text"

echo "There are ${#strarr[*]} words in the text."

bar=()
IFS=''
for val in "${strarr[@]}";
do
  bar+=${val:0:1}
done
echo $bar[@]

