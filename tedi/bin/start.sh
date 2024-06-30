#!/usr/bin/env bash

cd $(dirname ${0}) || exit 1

nohup ./tedi_start.sh >/dev/null 2>&1 &
