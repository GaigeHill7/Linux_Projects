# Linux commands and fundamentals explained

## Shebang (#!/bin/bash):
- Runs the script using bash
- This tells Linux OS what language the file is written in. Failure to include may cause OS to use the wrong interpreter, breaking scripts.

## "$1"
- This is the first argument given to the script
- Ex. jump.sh /home --- $1 = /home

## Local Variable
- Only visible inside the function

## Array variables
- Defines like "local -a path_arr"
- -a tells bash that it is an array variable

## What is IFS
- Internal Field Separator
- This tells Bash what characters should be treated as "split here"
- This is what tells Bash how to split words or fields
- Ex/ IFS = "/" will split /home/anthony/projects/linux into
- "home" "anthony" ...

## $PWD
- This is the systems working directory

## read -a path_arr <<< "$PWD"
- stores working directory into an array

## ${#array[@]}
- Returns the number of elements in the array