#!/bin/bash

text="Welcome to LinuxHint"
IFS=' '
read -a strarr  <<< "$text"
echo "There are ${#strarr[*]} words in the text."
for val in "${strarr[@]}";
do
  printf "$val\n"
done

