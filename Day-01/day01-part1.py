#!/usr/bin/python

sum = 0

with open("input.txt") as file:
	for line in file:
		sum += int(line)

print sum
