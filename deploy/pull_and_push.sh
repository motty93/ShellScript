#!/bin/bash

# git pull & push current branch function
g ()
{
  branch=`git rev-parse --abbrev-ref HEAD`

  if [ "$(uname)" == 'Darwin' ]; then
    rsa_path=`mdfind -name github_rsa | grep -v pub | grep ssh`
  else
    rsa_path=`locate -b -r "^github_rsa$"`
  fi

  expect -c "
  set timeout 10
  spawn git $1 origin $branch
  expect {
    \"Username for 'https://github.com': \" {
      send \"$GITHUB_NAME\n\"
      expect \"Password for 'https://$GITHUB_NAME@github.com': \"
      send \"$GITHUB_PASSWORD\n\"
    }
    \"Enter passphrase for key '$rsa_path':\" {
      send \"$SSH_PASSWORD\n\"
    }
  }

  interact
  "
}


export GITHUB_NAME="your_github_name"
export GITHUB_PASSWORD="your_github_password"
export SSH_PASSWORD="your_ssh_password"

alias push="g push"
alias pull="g pull"
