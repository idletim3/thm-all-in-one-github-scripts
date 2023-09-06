#!/bin/bash

bright_blue='\033[1;96m'  # Brighter blue in bold
bright_green='\033[1;92m'  # Brighter green in bold
red='\033[0;31m'
nocolor='\033[0m'

current_color="$bright_blue"
first_result=true

while getopts ":d:f:p:" opt; do
  case $opt in
    d) directory="$OPTARG" ;;
    f) file="$OPTARG" ;;
    p) phrase="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

if [ -z "$directory" ] || [ -z "$file" ] || [ -z "$phrase" ]; then
  echo "Usage: $0 -d <directory> -f <file> -p <phrase>"
  exit 1
fi

for file_path in $(find "$directory" -name "$file"); do
  found=false

  while IFS= read -r line; do
    if [[ $line == *"$phrase"* ]]; then
      if ! $found; then
        if ! $first_result; then
          echo
        fi
        echo -e "\033[1;${current_color}${file_path}\033[0m"
        found=true
        first_result=false
      fi

      line="${line//$phrase/$red$phrase$nocolor}"
      echo -e "${line}"
    fi
  done < "$file_path"

  if $found; then
    if [[ "$current_color" == "$bright_blue" ]]; then
      current_color="$bright_green"
    else
      current_color="$bright_blue"
    fi
  fi
done
