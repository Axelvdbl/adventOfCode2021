#!/usr/bin/python

file1 = open('../records_moves.txt', 'r')
Lines = file1.readlines()

abcissa = 0
ordinate = 0
aim = 0

for line in Lines:
    line_dir = line.split(" ")
    if line_dir[0] == "forward":
        abcissa += int(line_dir[1])
        ordinate += aim * int(line_dir[1])
    elif line_dir[0] == "down":
        aim += int(line_dir[1])
    elif line_dir[0] == "up":
        aim -= int(line_dir[1])

print (abcissa * ordinate)