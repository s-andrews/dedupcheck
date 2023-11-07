#!/bin/bash
head -c 200M </dev/urandom > file1
head -c 200M </dev/urandom > file2
cp file1 dup1
mkdir subdir
cd subdir/
cp ../file2 ./dup2
cd ..
head -c 150M file1 > notdup1
ln file2 notdup2