#!/usr/bin/python

sum = 0
frequencies = [0]
changes = []

with open("input.txt") as file:
	for line in file:
		changes.append(int(line))

print changes

i = 0
while True:
	sum += changes[i]

	if sum in frequencies:
		break

	frequencies.append(sum)
	i = (i + 1) % len(changes)

print sum
