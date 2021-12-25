#!/bin/bash
nasm -felf64 $1 -o output.o && ld output.o && ./a.out