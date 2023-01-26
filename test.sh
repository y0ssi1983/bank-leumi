#!/bin/bash

TEST=$(curl "$(terraform output -raw base_url)/hello" | grep -c "Hello")

if [ $TEST -eq "1" ]
then
    echo "###### TESTING ######"
    echo "test pass"
else
    echo "###### TESTING ######"
    echo "test failed"
fi