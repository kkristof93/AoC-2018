#!/usr/bin/python

import re

def parse(line):
	pattern = re.compile('#(\d+) @ (\d+),(\d+): (\d+)x(\d+)')
	match = pattern.match(line)

	return (int(match.group(1)), int(match.group(2)), int(match.group(3)), 
		int(match.group(4)), int(match.group(5)))

fabric = {}
overlaps = {}

with open("input.txt") as file:
	for line in file:
		(id, x, y, w, h) = parse(line)
		overlaps[id] = False

		for i in range(x, x + w):
			for j in range(y, y + h):
				fabric[(i, j)] = fabric.get((i, j), []) + [id]

				if len(fabric[(i, j)]) > 1:
					for k in fabric[(i, j)]:
						overlaps[k] = True

for id, overlap in overlaps.items():
	if not overlap:
		print id
		break
