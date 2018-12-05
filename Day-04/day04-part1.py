#!/usr/bin/python

import re

lines = []
with open("input.txt") as file:
	lines = file.readlines()

lines.sort()

record_pattern = re.compile('\[(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] (.*)')
guard_pattern = re.compile('Guard #(\d+) begins shift')

guards = {}
id = 0
start_min = 0

for line in lines:
	match = record_pattern.match(line)
	(year, month, day, hour, minute, record) = (int(match.group(1)), int(match.group(2)),
		int(match.group(3)), int(match.group(4)), int(match.group(5)), match.group(6))

	if record == 'falls asleep':
		start_min = minute
	elif record == 'wakes up':
		(total, minutes_sleep) = guards[id]
		
		period = 0
		while start_min + period != minute:
			minutes_sleep[start_min + period] = minutes_sleep.get(start_min + period, 0) + 1
			period += 1

		guards[id] = (total + period, minutes_sleep)
	else:
		id = int(guard_pattern.match(record).group(1))
		if id not in guards:
			guards[id] = (0, {})

(top_id, (total, minutes)) = next(iter(sorted(guards.items(), key = lambda g: g[1][0], reverse = True)))
(top_minute, _) = next(iter(sorted(minutes.items(), key = lambda m: m[1], reverse = True)))

print top_id * top_minute
