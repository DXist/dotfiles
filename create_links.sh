#!/bin/bash
for file in `ls -d .??* |egrep -v "(.git$)|~"`
do
	ln -sf `pwd`/$file ~/$file
done
