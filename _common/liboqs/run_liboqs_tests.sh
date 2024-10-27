#!/bin/bash

if [ ! -d "~/workspace/liboqs/build" ]
  echo "~/workspace/liboqs/build not found - run prepare_liboqs.sh first"
fi


cd ~/workspace/liboqs/build

#complete test suite
ninja run_tests