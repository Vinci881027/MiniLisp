#!/bin/bash

# compile
bison -d -o y.tab.c fp.y
gcc -c -g -I.. y.tab.c
flex -o lex.yy.c fp.l
gcc -c -g -I.. lex.yy.c
gcc -o fp y.tab.o lex.yy.o -ll

# remove unnecessary files
rm y.tab.c
rm y.tab.h
rm y.tab.o
rm lex.yy.c
rm lex.yy.o
