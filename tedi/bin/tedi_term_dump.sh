#!/usr/bin/env bash

l_pid=${1}

if [[ -z "${l_pid}" ]]; then
  echo "you must specify the pid of the go program" 
  echo "usage: $(basename ${0}) [pid]"
  exit 1
fi

kill -ABRT ${l_pid}
