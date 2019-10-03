#!/bin/bash

branch=$(git rev-parse --abbrev-ref HEAD)

expect -c "
set timeout 10
spawn git push origin $branch
expect \"Enter passphrase for key '/home/$USER/.ssh/secret_keys/github_rsa':\"
send \"password\n\"
interact
"
