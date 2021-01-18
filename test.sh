#!/bin/bash

# test case
for file in test_data/*; do
    echo -e "\n${file##*/}"
    ./fp <"$file"
done
