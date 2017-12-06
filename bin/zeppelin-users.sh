#!/usr/bin/env bash

base_psw="psl-ds-lab-2017"

for i in {1..40}
  do
    user="user$i"
    password=$(echo -n "$base_psw$i" | shasum -a 256 | awk -F ' ' '{print $1}')
    echo "$user = $password, role3" >> shiro-users.txt
  done
