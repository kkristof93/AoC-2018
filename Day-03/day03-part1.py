#!/usr/bin/python

import re

def parse(line):
	pattern = re.compile('#(\d+) @ (\d+),(\d+): (\d+)x(\d+)')
	match = pattern.match(line)

	return (int(match.group(1)), int(match.group(2)), int(match.group(3)), 
		int(match.group(4)), int(match.group(5)))

fabric = {}
with open("input.txt") as file:
	for line in file:
		(id, x, y, w, h) = parse(line)

		for i in range(x, x + w):
			for j in range(y, y + h):
				fabric[(i, j)] = fabric.get((i, j), 0) + 1

sum = reduce(lambda count, i: count + (1 if i >= 2 else 0), fabric.values(), 0)
print sum
