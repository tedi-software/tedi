#!/usr/bin/env bash

l_input=${1}
l_output=${2}

if [[ -z "${l_input}" ]]
then
    echo "no input file provided"
    exit 1
fi

if [[ -z "${l_output}" ]]
then
    echo "no output file provided"
    exit 1
fi

echo "starting external command: $(basename ${0})"

echo >> "${l_output}"
echo "scale=1000; 4*a(1)" | bc -l >> "${l_output}"
l_rc=$?

echo "finished external command"

exit ${l_rc}