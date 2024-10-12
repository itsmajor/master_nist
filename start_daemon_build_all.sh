#! /bin/bash

./build_all.sh > build_all.log 2>&1 &
tail -f build_all.log
