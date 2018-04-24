#! /bin/bash

# git clone script
# prompt user for url to clone
# "read [option] var1 var2 varN"
# p == prompt

# prompt user for url
read -p "What is the github repo URL?" varURL

# git clone command
git clone $varURL
