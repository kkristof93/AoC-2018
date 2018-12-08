#!/usr/bin/python

def react(polymer):
	i = 0
	while i + 1 < len(polymer):
		if (polymer[i].isupper() and polymer[i + 1].islower() and polymer[i] == polymer[i + 1].upper()) or \
			(polymer[i].islower() and polymer[i + 1].isupper() and polymer[i] == polymer[i + 1].lower()):
			polymer = polymer[0:i] + polymer[i + 2:]
			i -= 1
		else:
			i += 1

	return polymer

def char_range(c1, c2):
    for c in xrange(ord(c1), ord(c2) + 1):
        yield chr(c)

polymer = ''
with open('input.txt') as file:
	polymer = file.readlines()[0]

length = []
for char in char_range('a', 'z'):
	removed = polymer.replace(char, '').replace(char.upper(), '')
	reacted = react(removed)
	length.append(len(reacted))

print min(length)
