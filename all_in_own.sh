#!/bin/bash

### time execution
START=$(date+%s)

vagrant up
sleep 60
./oc-up.sh

### $DIFF equals script execution on minutes
END=$(date+%s)
DIFF=$(($END - $START))
DIFF=$(($DIFF/60))

echo $DIFF
