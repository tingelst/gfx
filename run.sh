#!/bin/bash

#BUILDS AND RUNS ONLY SINGLE FILE 
echo Compiling and Running $1

DIRECTORY=`dirname $1`
TARGET=`basename $1|cut -d'.' -f1 | sed -e "s|/|_|g"`

echo Directory is $DIRECTORY
echo Target is $TARGET

mkdir -p build
cd build

rm bin/$TARGET

if [ $2 = "configure" ]; then
  cmake ..
fi

make $TARGET
./bin/$TARGET
