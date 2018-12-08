#!/usr/bin/python

polymer = ''
with open('input.txt') as file:
	polymer = file.readlines()[0]

i = 0
while i + 1 < len(polymer):
	if (polymer[i].isupper() and polymer[i + 1].islower() and polymer[i] == polymer[i + 1].upper()) or \
		(polymer[i].islower() and polymer[i + 1].isupper() and polymer[i] == polymer[i + 1].lower()):
		polymer = polymer[0:i] + polymer[i + 2:]
		i -= 1
	else:
		i += 1

print len(polymer)
