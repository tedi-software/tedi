#!/usr/bin/env bash

l_input=${1}

if [[ -z "${l_input}" ]]
then
    echo "no file provided"
    exit 1
fi

echo "starting external command: $(basename ${0})"

echo "scale=1000; 4*a(1)" | bc -l >> "${l_input}"
l_rc=$?

echo "finished external command"

exit ${l_rc}
