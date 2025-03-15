#!/usr/bin/env python3

from os import system as do

programs = [
    "mef/print",
    "mbf/print",
]

do("mkdir -p ./bin/mbf")
do("mkdir -p ./bin/mef")

for program_name in programs:
    print(f"START building {program_name}.cbl")
    print(f"DONE  at ./bin/{program_name}.")
    do(f"cobc -O -free -x {program_name}.cbl -o ./bin/{program_name}")
