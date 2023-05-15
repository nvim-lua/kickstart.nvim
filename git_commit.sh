#!/bin/bash --login
if [[ $1 != "" && $2 != "" && $3 != "" ]]; then
  # Default Strategy is to merge codebase
  git config pull.rebase false
  git config commit.gpgsign true
  git pull origin master
  git add . --all
  git commit -a -S --author="${1} <${2}>" -m "${3}"
  git push -u origin master
else
  echo "USAGE: ${0} '<full name>' <email address> '<git commit comments>'"
fi
