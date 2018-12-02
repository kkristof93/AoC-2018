#!/usr/bin/python

twos = 0
threes = 0

with open("input.txt") as file:
	for line in file:
		letters = {}

		for c in line:
			if c == '\n':
				continue

			letters[c] = letters.get(c, 0) + 1

		if 2 in letters.values():
			twos += 1
		if 3 in letters.values():
			threes += 1

print(twos * threes)
