#! /bin/bash

#git commit script
# get user input for comment before committing git update
# "read [option] var1 var2 varN
# p == prompt

# promt user for value
read -p "enter your comment for git commit." var1

# commit the add
git commit -m "$var1"

# clear var
var1=""
