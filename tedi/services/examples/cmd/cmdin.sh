#!/usr/bin/env bash

echo "scale=1000; 4*a(1)" | bc -l 

exit $?
