#!/usr/bin/python

import re

lines = []
with open("input.txt") as file:
	lines = file.readlines()

lines.sort()

record_pattern = re.compile('\[(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] (.*)')
guard_pattern = re.compile('Guard #(\d+) begins shift')

minutes = {}
id = 0
start_min = 0

for line in lines:
	match = record_pattern.match(line)
	(year, month, day, hour, minute, record) = (int(match.group(1)), int(match.group(2)),
		int(match.group(3)), int(match.group(4)), int(match.group(5)), match.group(6))

	if record == 'falls asleep':
		start_min = minute
	elif record == 'wakes up':
		while start_min != minute:
			guards = minutes.get(start_min, {})
			guards[id] = guards.get(id, 0) + 1
			minutes[start_min] = guards

			start_min += 1
	else:
		id = int(guard_pattern.match(record).group(1))

top_guards = {}
for minute, guards in minutes.items():
	(top_id, times) = next(iter(sorted(guards.items(), key = lambda g: g[1], reverse = True)))
	top_guards[minute] = (times, top_id)

(top_minute, (times, top_id)) = next(iter(sorted(top_guards.items(), key = lambda m: m[1][0], reverse = True)))

print top_id * top_minute
