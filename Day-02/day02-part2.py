#!/usr/bin/python

ids = []
with open("input.txt") as file:
	for line in file:
		ids.append(line.replace('\n', ''))

maxdiff = ''

for id1 in ids:
	for id2 in ids:
		if id1 == id2:
			break

		diff = ''
		for i in range(len(id1)):
			if id1[i] == id2[i]:
				diff += id1[i]

		if len(diff) > len(maxdiff):
			maxdiff = diff

print maxdiff
