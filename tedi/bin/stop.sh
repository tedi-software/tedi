#!/usr/bin/env bash

cd $(dirname ${0}) || exit 1

. ./setenv.sh

if [[ -e ${TEDI_PID} ]]
then
    kill -SIGINT $(<${TEDI_PID})
    rm ${TEDI_PID}
else
    echo "${TEDI_PID} does not exist"
fi
