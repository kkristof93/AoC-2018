const fs = require('fs');

const file = fs.readFileSync('input.txt', 'utf8');
const lines = file.split('\n');

let pots = [];
let startIndex = 0;
let patterns = [];
const generations = 50000000000;

let i = 0;
for (line of lines) {
	switch (i) {
		case 0:
			const initial = line.replace('initial state: ', '');
			for (let j = 0; j < initial.length; j++) {
				pots[j] = initial.charAt(j);
			}
			break;
		case 1:
			break;
		default:
			const parts = line.split(' => ');
			patterns.push({
				pattern: parts[0],
				next: parts[1]
			})
	}
	i++;
}

let prevSum = 0;
let prevDiff = 0;

for (i = 0; i < generations; i++) {
	let newPots = [];
	for (let j = -2; j < pots.length + 1; j++) {
		const current = [-2, -1, 0, 1, 2].map(c => pots[j + c] || '.').join('');
		const pattern = patterns.find(p => p.pattern === current);

		if (pattern.next === '#' && j < 0) {
			newPots.push(pattern.next);
			startIndex -= 1;
			for (let k = j + 1; k < 0; k++) {
				newPots.push('.');
				startIndex -= 1;
			}
		} else if (pattern.next === '#' && j >= pots.length) {
			for (let k = pots.length; k < j; k++) {
				newPots.push('.');
			}
			newPots.push(pattern.next);
		} else if (j >= 0 && j < pots.length) {
			newPots.push(pattern.next);
		}
	}
	pots = newPots;

	let sum = 0;
	for (let j = 0; j < pots.length; j++) {
		if (pots[j] === '#') {
			sum += j + startIndex;
		}
	}
	const diff = sum - prevSum;

	if (diff == prevDiff) {
		break;
	}

	prevSum = sum;
	prevDiff = diff;
}

const sum = prevSum + (generations - i) * prevDiff;
console.log(sum);

